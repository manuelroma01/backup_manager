class PagesController < ApplicationController
  skip_authorization_check # permisos cancan
  
  def home
  end
end
