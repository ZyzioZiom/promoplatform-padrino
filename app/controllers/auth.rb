PromoplatformPadrino::App.controllers :auth do
  
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
    
    first_name = omniauth['info']['first_name']
    last_name = omniauth['info']['last_name']
    email = omniauth['info']['email']
    image = omniauth['info']['image']

    "User logged in: #{first_name} #{last_name}, #{email}, #{image}" 
    
    #############
    ### CREATE NEW USER IN ACCOUNTS TABLE WITH ROLE "USER"
    #############
    
    
  end

  get :google_oauth2_callback_failed, :map => "/auth/failure" do
    flash[:error] = "Error logging with Google #{params[:message]}"

    redirect url("/")
  end
end
