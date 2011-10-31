class Equipment < ActiveRecord::Base
  # acceso
  attr_accessible :tag, :equipment_type, :equipment_model, :ip_address, :mac_address, :location, :equipment_user
  
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  @mac_regex = /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
  
  # config will_paginate
  cattr_reader :per_page
  @@per_page = 10

  # validaciones  
  validates :tag, :presence => true,
    :uniqueness => true
  validates :equipment_type, :presence => true
  validates :ip_address, :presence => true,
    :uniqueness => true,
    :format => { :with => @ip_regex }
  validates :mac_address, :presence => true,
    :uniqueness => true,
    :format => { :with => @mac_regex }
  validates :location, :presence => true
    
  # funciones públicas    
  def online?
    find_ws = Net::Ping::External.new(self.ip_address, timeout=1)
    return find_ws.ping?
  end
end

# == Schema Information
#
# Table name: equipments
#
#  id              :integer         not null, primary key
#  tag             :string(10)      not null
#  equipment_type  :string(15)      not null
#  equipment_model :string(30)
#  ip_address      :string(15)      not null
#  mac_address     :string(17)      not null
#  location        :string(10)
#  equipment_user  :string(15)
#  created_at      :datetime
#  updated_at      :datetime
#

