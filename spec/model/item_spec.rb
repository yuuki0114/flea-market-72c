require 'rails_helper'
describe Item do
  describe '#create' do

    it "nameがない場合は登録できないこと" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "detailがない場合は登録できないこと" do
      item = build(:item, detail: "")
      item.valid?
      expect(item.errors[:detail]).to include("can't be blank")
    end
    
    it "statusがない場合は登録できないこと" do
      item = build(:item, status: "")
      item.valid?
      expect(item.errors[:status]).to include("can't be blank")
    end

    it "delivery_feeがない場合は登録できないこと" do
      item = build(:item, delivery_fee: "")
      item.valid?
      expect(item.errors[:delivery_fee]).to include("can't be blank")
    end

    it "start_addressがない場合は登録できないこと" do
      item = build(:item, start_address: "")
      item.valid?
      expect(item.errors[:start_address]).to include("can't be blank")
    end

    it "shipping_dateがない場合は登録できないこと" do
      item = build(:item, shipping_date: "")
      item.valid?
      expect(item.errors[:shipping_date]).to include("can't be blank")
    end

    it "priceがない場合は登録できないこと" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

  end
end