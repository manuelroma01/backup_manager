require 'test_helper'

class WorkstationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Workstation.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Workstation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Workstation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to workstation_url(assigns(:workstation))
  end

  def test_edit
    get :edit, :id => Workstation.first
    assert_template 'edit'
  end

  def test_update_invalid
    Workstation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Workstation.first
    assert_template 'edit'
  end

  def test_update_valid
    Workstation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Workstation.first
    assert_redirected_to workstation_url(assigns(:workstation))
  end

  def test_destroy
    workstation = Workstation.first
    delete :destroy, :id => workstation
    assert_redirected_to workstations_url
    assert !Workstation.exists?(workstation.id)
  end
end
