require 'spec_helper'

describe User do
  setup :activate_authlogic
  
  before(:each) do
    @attr = {
      :username => "example_user",
      :email => "user@example.com",
      :password => "123456",
      :password_confirmation => "123456"
    }
  end
  
  it "user should be valid" do
    valid_user = User.create(@attr)
    valid_user.should be_valid
  end

  it "should create a new user given valid attributes" do
    User.create(@attr)
  end
  
  it "should require a name" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end
  
  it "should require a valid e-mail" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      puts "addresses #{valid_email_user.inspect}" # /***/
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

end
