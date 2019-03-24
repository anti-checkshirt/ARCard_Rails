# frozen_string_literal: true

require './app/services/firebase'

class Api::V1::UsersController < ApplicationController
  def signup
    firebase = FirebaseClient.new
    firebase.verification_user_by_id_token(params['id_token'])
    response_success('signup', 'create')
  end
end
