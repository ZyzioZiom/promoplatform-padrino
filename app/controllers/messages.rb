PromoplatformPadrino::App.controllers :messages do
  post :create do
    message = Message.new
    message.who = session[:current_user].id
    message.content = params[:message][:content]
    
    if message.save!
      redirect back
    end
  end

end
