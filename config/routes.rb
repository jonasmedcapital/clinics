Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, path: '/' do
    namespace :v1, path: '/' do

      namespace :operations do

        namespace :accounts do
          post "products/read", to: "products#read"
          post "products/read_with_calculations", to: "products#read_with_calculations"
          post "products/read_with_account", to: "products#read_with_account"
          post "products/list_with_accounts", to: "products#list_with_accounts"
        end
        
        namespace :products do

          post "entities/list", to: "entities#list"
          post "entities/read", to: "entities#read"
          post "entities/create", to: "entities#create"
          put "entities/update", to: "entities#update"

          namespace :clinics do

            namespace :cnaes do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

            namespace :invoices do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

            namespace :partners do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

            namespace :receipts do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

            namespace :regime_parameters do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

            namespace :social_contracts do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

            namespace :takers do
              post "entities/list", to: "entities#list"
              post "entities/read", to: "entities#read"
              post "entities/create", to: "entities#create"
              put "entities/update", to: "entities#update"
            end

          end
        end
      end

      namespace :users do
        namespace :accounts do

          post "entities/list", to: "entities#list"
          post "entities/read", to: "entities#read"
          post "entities/read_user", to: "entities#read_user"
          post "entities/read_products", to: "entities#read_products"
          post "entities/create", to: "entities#create"
          put "entities/update", to: "entities#update"
          
          post "emails/list", to: "emails#list"
          post "emails/read", to: "emails#read"
          post "emails/create", to: "emails#create"
          put "emails/update", to: "emails#update"
          put "emails/delete", to: "emails#delete"

          post "phones/list", to: "phones#list"
          post "phones/read", to: "phones#read"
          post "phones/create", to: "phones#create"
          put "phones/update", to: "phones#update"
          put "phones/delete", to: "phones#delete"
          
          post "addresses/list", to: "addresses#list"
          post "addresses/read", to: "addresses#read"
          post "addresses/create", to: "addresses#create"
          put "addresses/update", to: "addresses#update"
          put "addresses/delete", to: "addresses#delete"
          post "addresses/cities_by_state", to: "addresses#cities_by_state"

        end
        
        namespace :companies do
          post "settings/dashboard", to: "settings#dashboard"

          post "entities/list", to: "entities#list"
          post "entities/read", to: "entities#read"
          post "entities/read_user", to: "entities#read_user"
          post "entities/read_products", to: "entities#read_products"
          post "entities/create", to: "entities#create"
          put "entities/update", to: "entities#update"
        end
        
      end

    end
  end
end
