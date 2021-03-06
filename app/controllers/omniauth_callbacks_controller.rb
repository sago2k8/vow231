class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    generic_callback( 'twitter' )
  end
  def facebook
    generic_callback( 'facebook' )
  end


  def generic_callback( provider )
    @identity = Identity.find_for_oauth request.env["omniauth.auth"]

    @user = @identity.user || current_user 
    
    if @user.nil?   
      @user = User.create( email: @identity.email, oauth_callback: true )
      @identity.update_attribute( :user_id, @user.id )
      if params[:type].to_i == 1 
        @user.add_role("foundation")
      elsif params[:type].to_i == 0
       @user.add_role("volunteer")
      end
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.photo_url.blank? && @identity.image
      @user.update_attribute( :photo_url, @identity.image)
    end
    if @user.phone.blank? && @identity.phone
      @user.update_attribute( :phone, @identity.phone)
    end

    if @user.nickname.blank? && @identity.nickname
      @user.update_attribute( :nickname, @identity.nickname)
    end


    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )

      unless  @user.email
      sign_in @user, event: :authentication
      redirect_to edit_user_registration_path(@user)

      else
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
      end
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
