class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable

  def self.authenticate_api(email, password)
    account = Account.find_for_authentication(email: email)
    account&.valid_password?(password) ? account : nil
  end
end
