require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @roleroot = Role.find_by_name('root')
    @roleroot ||= Role.create!(:name => 'root')
    @roleuser = Role.find_by_name('user')
    @roleuser ||= Role.create!(:name => 'user')
  
    @user = Factory.create(:user, :username => 'testuser', :role => @roleuser, :email => "test@user.com")
    @root = User.find_by_name('root')
  end

  # ninguna operación permitida para usuarios no autenticados
  describe "for non-signed-in users" do
    it "should deny access to :index" do get :index end
    it "should deny access to :show" do get :show, :id => User.find(:first).id end
    it "should deny access to :new" do get :new end
    it "should deny access to :edit" do get :edit, :id => User.find(:first).id end
    it "should deny access to :update" do 
      put :update, :id => User.find(:first).id, :user => @user
    end
    it "should deny acces to :delete" do delete :destroy, :id => User.find(:first).id end
    it "should deny access to :create" do
      post :create, :user => @user
    end
      
    after(:each) do
      response.should redirect_to(root_path)
      flash[:alert].should =~ /not authorized/i
    end
  end      

  # ninguna operación permitida para usuarios normales
  describe "for signed-in users (non-root)" do
    before(:each) do
      sign_in @user
    end
  
    it "should deny access to :index" do get :index end
    it "should deny access to :show" do get :show, :id => User.find(:first).id end
    it "should deny access to :new" do get :new end
    it "should deny access to :edit" do get :edit, :id => User.find(:first).id end
    it "should deny access to :update" do 
      put :update, :id => User.find(:first).id, :user => @user
    end
    it "should deny acces to :delete" do delete :destroy, :id => User.find(:first).id end
    it "should deny access to :create" do
      post :create, :user => @user
    end
      
    after(:each) do
      response.should redirect_to(root_path)
      flash[:alert].should =~ /not authorized/i
    end
  end      


  # operaciones para root
  describe "for signed-in users" do
    before(:each) do
      sign_in @root
    end

    # listar usuarios    
    describe "GET 'index'" do
      before(:each) do
        second = Factory(:user, :username => 'second', :role => @roleuser, :email => "secont@test.cat")
        third = Factory(:user, :username => 'third', :role => @roleuser, :email => "third@test.net")
 
        @users = [@user, second, third]       
        30.times do
          @users << Factory(:user)
        end
        
        get :index
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => "Usuarios") end

      it "should have an element for each user" do
        @users[0..2].each do |user|
          response.should have_selector("td", :content => user.username)
        end
      end
      
      it "should paginate users" do
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/users/index?page=2", :content => "2")
        response.should have_selector("a", :href => "/users/index?page=2", :content => "Next")
      end
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
        response.should have_selector("li", :content => "Username: #{@user.username}")
        response.should have_selector("li", :content => "e-mail: #{@user.email}")
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

    # crear usuario
    describe "POST :create" do
      # con attr incorrectos
      describe "failure" do
        before(:each) do
          @attr_create = {
            :username => "",
            :email => "",
            :role_id => 0,
            :password => "",
            :password_confirmation => ""
          }
        end
        
        it "should not create a user" do
          lambda do
            post :create, :user => @attr_create
          end.should_not change(User, :count)
        end
        
        it "should have the right title" do
          post :create, :user => @attr_create
          response.should have_selector("title", :content => "Nuevo usuario")
        end
        
        it "should render the 'new' page" do
          post :create, :user => @attr_create
          response.should render_template('new')
        end
      end
      
      # con attr correctos
      describe "success" do
        before(:each) do
          @attr_create = {
            :username => "createuser",
            :email => "create@test.com",
            :role_id => @roleuser.id,
            :password => "porfaplis",
            :password_confirmation => "porfaplis"
          }
        end

        it "should create a user" do
          lambda do
            post :create, :user => @attr_create
          end.should change(User, :count).by(1)
        end
        
        it "should redirect to the user show page" do
          post :create, :user => @attr_create
          response.should redirect_to(user_path(assigns(:user)))
        end
      end
    end

    # editar usuario    
    describe "GET :edit" do
      before(:each) do
        get :edit, :id => @user.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do
        response.should have_selector("title", :content => "Editar usuario: #{@user.username}")
      end
    end
    
    # actualizar usuario
    describe "PUT :update" do
      # con atributos incorrectos
      describe "failure" do
        before(:each) do
          @attr_mod = {
            :username => "",
            :email => "",
            :role_id => 0,
            :password => "",
            :password_confirmation => ""
          }
          
          put :update, :id => @user, :user => @attr_mod
        end
        
        it "should render the 'edit' page" do response.should render_template('edit') end
        it "should have the right title" do
          response.should have_selector("title", :content => "Editar usuario: #{@user.username}")
        end
      end
      
      # con atributos correctos
      describe "success" do
        before(:each) do
          @attr_mod = {
            :username => "newuser",
            :email => "new@test.com",
            :role_id => @roleroot.id,
            :password => "barbaz",
            :password_confirmation => "barbaz"
          }
          put :update, :id => @user, :user => @attr_mod
        end
        
        it "should change the user's attributes" do
          @user.reload
          @user.username.should == @attr_mod[:username]
          @user.role.should == @roleroot
          @user.email.should == @attr_mod[:email]
        end
        
        it "should redirect to the user show page" do response.should redirect_to(user_path(@user)) end
        it "should have a flash message" do flash[:success].should =~ /modificado/ end
      end
    end

    # borrar usuario
    describe "DELETE :destroy" do
      # no permitir auto borrado
      describe "failure" do
        it "should not self-destroy" do
          lambda do
            delete :destroy, :id => @root
          end.should_not change(User, :count)
        end
        
        it "should render the user page" do
          delete :destroy, :id => @root
          response.should render_template('show')
        end
      end
      
      describe "success" do
        before(:each) do
          @user_delete = Factory.create(:user, :username => 'delete', :role => @roleuser, :email => "delete@test.com")
        end
        
        it "should destroy the user" do
          lambda do
            delete :destroy, :id => @user_delete
          end.should change(User, :count).by(-1)
        end
        
        it "should redirect to the users page" do
          lambda do
            delete :destroy, :id => @user_delete
          end.should change(User, :count).by(-1)
        end
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @user_delete
        response.should redirect_to(users_path)
      end
    end
      
  end
end

