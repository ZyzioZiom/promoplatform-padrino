PromoplatformPadrino::App.controllers :auth do
  
  layout :application
  
  
  get :google_oauth2_callback, :map => "/auth/google_oauth2/callback" do
    
    omniauth = request.env["omniauth.auth"]
    
    uid = omniauth['uid']
    first_name = omniauth['info']['first_name']
    last_name = omniauth['info']['last_name']
    email = omniauth['info']['email']
    image = omniauth['info']['image']

    @user = User.where(uid: uid, email: email).first
    
    
    if @user.nil?
      # user doesn't exist
      
      # create encrypted password which is user email
      password = ::BCrypt::Password.create(email)
      password = password.force_encoding(Encoding::UTF_8) if password.encoding == Encoding::ASCII_8BIT
      
      new_user = User.create(uid: uid, email: email, firstname: first_name, lastname: last_name, image: image, role: "user", crypted_password: password)
      
      current_user = User.find(new_user)
      
      # TODO: send welcome email
      
      flash[:success] = "Witaj na Promo Platformie, #{current_user.firstname}"
      
      redirect_to 'home'
    else
      
      current_user = @user
      
      flash[:success] = "Witaj ponownie, #{current_user.firstname}"
      
      redirect_to 'home'
    end
    
  end

  get :google_oauth2_callback_failed, :map => "/auth/failure" do
    flash[:error] = "Error logging with Google #{params[:message]}"

  end


  # logout user and redirect to welcome page
    get :logout, :map => "/logout" do
    session.clear
    redirect_to '/'
  end


end
