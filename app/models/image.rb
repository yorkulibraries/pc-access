class Image < ActiveRecord::Base
  # FIELDS: name, os_name, os_version, deleted

  ## CONSTANTS
  OS_NAMES = ["Windows", "OS X", "Linux", "Android", "iOS"]


  ## RELATIONS
  has_many :computers
  has_many :software, class_name: "SoftwarePackage"


  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :os_name, :os_version, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active images
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS

  # Attaches computers to this image by going throw a list of IPs (each ip on new line)
  def attach_computers(ip_list)
    return if ip_list == nil

    # detach computers from image first
    Computer.detach_from_image(self[:id])

    sanitized_ips = ip_list.lines.collect { |ip| ip.rstrip }
    new_computers = Computer.where("ip in (?)", sanitized_ips)


    Computer.transaction do
      new_computers.each do |c|
        c.image = self
        c.save(validate: false)
      end
    end

  end
end
