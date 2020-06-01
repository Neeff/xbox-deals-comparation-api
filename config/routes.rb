Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    get '/deals/en-us', to: 'deals#deals_us'
    get '/deals/es-cl', to: 'deals#deals_cl'
    get '/deals/es-ar', to: 'deals#deals_ar'

    ############
    get 'deals/us', to: 'deals#get_deals_us'
    get 'deals/cl', to: 'deals#get_deals_cl'
    get 'deals/ar', to: 'deals#get_deals_ar'
    get 'deals/all', to: 'deals#get_all_deals'
    get 'deals/count-by-region', to: 'deals#quantity'
    get 'deals/group-by-name-game', to: 'deals#group_by_name_game'


    ###################

   get 'currencies/get-currencies', to: 'currencies#get_currencies'
  end
end
