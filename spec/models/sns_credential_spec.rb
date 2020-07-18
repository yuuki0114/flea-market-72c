require "rails_helper"
describe SnsCredential do
  describe "#create" do
    it "providerとuidがあれば登録できる" do
      sns = build(:sns_credential)
      sns.valid?
      expect(sns).to be_valid
    end

    it "providerがない場合は登録できない" do
      sns = build(:sns_credential, provider: "")
      sns.valid?
      expect(sns.errors[:provider]).to include("・入力してください")
    end

    it "uidがない場合は登録できない" do
      sns = build(:sns_credential, uid: "")
      sns.valid?
      expect(sns.errors[:uid]).to include("・入力してください")
    end
  end
end