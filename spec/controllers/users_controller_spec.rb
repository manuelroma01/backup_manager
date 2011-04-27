require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'index'" do
    describe "for non-signed-in users" do
      it "deny access" do
        get :index
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do
      before (:each) do
        @user = Factory.create(:user, :username => 'testuser', :email => "test@user.com")
        second = Factory(:user, :username => 'second', :email => "secont@test.cat")
        third = Factory(:user, :username => 'third', :email => "third@test.net")
 
        @users = [@user, second, third]       
        30.times do
          @users << Factory(:user)
        end
        
        sign_in @user
        get :index
      end
      
      it "should be successful" do response.should be_success end

      it "should have an element for each user" do
        @users[0..2].each do |user|
          response.should have_selector("li", :content => user.username)
        end
      end
      
      it "should paginate users" do pending "falta gem will paginate" end
    end 
  end

  describe "GET 'show'" do
    describe "for non-signed-in users" do
      it "deny access" do
        get :show, :id => 1
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do
      before (:each) do
        @user = Factory.create(:user, :username => 'testuser', :email => "test@user.com")
        sign_in @user
        get :show, :id => @user.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => @user.username) end
      it "should find the right user" do assigns(:user.should) == @user end
      
      it "should include the user's data" do
        response.should have_selector("p", :content => "Username: #{@user.username}")
        response.should have_selector("p", :content => "e-mail: #{@user.email}")
      end
    end
  end

end
