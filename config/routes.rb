Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/test", to: "tests#test"

  namespace :api, path: '/' do
    namespace :v1, path: '/' do

      namespace :nfe do

        post "certificates/list", to: "certificates#list"
        post "certificates/read", to: "certificates#read"
        post "certificates/create", to: "certificates#create"
        put "certificates/update", to: "certificates#update"
        put "certificates/save_upload", to: "certificates#save_upload"

        post "companies/list", to: "companies#list"
        post "companies/read", to: "companies#read"
        post "companies/create", to: "companies#create"
        put "companies/update", to: "companies#update"

        post "invoices/list", to: "invoices#list"
        post "invoices/read", to: "invoices#read"
        post "invoices/create", to: "invoices#create"
        put "invoices/update", to: "invoices#update"

      end

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
            
            post "cnaes/list_ctiss", to: "cnaes#list_ctiss"
            post "cnaes/list", to: "cnaes#list"
            post "cnaes/read", to: "cnaes#read"
            post "cnaes/create", to: "cnaes#create"
            put "cnaes/update", to: "cnaes#update"

            post "dates/create", to: "dates#create"
            post "dates/read", to: "dates#read"
            post "dates/list", to: "dates#list"
            put "dates/update", to: "dates#update"

            post "invoices/list", to: "invoices#list"
            post "invoices/read", to: "invoices#read"
            post "invoices/create", to: "invoices#create"
            put "invoices/update", to: "invoices#update"

            post "monthly_calculations/list", to: "monthly_calculations#list"
            post "monthly_calculations/read", to: "monthly_calculations#read"
            post "monthly_calculations/create", to: "monthly_calculations#create"
            put "monthly_calculations/update", to: "monthly_calculations#update"

            post "partners/list", to: "partners#list"
            post "partners/read", to: "partners#read"
            post "partners/create", to: "partners#create"
            put "partners/update", to: "partners#update"

            post "receipts/list", to: "receipts#list"
            post "receipts/read", to: "receipts#read"
            post "receipts/create", to: "receipts#create"
            put "receipts/update", to: "receipts#update"

            post "regime_parameters/list", to: "regime_parameters#list"
            post "regime_parameters/read", to: "regime_parameters#read"
            post "regime_parameters/create", to: "regime_parameters#create"
            put "regime_parameters/update", to: "regime_parameters#update"

            post "social_contracts/list", to: "social_contracts#list"
            post "social_contracts/read", to: "social_contracts#read"
            post "social_contracts/create", to: "social_contracts#create"
            put "social_contracts/update", to: "social_contracts#update"

            post "takers/list", to: "takers#list"
            post "takers/read", to: "takers#read"
            post "takers/create", to: "takers#create"
            put "takers/update", to: "takers#update"

            post "yearly_calculations/list", to: "yearly_calculations#list"
            post "yearly_calculations/read", to: "yearly_calculations#read"
            post "yearly_calculations/create", to: "yearly_calculations#create"
            put "yearly_calculations/update", to: "yearly_calculations#update"

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
