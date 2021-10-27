module Api
  module V1
    class ApiBaseController < ActionController::API

      def not_found
        render json: { error: 'not_found' }
      end

      def authorize_request
        header = request.headers['Authorization']
        begin
          @decoded = Auth::JsonWebToken.decode(header)
          @current_account = Account.find(@decoded[:account_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end
    end
  end
end