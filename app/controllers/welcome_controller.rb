class WelcomeController < ApplicationController
  def user
    @first_name = params["first_name"]
    
  end
end
