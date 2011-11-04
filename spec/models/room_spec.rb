require 'spec_helper'

describe Room do
  before(:each) do
    @room_attr = {
      :name => 'sala_nueva',
      :location => 'zona negativa',
      :comment => 'Pertenece a Annihilus'
    }
  end

  it "should create a new instance given valid attributes" do
    Room.create!(@room_attr)
  end
  
  describe "validates attr pressence" do
    it "should require a name" do Room.new(@room_attr.merge(:name => "")).should_not be_valid end
    it "should require a location" do Room.new(@room_attr.merge(:location => "")).should_not be_valid end
  end
end
