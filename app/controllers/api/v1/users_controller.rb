# frozen_string_literal: true
require 'json'
require './app/services/firebase'

class Api::V1::UsersController < Api::ApplicationController
  def signup
    if (ENV["API_KEY"] == request.headers["HTTP_API_KEY"]) && (ENV["API_SECRET"] == request.headers["HTTP_API_SECRET"])
      firebase = FirebaseClient.new
      res = firebase.verification_user_by_id_token(params[:id_token])
      if res.code == 403
        if User.find_by(id_token: params[:id_token])
          # 既にこのid_tokenを保有するUserが存在する場合
          response_unauthorized
        else
          @user = User.new(user_params)
          payload = TokenProvider.refresh_tokens @user
          response_success('signup', 'create', payload)
        end
      else
        response_bad_request
      end
    else
      responce_forbidden
    end
  end

  def signin
    if (ENV["API_KEY"] == request.headers["HTTP_API_KEY"]) && (ENV["API_SECRET"] == request.headers["HTTP_API_SECRET"])
      firebase = FirebaseClient.new
      res = firebase.verification_user_by_id_token(params[:id_token])
      if res.code == 403
        user = User.find_by(id_token: params[:id_token])
        tokens = TokenProvider.refresh_tokens user
        response_success('signin', 'login', tokens)
      else
        response_unauthorized
      end
    else
      responce_forbidden
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :id_token, :occupation, :age, :gender)
  end
end
