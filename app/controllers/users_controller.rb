class UsersController < ApplicationController
   before_filter :authorize , :only=> [:index, :show]
  

def index
    @users = User.paginate(page: params[:page], :per_page => 2)
  end
  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
