require 'spec_helper'

describe UsersController do
  render_views

  # ninguna operación permitida para usuarios no autenticados
  describe "for non-signed-in users" do
    it "should deny access to :index" do get :index end
    it "should deny access to :show" do get :show, :id => 1 end
    it "should deny access to :new" do get :new end
    it "should deny access to :edit" do get :edit, :id => 1 end
#    it "should deny access to :create" do post :create end
      
    after(:each) do
      response.should redirect_to(new_user_session_path)
      flash[:alert].should =~ /sign in/i
    end
  end      

  # listar usuarios
  describe "for signed-in users" do
    before(:each) do
      @user = Factory.create(:user, :username => 'testuser', :email => "test@user.com")
      sign_in @user
    end
    
    describe "GET 'index'" do
      before(:each) do
        second = Factory(:user, :username => 'second', :email => "secont@test.cat")
        third = Factory(:user, :username => 'third', :email => "third@test.net")
 
        @users = [@user, second, third]       
        30.times do
          @users << Factory(:user)
        end
        
        get :index
      end
      
      it "should be successful" do response.should be_success end

      it "should have an element for each user" do
        @users[0..2].each do |user|
          response.should have_selector("td", :content => user.username)
        end
      end
      
      it "should paginate users" do pending "falta gem will paginate" end
    end 

    # mostrar datos de usuario
    describe "GET 'show'" do
      before(:each) do
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

    # nuevo usuario
    describe "GET :new" do
      before(:each) do
        get :new
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => "Nuevo usuario") end
      # por terminar, tras acabar :edit
    end
    
    describe "GET :edit" do
      before(:each) do
        get :edit, :id => @user.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do
        response.should have_selector("title", :content => "Editar usuario: #{@user.username}")
      end
    end

    
  # crear usuario (más adelante)
=begin
  describe "POST :create" do
    describe "for non-signed-in users" do
      it "deny access" do
        post :create
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/i
      end
    end
  end
  
  describe "for signed-in users" do
    before(:each) do
      @user = Factory.create(:user, :username => 'testuser', :email => "test@user.com")
      sign_in @user
      post :create
    end
    
    #it "should be successful" do response.should be_success end
    #it "should have the rigth title" do response.should have_selector("title", :content => "Nuevo usuario") end
  end 
=end
  end
end
