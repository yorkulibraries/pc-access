class Server < ActiveRecord::Base

  ## Constants
  OS_NAMES = ["Ubuntu", "CentOS", "Fedora", "Debian", "Red Hat", "Slackware", "openSUSE", "Linux Mint", "Gentoo", "Other Linux", "Windows", "OS X"]


  ## VALIDATIONS
  validates :local_ip, :presence => true, :uniqueness => true
  validate :valid_ip



  ## PRIVATE
  private

  def valid_ip
    unless IPAddress.valid?(local_ip)
      errors.add(:local_ip, "Invalid IP address")
    end
  end

end
