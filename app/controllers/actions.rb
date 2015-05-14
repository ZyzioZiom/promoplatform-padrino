PromoplatformPadrino::App.controllers :actions do
  
  get :index do
    @actions = Action.sum_confirmed
    
    @ranking = @actions.sort_by { |k,v| v }.reverse
    
    
    render 'actions/index'
  end
  
  post :create do
    activity_id = params[:action][:activity_id].to_i
    activity = Activity.find(activity_id)
    
    action = Action.new
    
    action.user_id = current_user.id
    action.activity_id = activity_id
    action.confirmed = false
    action.points = activity.points
    
    if action.save
      flash[:notice] = 'Zapisano na aktywność'
      
      message = Message.new
      message.user_id = current_user.id
      message.content = "zapisał(a) się na "
      message.activity_id = activity.id
      
      message.save!
      
      redirect back
    end
  end
  
  post :update do
    activity_id = params[:action][:activity_id].to_i
    
    @action = Action.current(activity_id, current_user)
    
    @action.confirmed = true
    @action.confirmation = params[:action][:confirmation]
    
    if @action.save
      redirect back
    end
  end
  
end
