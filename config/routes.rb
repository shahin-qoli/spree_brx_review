Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :api do
    namespace :v2 do
      namespace :storefront do
        resource :reviews,only:[] do 
        post :create
        get "/index", to: "reviews#index"
        put "/image", to:"reviews#save_image"
        post "/check", to: "reviews#check_is_buyer"
        end
        resource :review_feedbacks,only:[] do
          post :create
        end

      end
    end
  end

  namespace :admin do
    resource :reviews, only:[] do
      get :index
      get "/approve", to:"reviews#approve"
      get "/not_approve", to:"reviews#not_approve"
    end
  end
end
