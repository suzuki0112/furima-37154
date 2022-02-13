require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname,email,password,password_confirmation,first_name,family_name,read_first,read_family,birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'read_firstが空では登録できない' do
        @user.read_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first can't be blank")
      end
      it 'read_familyが空では登録できない' do
        @user.read_family = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family can't be blank")
      end
      it 'birthが空では登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aa000'
        @user.password_confirmation = 'aa000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａaa000'
        @user.password_confirmation = 'ａaa000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'family_nameが半角では登録できない' do
        @user.family_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it 'read_firstが半角では登録できない' do
        @user.read_first = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid")
      end
      it 'read_familyが半角では登録できない' do
        @user.read_family = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid")
      end
      it 'read_firstが漢字では登録できない' do
        @user.read_first = '漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid")
      end
      it 'read_fimilyが漢字では登録できない' do
        @user.read_family = '漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid")
      end
      it 'read_firstがひらがなでは登録できない' do
        @user.read_first = 'ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid")
      end
      it 'read_familyがひらがなでは登録できない' do
        @user.read_family = 'ひらがな'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid")
      end
    end
  end
end
