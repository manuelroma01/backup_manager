require 'spec_helper'

describe Role do
  before(:each) do
    @role_attr = {
      :name => 'new_role',
    }
  end

  it "should create a new instance given valid attributes" do
    Role.create!(@role_attr)
  end
  
  describe "validates attr pressence" do
    it "should require a name" do Role.new(@role_attr.merge(:name => "")).should_not be_valid end
  end
  
end
# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(15)      not null
#  created_at :datetime
#  updated_at :datetime
#

