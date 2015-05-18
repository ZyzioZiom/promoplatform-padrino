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
      
      password = ::BCrypt::Password.create(nil)
      password = password.force_encoding(Encoding::UTF_8) if password.encoding == Encoding::ASCII_8BIT
      
      new_user = User.create(uid: uid, email: email, firstname: first_name, lastname: last_name, image: image, role: "user", crypted_password: password)
      
      @user = User.find(new_user)
      session[:current_user] = @user
      current_user = session[:current_user]
      # TODO: send welcome email
      
      flash[:success] = "Witaj na Promoplatformie, #{current_user.firstname}! Fajnie, że jesteś #{9829.chr}"
      
      redirect_to 'home'
    else
      
      session[:current_user] = @user
      current_user = session[:current_user]
      
      flash[:success] = "Witaj ponownie, #{current_user.firstname}! Świetnie dziś wyglądasz #{9786.chr} "
      
      redirect_to 'home'
    end
    
  end

  get :google_oauth2_callback_failed, :map => "/auth/failure" do
    flash[:error] = "Błąd logowania: #{params[:message]}"

  end


  # logout user and redirect to welcome page
    get :logout, :map => "/logout" do
    session.clear
    redirect_to '/'
  end


end
