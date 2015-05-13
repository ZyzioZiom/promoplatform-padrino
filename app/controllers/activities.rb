PromoplatformPadrino::App.controllers :activities do

  get :index do
    @activities = Activity.all
    
    render 'activities/index'
  end

  get :index, :with => :id do
    
    if params[:id].to_i.to_s == params[:id] # if id is integer
      
      @activity = Activity.find(params[:id])
      @signed = Action.where(activity_id: params[:id])
      
      @current_user_signed = Action.current(params[:id], current_user)

      unless @activity.nil?
        render 'activities/show'
      end
      
    else
      
      @activities = Activity.category(params[:id])
      
      unless @activities.nil?
        render 'activities/index'
      end
     
      
    end
  end
  
end
