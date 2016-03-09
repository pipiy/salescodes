class Users::RegistrationsController < Devise::RegistrationsController
  layout false, only: [:new, :create]

  def create
    if request.format != :json
      build_resource(sign_up_params)

      if resource.save
        flash.now[:success] = I18n.t('devise.registrations.signed_up')
        sign_up(resource_name, resource)
      else
        clean_up_passwords resource
        flash.now[:errors] = resource.errors.full_messages.join(', ')
        render :new
      end
    else
      user = params[:user]
      email = params[:user][:email]
      password = params[:user][:password]

      respond_to do |format|
        format.json {
          if email.nil?
            Rails.logger.error("Failed to create the user. Email cannot be empty.")
            render :status => 400, :json => "User request must contain the user email."
            return
          elsif password.nil?
            Rails.logger.error("Failed to create the user. Password cannot be empty.")
            render :status => 400, :json => "User request must contain the user password."
            return
          end

          if email
            duplicate_user = User.find_by_email(email)
            unless duplicate_user.nil?
              Rails.logger.error("Failed to create the user. Email has already been taken.")
              render :status => 409, :json => "Duplicate email. A user already exists with that email address."
              return
            end
          end

          @user = User.create(user)

          if @user.save
            render :json => {:user => @user}
          else
            Rails.logger.error @user.errors.messages
            render :status => 400, :json => @user.errors.full_messages.join("; ")
          end
        }
      end
    end
  end

  def update
    @user = User.find(current_user.id)

    @user.update_attributes(sign_up_params)
    render :edit
  end

  protected

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :remote_avatar_url, :short_bio, :password)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
