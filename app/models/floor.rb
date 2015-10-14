class Floor < ActiveRecord::Base

  # FIELDS: name, position, map, location_id, deleted

  ## UPLOADER
  mount_uploader :map, MapUploader

  ## RELATIONS
  belongs_to :location
  has_many :areas
  has_many :computers

  ## VALIDATIONS
  validates :name, presence: true
  validates :position, :location, presence: true

  ## SCOPES
  default_scope { where(deleted: false).order(:position) } # only active floors
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS

end
