class Location < ActiveRecord::Base
  # FIELDS: name, ip_subnets, deleted

  ## RELATIONS
  has_many :computers

  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :ip_subnets, uniqueness: true, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active images
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS


end
