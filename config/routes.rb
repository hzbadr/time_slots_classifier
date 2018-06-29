Rails.application.routes.draw do
  post '/notify', to: 'notifiers#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
