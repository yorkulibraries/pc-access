class Image < ActiveRecord::Base
  # FIELDS: name, os_name, os_version, deleted

  ## RELATIONS
  has_many :computers

  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :os_name, :os_version, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active images
  scope :deleted, -> { unscoped.where(deleted: true) }
end
