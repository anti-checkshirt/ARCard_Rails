require 'httparty'
class FirebaseClient
  def verification_user_by_id_token(id_token)
    base_url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=#{ENV['firebase_token']}".freeze
    HTTParty.post(
                base_url,
                :body => {:idToken => id_token}
    )
  end
end
