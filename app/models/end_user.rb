class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

with_options presence: true,on: :create do
    validates :email
    validates :first_name
    validates :last_name
    validates :last_name_kana
    validates :first_name_kana
    validates :postal_code
    validates :address
    validates :telephone_number
    validates :password
  end

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders

def active_for_authentication?
    super && (self.is_unsubscribe == false)
end

end
