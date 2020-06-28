require "rails_helper"
describe User do
  describe "#create" do
    describe "入力されているか、されていないか" do
      it "nickname,email,password,password_confirmationがあれば登録できる" do
        user = build(:user)
        user.valid?
        expect(user).to be_valid
      end

      it "nicknameがない場合は登録できない" do
        user = build(:user, nickname: "")
        user.valid?
        expect(user.errors[:nickname]).to include("・入力してください")
      end

      it "emailがない場合は登録できない" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("・入力内容が正しくありません")
      end

      it "passwordがない場合は登録できない" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("・7文字以上で入力してください", "・入力内容が正しくありません")
      end

      it "passwordがあっても、password_confirmationがない場合は登録できない" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("・パスワードの入力が一致しません")
      end
    end

    describe "パスワードの入力内容が正しいかどうか" do
      it "passwordが7文字以上で半角英数字が含まれていたら登録できる" do
        user = build(:user, password: "a111111", password_confirmation: "a111111")
        user.valid?
        expect(user).to be_valid
      end

      it "passwordは7文字以上じゃないと登録できない" do
        user = build(:user, password: "a11111")
        user.valid?
        expect(user.errors[:password]).to include("・7文字以上で入力してください")
      end

      it "passwordに全角文字が含まれていると登録できない" do
        user = build(:user, password: "Ａ111111", password_confirmation: "Ａ111111")
        user.valid?
        expect(user.errors[:password]).to include("・入力内容が正しくありません")
      end

      it "passwordに数字しかないと登録できない" do
        user = build(:user, password: "1111111", password_confirmation: "1111111")
        user.valid?
        expect(user.errors[:password]).to include("・入力内容が正しくありません")
      end

      it "passwordに英語しかないと登録できない" do
        user = build(:user, password: "aaaaaaa", password_confirmation: "aaaaaaa")
        user.valid?
        expect(user.errors[:password]).to include("・入力内容が正しくありません")
      end
    end

    describe "メールアドレスの入力内容が正しいかどうか" do
      it "重複したemaiがあれば登録できない" do
        user1 = create(:user, email: "a123456@gmail.com")
        user2 = build(:user, email: "a123456@gmail.com")
        user2.valid?
        expect(user2.errors[:email]).to include("・すでに存在します")
      end

      it "emailが正しいフォーマットで書かれていれば登録できる" do
        user = build(:user, email: "a123456@gmail.com")
        user.valid?
        expect(user).to be_valid
      end

      it "emailが誤ったフォーマットで書かれていると登録できない" do
        user = build(:user, email: "hoge@hoge")
        user.valid?
        expect(user.errors[:email]).to include("・入力内容が正しくありません")
      end
    end

    describe "確認用パスワードの入力内容が正しいかどうか" do
      it "passwordとpassword_confirmationが一致すれば登録できる" do
        user = build(:user, password: "a111111", password_confirmation: "a111111")
        user.valid?
        expect(user).to be_valid
      end

      it "passwordとpassword_confirmationが一致しない場合は登録できない" do
        user = build(:user, password_confirmation: "s111111")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("・パスワードの入力が一致しません")
      end
    end
  end
end