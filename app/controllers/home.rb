PromoplatformPadrino::App.controllers :home do
  
  get :index do
    @theme_variables = Theme.current
    
    render 'home/index'
  end
  

end