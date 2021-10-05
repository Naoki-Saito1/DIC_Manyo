require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task[task_name]', with: 'ほげ'
      fill_in 'task[content]', with: 'hoge'
      click_button 'Create my account'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_name: 'hogehoge')
        visit tasks_path
        expect(page).to have_content 'hogehoge'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'test_title2'
        expect(task_list[1]).to have_content 'test_title'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
       visit new_task_path
     fill_in 'task[task_name]', with: 'ruby'
     fill_in 'task[content]', with: 'rails'
     click_button 'Create my account'
       expect(page).to have_content 'ruby'
       expect(page).to have_content 'rails'
      end
    end
 end
end