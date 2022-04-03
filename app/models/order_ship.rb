class OrderShip
  include ActiveModel::Model
  attr_accessor :zip, :area_id, :city, :street, :building, :phone, :item_id, :user_id
  attr_accessor :token

  with_options presence: true do
    validates :token
    validates :zip, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street
    validates :phone, format: { with: /\A\d{10}$|^\d{11}\z/ }
    validates :user_id
    validates :item_id
  end
  validate :building

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Ship.create(zip: zip, area_id: area_id, city: city, street: street, building: building, phone: phone, order_id: order.id)
  end
end