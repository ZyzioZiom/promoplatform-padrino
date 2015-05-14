PromoplatformPadrino::App.controllers :messages do
  post :create do
    message = Message.new
    message.user_id = current_user.id
    message.content = params[:message][:content]
    
    if message.save!
      redirect back
    end
  end

end
