module UserAuthenticator
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    def authenticate!
      payload, _ = TokenProvider.decode bearer_token

      @current_user = User.find(payload['id'])
    end

    def bearer_token
      pattern = /^Bearer /
      header = request.headers['Authorization']

      header.gsub(pattern, '') if header && header.match(pattern)
    end
  end
end