PromoplatformPadrino::App.controllers :home do
  
  get :index do
    
    # get messages for shoutbox
    @messages = Message.order(created_at: :desc).first(50)
    
    render 'home/index'
  end
  
  get :create do
  
  end
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
  

end