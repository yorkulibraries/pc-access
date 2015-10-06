class Area < ActiveRecord::Base
  # FIELDS: name, department, specia_access, map, notes, floor_id, location_id

  ## RELATIONS
  belongs_to :location
  belongs_to :floor

  ## VALIDATIONS
  validates :name, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active areas
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS

end
