require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  setup do
      @before_interval = (Computer::KEEP_ALIVE_INTERVAL - 1.minute).ago
      @after_interval =  (Computer::KEEP_ALIVE_INTERVAL + 2.minutes).ago
  end

  should "create a valid computer" do
    c = build(:computer)

    assert_difference "Computer.count", 1 do
      c.save
    end
  end

  should "not create an invalid computer" do

    assert ! build(:computer, ip: nil).valid?, "IP is required"
    assert ! build(:computer, ip: "dljaflsda").valid?, "IP Should be a valid ip"

    create(:computer, ip: "10.0.0.1")
    assert ! build(:computer, ip: "10.0.0.1").valid?, "IP Should be unique"
  end


  should "return correct numbers of pcs in use and not inuse" do

    create_list(:computer, 2, current_username: nil) # 2 not in use
    create_list(:computer, 3, current_username: "blah") # 3 in use

    assert_equal 3, Computer.in_use.count, "3 In Use"
    assert_equal 2, Computer.not_in_use.count, "3 In Use"

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

    create_list(:computer, 2, last_keep_alive: @after_interval ) # not keeping alive
    create_list(:computer, 4, last_keep_alive: @before_interval) # keeping alive
    create_list(:computer, 3, last_keep_alive: nil) # never kept alive

    assert_equal 2, Computer.not_keeping_alive.count, "Not Keeping Alive Should be 2"
    assert_equal 4, Computer.keeping_alive.count, "should be 4"
    assert_equal 3, Computer.never_used.count, "should be 3"
  end

  ### ADDITIONAL METHODS TESTS ###

  should "free inactive computers" do
    # self.in_use.not_keeping_alive.each do |pc|
    #   Rails.logger.info("#{pc.ip} not_keeping_alive => logging off")
    #   pc.logoff
    #   pc.save
    # end

    create_list(:computer, 2, last_keep_alive: @after_interval)
    create_list(:computer, 3, last_keep_alive: @before_interval)

    # check before
    assert_equal 2, Computer.not_keeping_alive.count, "2 in use but not keeping alive"
    assert_equal 5, Computer.in_use.count, "5 in use,in total"

    Computer.free_inactive_computers

    # check after
    assert_equal 2, Computer.not_keeping_alive.count, "Should still be two, but they are not in use"
    assert_equal 3, Computer.in_use.count, "3 computers still in use"
    assert_equal 2, Computer.not_in_use.count, "2 Not In Use"
  end




end
