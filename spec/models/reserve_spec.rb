require 'spec_helper'

describe Reserve do
  before(:each) do
    @room_johnsnow = Room.find_by_name('John Snow')
    @user = Factory(:user)
  
    @reserve_attr = {
      :room_id => @room_johnsnow.id,
      :user_id => @user.id,
      :reserve_start => '20/12/2011 10:00',
      :reserve_end => '20/12/2011 10:00',
      :reason => 'Botellon',
      :comment => 'Cada uno traiga su propio alcohol'
    }
  end

  it "should create a new instance given valid attributes" do
    Reserve.create!(@reserve_attr)
  end
  
  describe "validates attr pressence" do
    it "should require a room" do Reserve.new(@reserve_attr.merge(:room_id => nil)).should_not be_valid end
    it "should require a user" do Reserve.new(@reserve_attr.merge(:user_id => nil)).should_not be_valid end
    it "should require a reserve_start" do Reserve.new(@reserve_attr.merge(:reserve_start => nil)).should_not be_valid end
    it "should require a reserve_end" do Reserve.new(@reserve_attr.merge(:reserve_end => nil)).should_not be_valid end
    it "should require a reason" do Reserve.new(@reserve_attr.merge(:reason => nil)).should_not be_valid end
  end
  
  describe "validates correct room" do
    before(:each) do
      @reserve = Reserve.new(@reserve_attr)
    end
  
    it "room should be in room list" do
      Room.find(@reserve.room).should == @reserve.room
    end
  end
  
  describe "validates correct user" do
    before(:each) do
      @reserve = Reserve.new(@reserve_attr)
    end
    
    it "user should be in users list" do
      User.find(@reserve.user).should == @reserve.
    end
  end
  
  describe "validates correct reserve_start" do
  end
  
  describe "validates correct reserve_end" do
  end
end
