PromoplatformPadrino::App.controllers :home do
  
  get :index do
    @theme_variables = Theme.variables
    
    render 'home/index'
  end
  

end