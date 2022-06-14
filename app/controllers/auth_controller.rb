class AuthController < ApplicationController
  def create
    @user = User.find_by(email: auth_params[:email])
    if @user && @user.authenticate(auth_params[:password])
      render json: UserSerializer.new(@user), status: :accepted, location: @user
    else
      render json: {message: "Unable to verify account"}, status: 401
    end
  end

  def destroy

  end

  private

  def auth_params
    params.require(:user).permit(:id, :email, :password)
  end
  

end
