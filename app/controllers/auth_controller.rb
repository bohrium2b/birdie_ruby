class AuthController < ApplicationController
  def login
    
  end

  def loginpost
    # Authenticate with devise
    # If successful, redirect to profile page
    # If unsuccessful, redirect to login page with error message
    profile = Profile.find_by(handle: params[:handle])
    user = profile&.user
    if ! user
      flash[:danger] = "Invalid handle or password"
      redirect_to auth_login_path
      return
    end
    if user&.valid_password?(params[:password])
      sign_in(user)
      redirect_to profile_path(profile)
    else
      flash[:danger] = "Invalid handle or password"
      redirect_to auth_login_path
    end

  end

  def logout
    # Sign out with devise
    # Redirect to login page
    sign_out
    redirect_to auth_login_path
  end

  def signup
    
  end

  def signuppost
    name = params[:first_name] + " " + params[:last_name]
    if params[:password] != params[:password_confirmation]
      flash[:danger] = "Passwords do not match"
      redirect_to auth_signup_path
      return
    end
    user = User.new(email: params[:email], password: params[:password])
    user.save
    if user.errors.any?
      flash[:danger] = user.errors.full_messages.join(", ")
      redirect_to auth_signup_path
      return
    end
    profile = Profile.new(user: user, name: name, handle: params[:handle], gender: params[:pronouns], bio: params[:bio], ispublic: params[:ispublic] == "1")
    profile.save
    if profile.errors.any?
      flash[:danger] = profile.errors.full_messages.join(", ")
      redirect_to auth_signup_path
      return
    end
    sign_in(user)
    redirect_to profile_path(profile)
  end

  def profile
    
  end
end
