require 'spec_helper'

describe Workstation do
  before(:each) do
    @ws_attr = {
      :tag => 'www.google.com',
      :ip_address => '209.85.146.104',
      :mac_address => '20:cf:30:e8:4b:4c'
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
    it "should require a well-formed ip address" do
      pending "crear regexp"
    end
    
    it "should require a well-formed mac address" do
      pending "crear regexp"
    end
  end
end
