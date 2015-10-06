class ComputerActivityLog < ActiveRecord::Base
  # FIELDS: computer_id, ip, activity_date, action, username

  ## CONSTANTS
  ACTION_PING = "ping"
  ACTION_REGISTER = "register" # very first action
  ACTION_LOGON = "logon"
  ACTION_LOGOFF = "logoff"
  ACTION_LOGOFF_INACTIVE = "logoff_inactive"

  ## RELATIONS
  belongs_to :computer

  ## VALIDATIONS
  validates :computer_id, presence: true
  validates :ip, :action, presence: true

  ## SCOPES
  default_scope { where(deleted: false) } # only active floors
  scope :deleted, -> { unscoped.where(deleted: true) }

  ## METHODS
end
