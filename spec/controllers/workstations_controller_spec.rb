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
      @user = Factory.create(:user)
      sign_in @user
      @ws = Factory.create(:workstation)
    end
    
    describe 'GET :index' do
      before(:each) do
        ws_2 = Factory(:workstation, :tag => 'second',
          :ip_address => '172.20.32.170', :mac_address => '11-22-33-44-55-66')
        ws_3 = Factory(:workstation, :tag => 'third',
          :ip_address => '172.20.32.158', :mac_address => '22-33-44-55-77-aa')
        @wss = [@ws, ws_2, ws_3]
        30.times do
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
        response.should have_selector("a", :href => "/workstations/index?page=2", :content => "2")
        response.should have_selector("a", :href => "/workstations/index?page=2", :content => "Next")
      end
    end
  end
end   
