require 'spec_helper'

describe Equipment do
  before(:each) do
    @ws_attr = {
      :tag => 'www.google.com',
      :equipment_type => 'server',
      :equipment_model => 'google web server',
      :ip_address => '209.85.146.104',
      :mac_address => '20-cf-30-e8-4b-4c',
      :location => 'Googleplex',
      :user => 'Saint Google'
    }
    
    @ws_attr_2 = {
      :tag => 'www.creal.cat',
      :equipment_type => 'workstation',
      :equipment_model => 'creal web server',
      :ip_address => '193.144.6.2',
      :mac_address => '54-87-e6-8d-52-10',
      :location => 'CPD',
      :user => 'Er paco'
    }
  end
  
  it "should create a new instance given valid attributes" do
    Equipment.create!(@ws_attr)
  end
  
  describe "validations" do
    it "should require a tag" do Equipment.new(@ws_attr.merge(:tag => "")).should_not be_valid end
    it "should require an equipment_type" do Equipment.new(@ws_attr.merge(:equipment_type => "")).should_not be_valid end
    it "should require an ip_address" do Equipment.new(@ws_attr.merge(:ip_address => "")).should_not be_valid end
    it "should require a mac_address" do Equipment.new(@ws_attr.merge(:mac_address => "")).should_not be_valid end
    it "should require a location" do Equipment.new(@ws_attr.merge(:location => "")).should_not be_valid end      
  end
  
  # validación formato atributos
  describe "validates attr format" do
    it "should accept valid ip addresses" do
      ip_adresses = ['127.0.0.1', '172.20.32.58', '194.255.127.10']
      ip_adresses.each do |ip_address|
        Equipment.new(@ws_attr.merge(:ip_address => ip_address)).should be_valid
      end
    end
   
    it "should reject invalid ip addresses" do
      ip_addresses = ['654.0.5.2', '456854.12.4', '172.20.32']
      ip_addresses.each do |ip_address|
        Equipment.new(@ws_attr.merge(:ip_address => ip_address)).should_not be_valid
      end
    end
    
    it "should reject duplicated ip addresses" do
      test_ws = Equipment.create!(@ws_attr)
      Equipment.new(@ws_attr_2.merge(:ip_address => test_ws.ip_address)).should_not be_valid
    end
   
    it "should accept valid mac addresses" do
      mac_addresses = ['20-cf-30-e8-4b-4c', '54-87-e6-8d-52-10', '00-ab-54-65-7a-01']
      mac_addresses.each do |mac_address|
        Equipment.new(@ws_attr.merge(:mac_address => mac_address)).should be_valid
      end
    end
    
    it "should reject invalid mac addresses" do
      mac_addresses = ['20-150-30-e8-4b-4c', '54-87-lk-8d-52-10', '00-ab-54-7a-01']
      mac_addresses.each do |mac_address|
        Equipment.new(@ws_attr.merge(:mac_address => mac_address)).should_not be_valid
      end
    end
    
    it "should reject duplicated mac addresses" do
      test_ws = Equipment.create!(@ws_attr)
      Equipment.new(@ws_attr_2.merge(:mac_address => test_ws.mac_address)).should_not be_valid
    end   
  end
  
  # ping
  describe "equipment online?" do
    it "should return true if computer is turned on" do
      @ws = Equipment.create!(@ws_attr)
      @ws.online?.should be_true
    end
  end
end
