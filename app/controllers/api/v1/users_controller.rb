# frozen_string_literal: true
require 'json'
require './app/services/firebase'

class Api::V1::UsersController < Api::ApplicationController
  def signup
    firebase = FirebaseClient.new
    res = firebase.verification_user_by_id_token(params[:id_token])
    if res.code == 200
      if User.find_by(id_token: params[:id_token])
        # 既にこのid_tokenを保有するUserが存在する場合
        unauthorized
      else
        if (ENV[:API_KEY] == request.header[:HTTP_API_KEY]) && (ENV[:API_SECRET] == request.header[:HTTP_API_SECRET])
          @user = User.new(
            name: params[:name],
            id_token: params[:id_token],
            occupation: params[:occupation],
            age: params[:age],
            gender: params[:gender]
          )
          payload = TokenProvider.refresh_tokens @user
          response_success('signup', 'create', payload)
        else
          responce_forbidden
        end
      end
    else
      response_bad_request
    end
  end

  def signin
    firebase = FirebaseClient.new
    res = firebase.verification_user_by_id_token(params[:id_token])
    if res.code == 200
      user = User.find_by(id_token: params[:id_token])
      tokens = TokenProvider.refresh_tokens user
      response_success('signin', 'login', tokens)
    else
      unauthorized
    end
  end
end
