require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    before do
      label = FactoryBot.create(:label)
      user = FactoryBot.create(:user)
      FactoryBot.create(:task, user: user)
      visit new_session_path
    fill_in 'session[email]', with: 'test@gmail.com'
    fill_in 'session[password]', with: '55555555'
    click_button "Log in"
    visit new_task_path
     fill_in 'task[task_name]', with: 'test_title'
     fill_in 'task[content]', with: 'test_content'
     fill_in 'task[limit]', with: "002021-12-10"
     check 'test'
     click_button 'Create my account'
  end

  context 'ラベル付きタスクを作成' do			
    it 'タスクにラベルが紐付いていること' do
      visit tasks_path
      expect(page).to have_content 'test1'
    end
  end
  context 'タスク詳細画面' do
    it 'タスク詳細画面に選択したラベルが表示されていること' do
      visit new_task_path
     fill_in 'task[task_name]', with: 'test_title'
     fill_in 'task[content]', with: 'test_content'
     fill_in 'task[limit]', with: "002021-12-10"
     check 'test'
     click_button 'Create my account'
      visit tasks_path
      expect(page).to have_content 'test1'
    end
  end
  context 'タスク新規作成画面' do
    it 'タスク新規作成画面にラベルの入力欄があること' do
      visit new_task_path
      expect(page).to have_content 'test1'
    end
  end
  end
end
