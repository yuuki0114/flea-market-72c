require "rails_helper"
describe Address do
  describe "#create" do
    describe "入力されているか、されていないか" do
      it "first_name,last_name,first_name_kana,last_name_kana,postal_code,prefectures,municipalities,street_numberがあれば登録できる" do
        address = build(:address)
        address.valid?
        expect(address).to be_valid
      end

      it "first_nameがない場合は登録できない" do
        address = build(:address, first_name: "")
        address.valid?
        expect(address.errors[:first_name]).to include("・入力してください")
      end

      it "last_nameがない場合は登録できない" do
        address = build(:address, last_name: "")
        address.valid?
        expect(address.errors[:last_name]).to include("・入力してください")
      end

      it "first_name_kanaがない場合は登録できない" do
        address = build(:address, first_name_kana: "")
        address.valid?
        expect(address.errors[:first_name_kana]).to include("・入力してください")
      end

      it "last_name_kanaがない場合は登録できない" do
        address = build(:address, last_name_kana: "")
        address.valid?
        expect(address.errors[:last_name_kana]).to include("・入力してください")
      end

      it "postal_codeがない場合は登録できない" do
        address = build(:address, postal_code: "")
        address.valid?
        expect(address.errors[:postal_code]).to include("・入力してください")
      end

      it "prefecturesがない場合は登録できない" do
        address = build(:address, prefectures: "")
        address.valid?
        expect(address.errors[:prefectures]).to include("・入力してください")
      end

      it "municipalitiesがない場合は登録できない" do
        address = build(:address, municipalities: "")
        address.valid?
        expect(address.errors[:municipalities]).to include("・入力してください")
      end

      it "street_numberがない場合は登録できない" do
        address = build(:address, street_number: "")
        address.valid?
        expect(address.errors[:street_number]).to include("・入力してください")
      end
    end

    describe "姓名の入力内容が正しいかどうか" do
      it "first_nameが漢字、または平仮名であれば登録できる" do
        address = build(:address, first_name: "太郎")
        address.valid?
        expect(address).to be_valid
      end

      it "last_nameが漢字、または平仮名であれば登録できる" do
        address = build(:address, last_name: "保外")
        address.valid?
        expect(address).to be_valid
      end

      it "first_nameに漢字、または平仮名以外が含まれる場合は登録できない" do
        address = build(:address, first_name: "タロウ")
        address.valid?
        expect(address.errors[:first_name]).to include("・入力内容が正しくありません")
      end

      it "last_nameに漢字、または平仮名以外が含まれる場合は登録できない" do
        address = build(:address, last_name: "ホゲ")
        address.valid?
        expect(address.errors[:last_name]).to include("・入力内容が正しくありません")
      end
    end

    describe "姓名カナの入力内容が正しいかどうか" do
      it "first_name_kanaがカタカナであれば登録できる" do
        address = build(:address, first_name_kana: "タロウ")
        address.valid?
        expect(address).to be_valid
      end

      it "last_name_kanaがカタカナであれば登録できる" do
        address = build(:address, last_name_kana: "ホゲ")
        address.valid?
        expect(address).to be_valid
      end

      it "first_name_kanaにカタカナ以外が含まれる場合は登録できない" do
        address = build(:address, first_name_kana: "太郎")
        address.valid?
        expect(address.errors[:first_name_kana]).to include("・入力内容が正しくありません")
      end

      it "last_name_kanaにカタカナ以外が含まれる場合は登録できない" do
        address = build(:address, last_name_kana: "保外")
        address.valid?
        expect(address.errors[:last_name_kana]).to include("・入力内容が正しくありません")
      end
    end

    describe "郵便番号の入力内容が正しいかどうか" do
      it "postal_codeがハイフンによって3桁と4桁に分けられた、合計7桁で書かれていれば登録できる" do
        address = build(:address, postal_code: "123-4567")
        address.valid?
        expect(address).to be_valid
      end

      it "postal_codeにハイフンが含まれていないと登録できない" do
        address = build(:address, postal_code: "1234567")
        address.valid?
        expect(address.errors[:postal_code]).to include("・入力内容が正しくありません")
      end
    end

    describe "電話番号の入力内容が正しいかどうか" do
      it "telephone_numberが10桁以上であれば登録できる" do
        address = build(:address, telephone_number: "0901234567")
        address.valid?
        expect(address).to be_valid
      end

      it "telephone_numberが11桁以下であれば登録できる" do
        address = build(:address, telephone_number: "09012345678")
        address.valid?
        expect(address).to be_valid
      end

      it "telephone_numberにハイフンなどの数字以外が含まれる場合は登録できない" do
        address = build(:address, telephone_number: "090-1234-5678")
        address.valid?
        expect(address.errors[:telephone_number]).to include("・入力内容が正しくありません")
      end
    end
  end
end