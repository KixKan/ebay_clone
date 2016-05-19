Rails.application.routes.draw do
 root 'items#index'
 get  "/items/new"                =>  "items#new"
 post "/items"                    =>  "items#create"
 get  "/items/:id/purchases/new"  =>  "purchases#new"
 post "/items/:id/purchases"      =>  "purchases#create"
end
