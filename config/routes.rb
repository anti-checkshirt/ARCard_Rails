Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      post 'users' => 'users#signup'
      post 'signin' => 'users#signin'
      post 'users/image_regist' => 'user#image_regist'
      get 'users' => 'users#signup'
      patch 'users' => 'users#update'
      delete 'users' => 'users#delete'
      post 'Judgment' => 'judgement#show'
    end
  end
end
