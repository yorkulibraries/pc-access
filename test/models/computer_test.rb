require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  setup do
      @before_interval = (Computer::STAY_ALIVE_INTERVAL - 5.minute).ago
      @after_interval =  (Computer::STAY_ALIVE_INTERVAL + 5.minutes).ago
  end

  should "create a valid computer and recored a Register Action in activity Log" do
    c = build(:computer)

    assert_difference ["Computer.count", "ComputerActivityLog.count"],  1 do
      c.save
      assert_equal 1, c.activity_entries.size,  "Should be one"

      entry = c.activity_entries.first
      assert_equal ComputerActivityLog::ACTION_REGISTER, entry.action, "First action should be register"
      assert_equal c.ip, entry.ip, "ip should be the same"
      assert_equal c.current_username, entry.username, "usernames should match"
      assert_not_nil entry.activity_date, "Date should be set"

    end
  end

  should "not create an invalid computer" do

    assert ! build(:computer, ip: nil).valid?, "IP is required"
    assert ! build(:computer, ip: "dljaflsda", hostname: nil).valid?, "IP Should be a valid ip"

    create(:computer, ip: "10.0.0.1")
    assert ! build(:computer, ip: "10.0.0.1").valid?, "IP Should be unique"
  end


  should "return correct numbers of pcs in use and not inuse" do

    create_list(:computer, 2, current_username: nil) # 2 not in use
    create_list(:computer, 3, current_username: "blah") # 3 in use

    assert_equal 3, Computer.in_use.count, "3 In Use"
    assert_equal 2, Computer.not_in_use.count, "2 Not In Use. Total: #{Computer.all.count}"

  end

  should "return correct number of pcs pinging and not pinging" do

    create_list(:computer, 2, last_ping: @after_interval ) # not pinging
    create_list(:computer, 4, last_ping: @before_interval) # pinging
    create_list(:computer, 3, last_ping: nil) # never pinging

    assert_equal 2, Computer.not_pinging.count
    assert_equal 4, Computer.pinging.count
    assert_equal 3, Computer.never_ping.count
  end

  should "return correct number of pcs keeping alive and not keeping alive" do

    create_list(:computer, 2, last_user_activity: @after_interval ) # not keeping alive
    create_list(:computer, 4, last_user_activity: @before_interval) # keeping alive
    create_list(:computer, 3, last_user_activity: nil) # never kept alive

    assert_equal 2, Computer.not_staying_active.count, "Not Keeping Alive Should be 2"
    assert_equal 4, Computer.staying_active.count, "should be 4"
    assert_equal 3, Computer.never_used.count, "should be 3"
  end

  ### ADDITIONAL METHODS TESTS ###

  should "free inactive computers" do
    # self.in_use.not_staying_active.each do |pc|
    #   Rails.logger.info("#{pc.ip} not_staying_active => logging off")
    #   pc.logoff
    #   pc.save
    # end

    create_list(:computer, 2, last_user_activity: @after_interval)
    create_list(:computer, 3, last_user_activity: @before_interval)

    # check before
    assert_equal 2, Computer.not_staying_active.count, "2 in use but not keeping alive"
    assert_equal 5, Computer.in_use.count, "5 in use,in total"

    Computer.free_inactive_computers

    # check after
    assert_equal 2, Computer.not_staying_active.count, "Should still be two, but they are not in use"
    assert_equal 3, Computer.in_use.count, "3 computers still in use"
    assert_equal 2, Computer.not_in_use.count, "2 Not In Use"
  end

  should "Free Inactive Computers should register a ACTION_LOGOFF_INACTIVE" do
    c = create(:computer, last_user_activity: @after_interval)

    assert_difference "ComputerActivityLog.count", 1 do
      Computer.free_inactive_computers
      entry = ComputerActivityLog.last
      assert_equal  ComputerActivityLog::ACTION_LOGOFF_INACTIVE, entry.action, "should be logoff inactive"
    end
  end

  should "return true or false, testing if computer is in use" do
    not_used = create(:computer, current_username: nil)
    used = create(:computer, current_username: "billy")

    assert used.is_in_use, "In use"
    assert ! not_used.is_in_use, "Not in use"
  end

  ## TRACKING METHODS

  should "logon and logoff a computer" do
    pc = create(:computer, current_username: nil, previous_username: nil, last_user_activity: nil)

    pc.logon("james")

    assert_equal "james", pc.current_username, "Current username has been recorded"
    assert_not_nil pc.last_user_activity, "Keep alive was set"

    pc.logoff
    assert_nil pc.current_username, "Current username should be reset"
    assert_equal "james", pc.previous_username, "Previous username should be james"

    pc.logon("jeremy")

    assert_equal "jeremy", pc.current_username, "Current username should be jeremy"
    assert_equal "james", pc.previous_username, "Previous username should be james"
  end

  should "ping and keep alive a computer" do
    pc = create(:computer, last_ping: nil, last_user_activity: nil)

    pc.ping
    assert_not_nil pc.last_ping, "Last Ping was set"

    pc.stay_alive
    assert_not_nil pc.last_user_activity, "Keep alive was set"
  end


  should "detach computers from area" do
    a = create(:area)
    c = create(:computer, area_id: a.id, location_id: a.location.id, floor_id: a.floor.id)
    assert_equal 1, a.computers.count, "one computer attached"
    Computer.detach_from_area(a.id)
    assert_equal 0, a.computers.count, "should be zero"
  end

  should "detach computers from image" do
    i = create(:image)
    c = create(:computer, image_id: i.id)
    assert_equal 1, i.computers.count, "one computer attached"
    Computer.detach_from_image(i.id)
    assert_equal 0, i.computers.count, "should be zero"
  end

  should "show not available computers" do
     list = create_list(:computer, 3, current_username: "someone", last_ping: DateTime.now)

     assert_equal list.size, Computer.all.size, "Should be matching, with all call"
     assert_equal list.size, Computer.pinging.size, "Should match on pinging"
     assert_equal list.size, Computer.in_use.size, "Should match on not_in_use #{Computer.not_in_use.to_sql}"
     assert_equal list.size, Computer.pinging.in_use.size, "Should match, with pinging and not_in_use"

     assert_equal list.size, Computer.unavailable.size, "Should be matching, with unavailable"

     create(:computer, current_username: nil)

     assert_equal list.size, Computer.unavailable.size, "Should be matching, with unavailable"
  end


  should "show available computers, negation of unavailable" do
    on_no_user =  create(:computer, current_username: nil)

    assert_equal 1, Computer.all.count, "One computer"
    assert_equal 1, Computer.available.count, "One available #{ Computer.available.to_sql}"

    off_no_user = create(:computer, last_ping: nil)

    assert_equal 2, Computer.all.count, "One computer"
    assert_equal 2, Computer.available.count, "Two available"

    on_with_user = create(:computer, current_username: "someone", last_ping: DateTime.now)

    assert_equal 3, Computer.all.count, "Two computers"
    assert_equal 2, Computer.available.count, "Should be two, #{ Computer.unavailable.count}"

  end


end
