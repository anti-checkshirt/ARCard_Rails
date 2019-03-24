Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      post 'users' => 'users#signup'
      post 'signin' => 'user#signin'
      post 'users/image_regist' => 'user#image_regist'
      get 'users' => 'users#signup'
      patch 'users' => 'user#update'
      delete 'users' => 'user#delete'
      post 'Judgment' => 'judgement#show'
    end
  end
end
