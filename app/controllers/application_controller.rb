class ApplicationController < ActionController::API
  include UserAuthenticator

  rescue_from JWT::DecodeError, with: :token_invalid
  rescue_from JWT::ExpiredSignature, with: :token_has_expired
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private
  def token_invalid
    render json: { status: :error, message: :token_must_be_passed }, status: 401
  end

  def token_has_expired
    render json: { status: :error, message: :token_has_expired }, status: 403
  end

  def parameter_missing
    render json: {
        status: error,
        message: :parameter_missing,
        data: {
            parameter: exception.param
        }
    }, status: 400
  end

  def unauthorized
    render json: { status: :error, message: :unauthorized }, status: 401
  end

  def record_invalid
    render json: {
        status: :error,
        message: :record_invalid,
        data: exception.record.errors
    }, status: 422
  end

  # 200 Status OK
  def response_success(class_name, action_name, data = nil)
    if data.nil?
      render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}" }
    else
      render status: 200, json:{ status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}", data: data }
    end

  end

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 403 Forbidden
  def responce_forbidden
    render status: 403, json: { status: 403, message: 'Forbidden'}
  end

  # 404 Not Found
  def response_not_found(class_name)
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end
end
