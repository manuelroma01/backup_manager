require 'spec_helper'

describe Workstation do
  before(:each) do
    @ws_attr = {
      :tag => 'www.google.com',
      :ip_address => '209.85.146.104',
      :mac_address => '20-cf-30-e8-4b-4c'
    }
    
    @ws_attr_2 = {
      :tag => 'www.creal.cat',
      :ip_address => '193.144.6.2',
      :mac_address => '54-87-e6-8d-52-10'
    }
    
    @ws_attr_false = {
      :tag => 'fake_ws',
      :ip_address => '125.5.5.1',
      :mac_address => '54-87-55-8d-52-10'
    }
  end
  
  it "should create a new instance given valid attributes" do
    Workstation.create!(@ws_attr)
  end
  
  describe "validations" do
    it "should require a tag" do Workstation.new(@ws_attr.merge(:tag => "")).should_not be_valid end
    it "should require an ip_address" do Workstation.new(@ws_attr.merge(:ip_address => "")).should_not be_valid end
    it "should require a mac_address" do Workstation.new(@ws_attr.merge(:mac_address => "")).should_not be_valid end
  end
  
  # validación formato atributos
  describe "validates attr format" do
    it "should accept valid ip addresses" do
      ip_adresses = ['127.0.0.1', '172.20.32.58', '194.255.127.10']
      ip_adresses.each do |ip_address|
        Workstation.new(@ws_attr.merge(:ip_address => ip_address)).should be_valid
      end
    end
   
    it "should reject invalid ip addresses" do
      ip_addresses = ['654.0.5.2', '456854.12.4', '172.20.32']
      ip_addresses.each do |ip_address|
        Workstation.new(@ws_attr.merge(:ip_address => ip_address)).should_not be_valid
      end
    end
    
    it "should reject duplicated ip addresses" do
      test_ws = Workstation.create!(@ws_attr)
      Workstation.new(@ws_attr_2.merge(:ip_address => test_ws.ip_address)).should_not be_valid
    end
   
    it "should accept valid mac addresses" do
      mac_addresses = ['20-cf-30-e8-4b-4c', '54-87-e6-8d-52-10', '00-ab-54-65-7a-01']
      mac_addresses.each do |mac_address|
        Workstation.new(@ws_attr.merge(:mac_address => mac_address)).should be_valid
      end
    end
    
    it "should reject invalid mac addresses" do
      mac_addresses = ['20-150-30-e8-4b-4c', '54-87-lk-8d-52-10', '00-ab-54-7a-01']
      mac_addresses.each do |mac_address|
        Workstation.new(@ws_attr.merge(:mac_address => mac_address)).should_not be_valid
      end
    end
    
    it "should reject duplicated mac addresses" do
      test_ws = Workstation.create!(@ws_attr)
      Workstation.new(@ws_attr_2.merge(:mac_address => test_ws.mac_address)).should_not be_valid
    end   
  end
  
  # ping
  describe "worktation turned_on?" do
    it "should return true if computer is turned on" do
      @ws = Workstation.create!(@ws_attr)
      @ws.turned_on?.should be_true
    end
  end
end
