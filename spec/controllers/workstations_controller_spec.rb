require 'spec_helper'

describe WorkstationsController do
  render_views

  # ninguna operación permitida para usuarios no autenticados
  describe "for non-signed-in users" do
    it "should deny access to :index" do get :index end
    it "should deny access to :show" do get :show, :id => 1 end
    it "should deny access to :new" do get :new end
    it "should deny access to :edit" do get :edit, :id => 1 end
    it "should deny access to :update" do 
      ws = Factory(:workstation)
      put :update, :id => 1, :workstation => ws
    end
    it "should deny acces to :delete" do delete :destroy, :id => 1 end
    it "should deny access to :create" do
      ws = Factory(:workstation)
      post :create, :workstation => ws
    end
      
    after(:each) do
      response.should redirect_to(new_user_session_path)
      flash[:alert].should =~ /sign in/i
    end
  end
  
  # operaciones permitidas para usuarios autenticados
  describe "for signed-in users" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
      @ws = Factory(:workstation_local)
    end
    
    # listar workstations
    describe 'GET :index' do
      before(:each) do
<<<<<<< HEAD
        ws_2 = Factory(:workstation, :tag => 'second',
          :ip_address => '172.20.32.170', :mac_address => '11-22-33-44-55-66')
        ws_3 = Factory(:workstation, :tag => 'third',
          :ip_address => '172.20.32.158', :mac_address => '22-33-44-55-77-aa')
        @wss = [@ws, ws_2, ws_3]
        30.times do
=======
        @ws_google = Factory(:workstation_google)
        @ws_creal = Factory(:workstation_creal)
        @wss = [@ws, @ws_google, @ws_creal]
        10.times do
>>>>>>> 22a9aa1fac2cb0f7a034b4908285898905fda238
          @wss << Factory(:workstation)
        end
        get :index
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => "Workstations") end
        
      it "should have an element for each workstation" do
        @wss[0..2].each do |ws|
          response.should have_selector("td", :content => ws.tag)
        end
      end
      
      it "should paginate workstations" do
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/workstations?page=2", :content => "2")
        response.should have_selector("a", :href => "/workstations?page=2", :content => "Next")
      end
    end
    
    # mostrar datos de workstation
    describe "GET :show" do
      before(:each) do
        get :show, :id => @ws.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => @ws.tag) end
      it "should find the right workstation" do assigns(:workstation.should) == @ws end
      
      it "should include the workstation's data" do
        response.should have_selector("p", :content => "ip: #{@ws.ip_address}")
        response.should have_selector("p", :content => "mac: #{@ws.mac_address}")
      end
    end
    
    # nueva workstation
    describe "GET :new" do
      before(:each) do
        get :new
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => "Nueva workstation") end
    end
    
        # crear usuario
    describe "POST :create" do
      # con attr incorrectos
      describe "failure" do
        before(:each) do
          @attr_create = {
            :tag => "",
            :ip_address => "",
            :mac_address => ""
          }
        end
        
        it "should not create a user" do
          lambda do
            post :create, :workstation => @attr_create
          end.should_not change(Workstation, :count)
        end
        
        it "should have the right title" do
          post :create, :workstation => @attr_create
          response.should have_selector("title", :content => "Nueva workstation")
        end
        
        it "should render the 'new' page" do
          post :create, :workstation => @attr_create
          response.should render_template('new')
        end
      end
      
      # con attr correctos
      describe "success" do
        before(:each) do
          @attr_create = {
            :tag => "createworkstation",
            :ip_address => "172.20.32.52",
            :mac_address => "00-11-22-33-44-55"
          }
        end

        it "should create a workstation" do
          lambda do
            post :create, :workstation => @attr_create
          end.should change(Workstation, :count).by(1)
        end
        
        it "should redirect to the user show page" do
          post :create, :workstation => @attr_create
          response.should redirect_to(workstation_path(assigns(:workstation)))
        end
      end
    end

    # editar workstation
    describe "GET :edit" do
      before(:each) do
        get :edit, :id => @ws.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do
        response.should have_selector("title", :content => "Editar Workstation: #{@ws.tag}")
      end
    end
    
    # actualizar workstation
    describe "PUT :update" do
      # con atributos incorrectos
      describe "failure" do
        before(:each) do
          @attr_mod = {
            :tag => "",
            :ip_address => "",
            :mac_address => ""
          }
          
          put :update, :id => @ws, :workstation => @attr_mod
        end
        
        it "should render the 'edit' page" do response.should render_template('edit') end
        it "should have the right title" do
          response.should have_selector("title", :content => "Editar Workstation: #{@ws.tag}")
        end
      end
      
      # con atributos correctos
      describe "success" do
        before(:each) do
          @attr_mod = {
            :tag => "updateworkstation",
            :ip_address => "172.20.32.52",
            :mac_address => "00-11-22-33-44-55"
          }
          put :update, :id => @ws, :workstation => @attr_mod
        end
        
        it "should change the user's attributes" do
          @ws.reload
          @ws.tag.should == @attr_mod[:tag]
          @ws.ip_address.should == @attr_mod[:ip_address]
          @ws.mac_address.should == @attr_mod[:mac_address]
        end
        
        it "should redirect to the workstation show page" do response.should redirect_to(workstation_path(@ws)) end
        it "should have a flash message" do flash[:success].should =~ /actualizada/ end
      end
    end

    # borrar workstation
    describe "DELETE :destroy" do
      before(:each) do
        @ws_delete = Factory(:workstation,
          :tag => "deleteworkstation",
          :ip_address => "172.20.32.52",
          :mac_address => "00-11-22-33-44-55"
        )
      end
      
      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @ws_delete
        end.should change(Workstation, :count).by(-1)
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @ws_delete
        response.should redirect_to(workstations_path)
      end
    end
  end
end   
