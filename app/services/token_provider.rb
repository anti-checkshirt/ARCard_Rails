class TokenProvider
  class << self
    def decode(token)
      JWT.decode token, Rails.application.secrets.secret_key_base
    end

    def refresh_tokens(user)
      tokens = TokenProvider.create_pair_tokens id: user.id.to_s
      user.update_attribute :refresh_token, tokens[:refresh_token]

      tokens
    end

    def create_pair_tokens(payload)
      {
        access_token: issue_token(payload.merge(exp: Time.current.to_i + 30.days)),
        refresh_token: issue_token(payload.merge(exp: Time.current.to_i + 60.days))
      }
    end

    private

    def issue_token(payload)
      JWT.encode payload, Rails.application.secrets.secret_key_base
    end
  end
end
