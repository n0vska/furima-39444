# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        expect(duplicate_user).not_to be_valid
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'test.example.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it 'パスワードが半角英字のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it 'パスワードが半角数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it 'パスワードが全角文字を含む場合は登録できないこと' do
        @user.password = 'ABCdef1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password と確認用パスワードが一致しません')
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '654321'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)の名字が空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'お名前(全角)の名前が空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前(全角)の名字が全角でなければ登録できないこと' do
        @user.last_name = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'お名前(全角)の名前が全角でなければ登録できないこと' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'お名前カナ(全角)の名字が空では登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'お名前カナ(全角)の名前が空では登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'お名前カナ(全角)の名字がカタカナでなければ登録できないこと' do
        @user.last_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください')
      end

      it 'お名前カナ(全角)の名前がカタカナでなければ登録できないこと' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください')
      end

      it '生年月日が空では登録できないこと' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end
    end
  end
end
