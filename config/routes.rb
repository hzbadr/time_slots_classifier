Rails.application.routes.draw do
  post '/notify', to: 'notifiers#create'
end
