class UsersController < ApplicationController
  before_action :set_target_user, only: %i[show edit update destroy]

  def index
    @pagy, @users = pagy(User.all, items: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(set_safe_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(set_safe_params)
      redirect_to @user, notice: 'User was successfully updated.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    # rubocop:todo Rails/I18nLocaleTexts
    redirect_to users_url, status: :see_other, notice: 'User was successfully destroyed.'
    # rubocop:enable Rails/I18nLocaleTexts
  end

  private

  def set_target_user
    @user = User.find(params[:id])
  end

  def set_safe_params
    params.require(:user)
          .permit(
            :first_name,
            :last_name,
            :nickname,
            :email,
            :password,
            :password_confirmation
          )
  end
end
