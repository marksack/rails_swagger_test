class Api::V1::AuthenticationController < Api::V1::ApiBaseController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @account = Account.authenticate_api(params[:email], params[:password])
    if @account
      token = ::Auth::JsonWebToken.encode(account_id: @account.id)
      time = Time.now + 6.months.to_i
      render json: {
        id: @account.id,
        email: @account.email,
        access_token: token,
        exp: time.strftime('%m-%d-%Y %H:%M')
      }, status: :ok
    else
      render json: { error: 'Email or password invalid.' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end