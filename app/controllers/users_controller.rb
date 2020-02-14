class UsersController < ApplicationController
  def show
    @id = params["id"]
    @user = User.find(@id)
  end
  def new
    @user = User.new
    @cities = City.all
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :age, :email, :password, :password_confirmation, :description)
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Votre profil a bien été créé. Vous êtes à présent connecté."
      log_in(@user)
      remember(@user)
      redirect_to gossips_path
    else
     @errors = @user.errors
     render :new
    end
  end
end
