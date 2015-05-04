PromoplatformPadrino::Admin.controllers :actions do
  get :index do
    @title = "Actions"
    @actions = Action.all
    render 'actions/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'action')
    @action = Action.new
    render 'actions/new'
  end

  post :create do
    @action = Action.new(params[:action])
    if @action.save
      @title = pat(:create_title, :model => "action #{@action.id}")
      flash[:success] = pat(:create_success, :model => 'Action')
      params[:save_and_continue] ? redirect(url(:actions, :index)) : redirect(url(:actions, :edit, :id => @action.id))
    else
      @title = pat(:create_title, :model => 'action')
      flash.now[:error] = pat(:create_error, :model => 'action')
      render 'actions/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "action #{params[:id]}")
    @action = Action.find(params[:id])
    if @action
      render 'actions/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'action', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "action #{params[:id]}")
    @action = Action.find(params[:id])
    if @action
      if @action.update_attributes(params[:action])
        flash[:success] = pat(:update_success, :model => 'Action', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:actions, :index)) :
          redirect(url(:actions, :edit, :id => @action.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'action')
        render 'actions/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'action', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Actions"
    action = Action.find(params[:id])
    if action
      if action.destroy
        flash[:success] = pat(:delete_success, :model => 'Action', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'action')
      end
      redirect url(:actions, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'action', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Actions"
    unless params[:action_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'action')
      redirect(url(:actions, :index))
    end
    ids = params[:action_ids].split(',').map(&:strip)
    actions = Action.find(ids)
    
    if Action.destroy actions
    
      flash[:success] = pat(:destroy_many_success, :model => 'Actions', :ids => "#{ids.to_sentence}")
    end
    redirect url(:actions, :index)
  end
end
