PromoplatformPadrino::App.controllers :activities do

  get :index do
    @activities = Activity.all
    
    render 'activities/index'
  end

  get :index, :with => :id do
    if params[:id].to_i.to_s == params[:id] # if id is integer
      @activity = Activity.find(params[:id])
      @signed = Action.where(activity_id: params[:id])
      @current_user_signed = Action.where(activity_id: params[:id], user_id: session[:current_user]).first

      unless @activity.nil?
        render 'activities/show'
      end
      
    else
      
      @activities = Activity.where(category: params[:id]).order(:date, :hour).group_by(&:date)
      
      unless @activities.nil?
        render 'activities/index'
      end
     
      
    end
  end
  
end
