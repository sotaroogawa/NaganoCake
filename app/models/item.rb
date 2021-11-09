class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  
  attachment :image

  def add_tax_price
        (self.price * 1.1).round
  end

  def self.search(search)
    if search
      Item.where(['name LIKE ?', "%#{search}%"])
    else
      Item.all
    end
  end
end
