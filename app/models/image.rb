class Image < ActiveRecord::Base
  # FIELDS: name, os_name, os_version

  ## RELATIONS
  has_many :computers

  ## VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :os_name, :os_version, presence: true
  
  ## SCOPES

end
