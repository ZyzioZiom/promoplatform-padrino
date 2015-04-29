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

    @user = Account.where(uid: uid, email: email).first
    
    
    if @user.nil?
      # user doesn't exist
      
      # create encrypted password which is user email
      password = ::BCrypt::Password.create(email)
      password = password.force_encoding(Encoding::UTF_8) if password.encoding == Encoding::ASCII_8BIT
      
      # create new user
      new_user = Account.create(uid: uid, email: email, name: first_name, surname: last_name, image: image, role: "user", crypted_password: password)
      
      session[:user] = new_user
      
      redirect_to 'home'
    else
      
      session[:user] = @user
      
      redirect_to 'home'
    end
    
  end

  get :google_oauth2_callback_failed, :map => "/auth/failure" do
    flash[:error] = "Error logging with Google #{params[:message]}"

  end
end
