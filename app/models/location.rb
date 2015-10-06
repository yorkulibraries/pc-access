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

  ## METHODS


end
