require 'spec_helper'

describe EquipmentsController do
  render_views

  # ninguna operación permitida para usuarios no autenticados
  describe "for non-signed-in users" do
    it "should deny access to :index" do get :index end
    it "should deny access to :show" do get :show, :id => 1 end
    it "should deny access to :new" do get :new end
    it "should deny access to :edit" do get :edit, :id => 1 end
    it "should deny access to :update" do 
      ws = Factory(:equipment)
      put :update, :id => 1, :equipment => ws
    end
    it "should deny acces to :delete" do delete :destroy, :id => 1 end
    it "should deny access to :create" do
      ws = Factory(:equipment)
      post :create, :equipment => ws
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
      @ws = Factory(:equipment_local)
    end
    
    # listar equipments
    describe 'GET :index' do
      before(:each) do
        @ws_google = Factory(:equipment_google)
        @ws_creal = Factory(:equipment_creal)
        @wss = [@ws, @ws_google, @ws_creal]
        10.times do
          @wss << Factory(:equipment)
        end

        get :index
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => "Equipments") end
        
      it "should have an element for each equipment" do
        @wss[0..3].each do |ws|
          response.should have_selector("td", :content => ws.tag)
        end
      end
      
      it "should paginate equipments" do
        10.times do
          @wss << Factory(:equipment)
        end
        get :index
        
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/equipments?page=2", :content => "2")
        response.should have_selector("a", :href => "/equipments?page=2", :content => "Next")
      end
    end
    
    # mostrar datos de equipment
    describe "GET :show" do
      before(:each) do
        get :show, :id => @ws.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => @ws.tag) end
      it "should find the right equipment" do assigns(:equipment.should) == @ws end
      
      it "should include the equipment's data" do
        response.should have_selector("li", :content => "IP: #{@ws.ip_address}")
        response.should have_selector("li", :content => "mac: #{@ws.mac_address}")
      end
    end
    
    # nueva equipment
    describe "GET :new" do
      before(:each) do
        get :new
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do response.should have_selector("title", :content => "Nuevo equipo") end
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
            post :create, :equipment => @attr_create
          end.should_not change(Equipment, :count)
        end
        
        it "should have the right title" do
          post :create, :equipment => @attr_create
          response.should have_selector("title", :content => "Nuevo equipo")
        end
        
        it "should render the 'new' page" do
          post :create, :equipment => @attr_create
          response.should render_template('new')
        end
      end
      
      # con attr correctos
      describe "success" do
        before(:each) do
          @attr_create = {
            :tag => "createequipment",
            :equipment_type => 'server',
            :ip_address => "172.20.32.52",
            :mac_address => "00-11-22-33-44-55",
            :location => 'office'
          }
        end

        it "should create a equipment" do
          lambda do
            post :create, :equipment => @attr_create
          end.should change(Equipment, :count).by(1)
        end
        
        it "should redirect to the user show page" do
          post :create, :equipment => @attr_create
          response.should redirect_to(equipment_path(assigns(:equipment)))
        end
      end
    end

    # editar equipment
    describe "GET :edit" do
      before(:each) do
        get :edit, :id => @ws.id
      end
      
      it "should be successful" do response.should be_success end
      it "should have the right title" do
        response.should have_selector("title", :content => "Editar Equipment: #{@ws.tag}")
      end
    end
    
    # actualizar equipment
    describe "PUT :update" do
      # con atributos incorrectos
      describe "failure" do
        before(:each) do
          @attr_mod = {
            :tag => "",
            :ip_address => "",
            :mac_address => ""
          }
          
          put :update, :id => @ws, :equipment => @attr_mod
        end
        
        it "should render the 'edit' page" do response.should render_template('edit') end
        it "should have the right title" do
          response.should have_selector("title", :content => "Editar Equipment: #{@ws.tag}")
        end
      end
      
      # con atributos correctos
      describe "success" do
        before(:each) do
          @attr_mod = {
            :tag => "updateequipment",
            :ip_address => "172.20.32.52",
            :mac_address => "00-11-22-33-44-55"
          }
          put :update, :id => @ws, :equipment => @attr_mod
        end
        
        it "should change the user's attributes" do
          @ws.reload
          @ws.tag.should == @attr_mod[:tag]
          @ws.ip_address.should == @attr_mod[:ip_address]
          @ws.mac_address.should == @attr_mod[:mac_address]
        end
        
        it "should redirect to the equipment show page" do response.should redirect_to(equipment_path(@ws)) end
        it "should have a flash message" do flash[:success].should =~ /actualizada/ end
      end
    end

    # borrar equipment
    describe "DELETE :destroy" do
      before(:each) do
        @ws_delete = Factory(:equipment,
          :tag => "deleteequipment",
          :ip_address => "172.20.32.52",
          :mac_address => "00-11-22-33-44-55"
        )
      end
      
      it "should destroy the equipment" do
        lambda do
          delete :destroy, :id => @ws_delete
        end.should change(Equipment, :count).by(-1)
      end
      
      it "should redirect to the equipments page" do
        delete :destroy, :id => @ws_delete
        response.should redirect_to(equipments_path)
      end
    end
  end
end   
