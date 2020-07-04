require "rails_helper"
describe Profile do
  describe "#create" do
    describe "入力されているか、されていないか" do
      it "first_name,last_name,first_name_kana,last_name_kana,birthdayがあれば登録できる" do
        profile = build(:profile)
        profile.valid?
        expect(profile).to be_valid
      end

      it "first_nameがない場合は登録できない" do
        profile = build(:profile, first_name: "")
        profile.valid?
        expect(profile.errors[:first_name]).to include("・入力してください")
      end

      it "last_nameがない場合は登録できない" do
        profile = build(:profile, last_name: "")
        profile.valid?
        expect(profile.errors[:last_name]).to include("・入力してください")
      end

      it "first_name_kanaがない場合は登録できない" do
        profile = build(:profile, first_name_kana: "")
        profile.valid?
        expect(profile.errors[:first_name_kana]).to include("・入力してください")
      end

      it "last_name_kanaがない場合は登録できない" do
        profile = build(:profile, last_name_kana: "")
        profile.valid?
        expect(profile.errors[:last_name_kana]).to include("・入力してください")
      end

      it "birthdayがない場合は登録できない" do
        profile = build(:profile, birthday: "")
        profile.valid?
        expect(profile.errors[:birthday]).to include("・入力してください")
      end
    end

    describe "姓名の入力内容が正しいかどうか" do
      it "first_nameが漢字、または平仮名であれば登録できる" do
        profile = build(:profile, first_name: "太郎")
        profile.valid?
        expect(profile).to be_valid
      end

      it "last_nameが漢字、または平仮名であれば登録できる" do
        profile = build(:profile, last_name: "保外")
        profile.valid?
        expect(profile).to be_valid
      end

      it "first_nameに漢字、または平仮名以外が含まれる場合は登録できない" do
        profile = build(:profile, first_name: "タロウ")
        profile.valid?
        expect(profile.errors[:first_name]).to include("・入力内容が正しくありません")
      end

      it "last_nameに漢字、または平仮名以外が含まれる場合は登録できない" do
        profile = build(:profile, last_name: "ホゲ")
        profile.valid?
        expect(profile.errors[:last_name]).to include("・入力内容が正しくありません")
      end
    end

    describe "姓名カナの入力内容が正しいかどうか" do
      it "first_name_kanaがカタカナであれば登録できる" do
        profile = build(:profile, first_name_kana: "タロウ")
        profile.valid?
        expect(profile).to be_valid
      end

      it "last_name_kanaがカタカナであれば登録できる" do
        profile = build(:profile, last_name_kana: "ホゲ")
        profile.valid?
        expect(profile).to be_valid
      end

      it "first_name_kanaにカタカナ以外が含まれる場合は登録できない" do
        profile = build(:profile, first_name_kana: "太郎")
        profile.valid?
        expect(profile.errors[:first_name_kana]).to include("・入力内容が正しくありません")
      end

      it "last_name_kanaにカタカナ以外が含まれる場合は登録できない" do
        profile = build(:profile, last_name_kana: "保外")
        profile.valid?
        expect(profile.errors[:last_name_kana]).to include("・入力内容が正しくありません")
      end
    end
  end
end