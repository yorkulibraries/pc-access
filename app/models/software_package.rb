class SoftwarePackage < ActiveRecord::Base

  ## RELATIONS
  belongs_to :image

  ## VALIDATIONS
  validates_presence_of :name
end
