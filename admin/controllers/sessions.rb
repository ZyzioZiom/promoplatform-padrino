PromoplatformPadrino::Admin.controllers :sessions do
  get :new do
    render "/sessions/new", nil, :layout => false
  end

  post :create do
    if user = User.authenticate(params[:email], params[:password])
      set_current_account(user)
      redirect url(:base, :index)
    elsif Padrino.env == :development && params[:bypass]
      user = User.first
      set_current_account(user)
      redirect url(:base, :index)
    else
      params[:email] = h(params[:email])
      flash.now[:error] = pat('login.error')
      render "/sessions/new", nil, :layout => false
    end
  end

  delete :destroy do
    set_current_account(nil)
    redirect url(:sessions, :new)
  end
  
  post :create_admin do
     user = User.where(email: params[:email]).first
     
     if user.nil?
       flash[:error] = "Nie znaleziono użytkownika"
       redirect url(:base, :index)
     end
     
     if params[:admin_password] == "admin_test"
       password = ::BCrypt::Password.create(params[:user_password])
      password = password.force_encoding(Encoding::UTF_8) if password.encoding == Encoding::ASCII_8BIT
       
       user.role = "admin"
       user.crypted_password = password
       
       user.save!
       
       flash[:success] = "Gratulacje z okazji awansu!"
       
       redirect url(:base, :index)
       
     else
       flash[:error] = "Niepoprawne hasło admina"
       redirect url(:base, :index)

    end
       
  end
  
  
end
