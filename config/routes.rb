Unsubscribe::Engine.routes.draw do
  resources :mailer_subscriptions, only: [:create, :update, :show]
end
