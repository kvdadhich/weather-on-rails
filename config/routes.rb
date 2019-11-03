Rails.application.routes.draw do
  root :to => 'weather#index'

  get "get_current_temp", to: "weather#get_current_weather"
  get "get_temp", to: "weather#get_weather"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
