PromoplatformPadrino::App.controllers :actions do
  
  get :index do
    @actions = Action.all
        
    render 'actions/index'
  end
  
  post :create do
    activity_id = params[:action][:activity_id].to_i
    activity = Activity.find(activity_id)
    
    @action = Action.new
    
    @action.account_id = session[:current_user].id
    @action.activity_id = activity_id
    @action.confirmed = false
    @action.points = activity.points
    
    if @action.save
      flash[:notice] = 'Zapisano na aktywność'
      redirect back
    end
  end
  
end
