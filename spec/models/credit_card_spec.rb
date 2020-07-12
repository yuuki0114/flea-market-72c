require "rails_helper"
describe CreditCard do
  describe '#create' do
    it "user_id、customer_id、card_idが存在すれば登録できること" do
      creditcard = build(:credit_card)
      expect(creditcard).to be_valid
    end

    it "customer_idがない場合は登録できないこと" do
      creditcard = build(:credit_card, customer_id: "")
      creditcard.valid?
      expect(creditcard.errors[:customer_id]).to include("・入力してください")
    end

    it "card_idがない場合は登録できないこと" do
      creditcard = build(:credit_card, card_id: "")
      creditcard.valid?
      expect(creditcard.errors[:card_id]).to include("・入力してください")
    end

  end
end