class Location < ActiveRecord::Base
  # FIELDS: name, ip_subnets, address, floors deleted  

  ## RELATIONS
  has_many :computers
  has_many :floors
  has_many :areas

  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active images
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## CALLBACKS
  after_create :create_first_floor

  ## METHODS
  def create_first_floor
    floor = Floor.new
    floor.location = self
    floor.name = "1st Floor"
    floor.position = 1
    floor.save(validate: false)
  end


end
