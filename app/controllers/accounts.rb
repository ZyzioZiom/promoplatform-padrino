PromoplatformPadrino::App.controllers :accounts do
  
  get :index do
    @accounts = Account.all
    
    render 'accounts/index'
  end
  
  get :index, :with => :id do
    @user = Account.find(params[:id])
    
    render 'accounts/show'
  end
end
