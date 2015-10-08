class Area < ActiveRecord::Base
  # FIELDS: name, department, specia_access, map, notes, floor_id, location_id

  ## RELATIONS
  belongs_to :location
  belongs_to :floor
  has_many :computers

  ## VALIDATIONS
  validates :name, :location, :floor, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active areas
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS

  # Attaches computers to this area by going throw a list of IPs (each ip on new line)
  def attach_computers(ip_list)
    return if ip_list.blank?
    sanitized_ips = ip_list.lines.collect { |ip| ip.rstrip }
    computers = Computer.where("ip in (?)", sanitized_ips)

    Computer.transaction do
      computers.each do |c|
        c.area = self
        c.location = self.location
        c.floor = self.floor
        c.save(validate: false)
      end
    end

  end

end
