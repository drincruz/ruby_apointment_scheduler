Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :appointments

  get 'user/appointments', to: 'user_appointments#appointments'
end
