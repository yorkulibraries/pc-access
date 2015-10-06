class Floor < ActiveRecord::Base

  # FIELDS: name, position, map, location_id, deleted

  ## RELATIONS
  belongs_to :location
  has_many :areas

  ## VALIDATIONS
  validates :name, presence: true
  validates :position, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active floors
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS

end
