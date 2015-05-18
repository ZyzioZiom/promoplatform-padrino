PromoplatformPadrino::App.controllers :users do
  
  get :index do
    @users = User.all
    
    render 'users/index'
  end
  
  get :index, :with => :id do
    @user = User.find(params[:id])
    
    @actions = Action.where(user_id: params[:id])
    
    @sum_points = Action.sum_points(params[:id])
      
    render 'users/show'
  end
end
