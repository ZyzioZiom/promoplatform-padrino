PromoplatformPadrino::Admin.controllers :sessions do
  get :new do
    render "/sessions/new", nil, :layout => false
  end

  post :create do
    if user = User.authenticate(params[:email], params[:password])
      set_current_user(user)
      redirect url(:base, :index)
    elsif Padrino.env == :development && params[:bypass]
      user = User.first
      set_current_user(user)
      redirect url(:base, :index)
    else
      params[:email] = h(params[:email])
      flash.now[:error] = pat('login.error')
      render "/sessions/new", nil, :layout => false
    end
  end

  delete :destroy do
    set_current_user(nil)
    redirect url(:sessions, :new)
  end
end
