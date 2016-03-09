class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

  if params[:password].blank?
    params.delete(:password)
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
  end

  result = if params[:password].blank? || valid_password?(current_password)
    update_attributes(params, *options)
  else
    self.assign_attributes(params, *options)
    self.valid?
    self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
    false
  end

    clean_up_passwords
    result
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      user.avatar = auth.info.image # assuming the user model has an image
    end
  end
end
