PromoplatformPadrino::App.controllers :auth do
  
  layout :application
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
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
      
      @user = User.where(id: new_user.id).first
      session[:current_user] = @user
      
      # TODO: send welcome email
      
      flash[:success] = "Witaj na Promo Platformie, #{@user.firstname}"
      
      redirect_to 'home'
    else
      
      session[:current_user] = @user
      
      flash[:success] = "Witaj ponownie, #{@user.firstname}"
      
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
