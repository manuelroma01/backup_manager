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
  
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  @mac_regex = /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
  
  validates :tag, :presence => true,
    :uniqueness => true
  validates :ip_address, :presence => true,
    :uniqueness => true,
    :format => { :with => @ip_regex }
  validates :mac_address, :presence => true,
    :uniqueness => true,
    :format => { :with => @mac_regex }
end
