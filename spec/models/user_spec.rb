require 'spec_helper'

describe User do
  before(:each) do
    @user_attr = {
      :username => 'testuser',
      :email => 'user@test.com',
      :password => 'porfaplis',
      :password_confirmation => 'porfaplis'
    }
    
    @user_attr_2 = {
      :username => 'testuser_2',
      :email => 'user_2@test.com',
      :password => 'porfaplis',
      :password_confirmation => 'porfaplis'
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@user_attr)
  end

  describe "validates attr pressence" do
    it "should require a username" do User.new(@user_attr.merge(:username => "")).should_not be_valid end
    it "should require an e-mail" do User.new(@user_attr.merge(:email => "")).should_not be_valid end
    it "should require a password" do User.new(@user_attr.merge(:password => "")).should_not be_valid end
    it "should require a password_confirmation" do
      User.new(@user_attr.merge(:password_confirmation => "")).should_not be_valid
    end
  end
  
  # validación formato atributos
  describe "validates attr format" do
    it "should limit usernames to < 30 characters" do
      long_username = "a" * 31
      User.new(@user_attr.merge(:username => long_username)).should_not be_valid
    end

    it "should reject duplicate username" do
      test_user = User.create!(@user_attr)
      User.new(@user_attr_2.merge(:username => test_user.username)).should_not be_valid
    end
    
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        User.new(@user_attr.merge(:email => address)).should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        User.new(@user_attr.merge(:email => address)).should_not be_valid
      end
    end
    
    it "should reject duplicated email addresses" do
      test_user = User.create!(@user_attr)
      User.new(@user_attr_2.merge(:email => test_user.email)).should_not be_valid
    end
    
    it "should limit password to > 6 characters" do
      short_password = "a" * 5
      User.new(@user_attr.merge(:password => short_password, :password_confirmation => short_password)).should_not be_valid
    end
    
    it "should limit password to < 20 characters" do
      long_password = "a" * 21
      User.new(@user_attr.merge(:password => long_password, :password_confirmation => long_password)).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@user_attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
  end
end
