PromoplatformPadrino::App.controllers :messages do
  post :create do
    message = Message.new
    message.who = session[:current_user].id
    message.content = params[:message][:content]
    
    if message.save!
      redirect back
    end
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
