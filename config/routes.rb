Rails.application.routes.draw do
  root 'items#index'
  get  "/items/new"                         =>  "items#new"
  post "/items"                             =>  "items#create"
  get  "/items/:id/purchases/new"           =>  "purchases#new", as: 'new_purchase'
  post "/items/:id/purchases"               =>  "purchases#create"
  get  "/items/:item_id/purchases/:id"      =>  "purchases#show"
end
