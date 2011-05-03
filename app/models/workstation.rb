# == Schema Information
# Schema version: 20110411215645
#
# Table name: workstations
#
#  id          :integer         not null, primary key
#  tag         :string(10)      not null
#  ip_address  :string(15)      not null
#  mac_accress :string(17)      not null
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Workstation < ActiveRecord::Base
  attr_accessible :tag, :ip_address, :mac_address
  
  validates :tag, :presence => true,
    :uniqueness => true
  validates :ip_address, :presence => true,
    :uniqueness => true
  validates :mac_address, :presence => true,
    :uniqueness => true
end
