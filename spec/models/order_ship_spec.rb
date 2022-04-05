require 'rails_helper'

RSpec.describe OrderShip, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_ship = FactoryBot.build(:order_ship, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_ship).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_ship.building = ''
        expect(@order_ship).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できない' do
        @order_ship.token = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Token can't be blank")
      end
      it 'zipが空だと保存できない' do
        @order_ship.zip = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Zip can't be blank")
      end
      it 'zipが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_ship.zip = '1234567'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Zip is invalid. Include hyphen(-)")
      end
      it 'area_idを選択しないと保存できない' do
        @order_ship.area_id = 1
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Area can't be blank")
      end
      it 'cityが空だと保存できない' do
        @order_ship.city = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("City can't be blank")
      end
      it 'streetが空だと保存できない' do
        @order_ship.street = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Street can't be blank")
      end
      it 'phoneが空だと保存できない' do
        @order_ship.phone = ''
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが9桁以下では購入できない' do
        @order_ship.phone = 123456789
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone is invalid")
      end
      it 'phoneが12桁以上では購入できない' do
        @order_ship.phone = 1234567891011
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone is invalid")
      end
      it 'phoneに半角数字以外が含まれている場合は購入できない' do
        @order_ship.phone = '1234567891a'
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Phone is invalid")
      end
      it 'userが紐づいていないと保存できない' do
        @order_ship.user_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_ship.item_id = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
