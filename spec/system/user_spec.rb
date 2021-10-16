require 'rails_helper'

RSpec.describe 'ユーザー登録テスト', type: :system do
  describe 'ユーザー登録テスト' do

  context 'ユーザーを新規登録' do
    before do
    end
    it '新規登録した時名前が表示されるか' do
      visit new_user_path
      fill_in 'user[user_name]', with: 'ユーザー'
      fill_in 'user[email]', with: 'user@gmail.com'
      fill_in 'user[password]', with: 'uuuuuuu'
      fill_in 'user[password_confirmation]', with: 'uuuuuuu'
      click_button "Create my account"
      expect(page).to have_content 'ユーザー'
    end
  end
  context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
    it 'ログイン画面に遷移' do
      visit tasks_path
      expect(page).to have_content 'Log in'
    end
  end
end
@user1 = FactoryBot.create(:user)
@user2 = FactoryBot.create(:second_user)

describe 'セッション機能のテスト(一般ユーザー)' do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:second_user)

    visit new_session_path
    fill_in 'session[email]', with: 'test@gmail.com' 
    fill_in 'session[password]', with: '55555555'   
    click_button "Log in"
  end
  context 'ユーザーがログインした場合' do
    it 'タスク一覧画面が見れるようになる' do
      expect(page).to have_content '内容'
      expect(page).to have_content '名前'
    end
  end
  context 'ユーザー情報をクリックした場合' do
    it '自分の詳細画面(マイページ)に飛べる' do
      click_on "Profile"
      expect(page).to have_content 'メールアドレス'
      expect(page).to have_content 'あなたの名前'
    end
  end
  context '他人の詳細画面に飛んだ場合' do
    it 'タスク一覧画面に遷移' do
      visit user_path(id: @user2.id)
      expect(page).to have_content 'あなたのページではありません'
    end
  end
  context '管理画面に飛んだ場合' do
    it 'タスク一覧画面に遷移' do
      visit admin_users_path
      expect(page).to have_content 'タスク一覧'
    end
  end
  context 'ログアウトした場合' do
    it 'ログイン画面へ遷移' do
      click_on "Logout"
      # page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'ログアウトしました'
     
    end
  end
end
describe '管理画面のテスト' do
  before do
    @user2 = FactoryBot.create(:second_user)
    visit new_session_path
    fill_in 'session[email]', with: 'test_2@gmail.com'
    fill_in 'session[password]', with: '22222222'
    click_button "Log in"
  end
  context '管理ユーザーがログインした場合' do
    it '管理画面にアクセスできること' do
      visit admin_users_path
      expect(page).to have_content '管理者専用'
      
    end
  end
  context '管理ユーザーが新規ユーザー登録した場合' do
    it 'ユーザーを登録できる' do
      visit new_admin_user_path
      fill_in 'user[user_name]', with: 'テスト君'
      fill_in 'user[email]', with: 'test01@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button "Create my account"
      # visit admin_users_path
      expect(page).to have_content 'テスト君'
    end
  end
  context '詳管理ユーザーがユーザー細画面にアクセスした場合' do
    it '他人のユーザー情報をみれる' do
      user = FactoryBot.create(:user)
      visit admin_user_path(user.id)
      expect(page).to have_content '名前'
    end
  end
  context '管理ユーザーがユーザーを編集した場合' do
    it 'ユーザー情報が更新される' do
      user = FactoryBot.create(:user)
      visit edit_admin_user_path(user.id)
      fill_in 'user[email]', with: 'hoge@gmail.com'
      fill_in 'user[password]', with: 'hogehoge'
      fill_in 'user[password_confirmation]', with: 'hogehoge'
      click_button "Create my account"
      expect(page).to have_content 'hoge@gmail.com'
      
    end
  end
  context '管理ユーザーがユーザーを削除した場合' do
    it 'ユーザーが削除される' do
      @user2 = FactoryBot.create(:second_user)
      visit admin_users_path
      click_link "削除", match: :first
    page.driver.browser.switch_to.alert.accept
      # page.driver.browser.switch_to.alert.dismiss
      expect(page).to have_content '削除'
    end
  end
 end
end