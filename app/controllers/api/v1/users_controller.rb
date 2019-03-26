# frozen_string_literal: true
require 'json'
require './app/services/firebase'

class Api::V1::UsersController < Api::Base::ApplicationController
  def signup
    firebase = FirebaseClient.new
    res = firebase.verification_user_by_id_token(params[:id_token])
    p res
    if res == 200
      @user = User.new(
        name: "s0ra",
        id_token: "Test",
        occupation: "hoge",
        age: "fuga",
        gender: "hi"
      )
      payload = TokenProvider.refresh_tokens @user
      p payload

      response_success('signup', 'create', payload)
    else
      response_bad_request
    end
  end
end
