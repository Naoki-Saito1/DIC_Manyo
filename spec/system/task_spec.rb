require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    user = FactoryBot.create(:user)
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user)
    visit new_session_path
    # fill_in :user_name, with: 'test'
    fill_in :Email, with: 'test@gmail.com'
    fill_in :Password, with: '55555555'
    click_button "Log in"

    
    
    # let!(:task) {FactoryBot.create(:second_task,user: second_user )}
    # visit new_task_path
    #    fill_in 'task[task_name]', with: 'test_title'
    #    fill_in 'task[content]', with: 'test_content'
    #   #  fill_in 'task[status]', with: '完了'
    #    fill_in 'task[limit]', with: "2021-12-10"
    #   #  fill_in 'task[priority]', with: '高'
    #    click_button 'Create my account'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
    # FactoryBot.create(:second_task, user: user)
      visit tasks_path
      expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2021'
        expect(page).to have_content '完了'
        expect(page).to have_content '高'
      end
    end
  end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path

        fill_in 'task[task_name]',with: 'test'
        click_on 'Search'
        expect(page).to have_content 'test'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '着手中',from: 'task[status]'
        click_on'Search'
        expect(page).to have_content'着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task[task_name]',with: 'test'
        select '完了',from: 'task[status]'
        click_on'Search'
        expect(page).to have_content'test'
        expect(page).to have_content'完了'
      end
    end
    context '終了期限でソートする' do
      it '終了期限が降順に表示される' do
        visit tasks_path
        click_link '終了期限でソートする'
        expect(page).to have_content "2025-12-20"
      end
    end
    context '優先順位でソートする' do
      it '優先順位が高い順に表示される' do
        visit tasks_path
        click_link '優先順位でソートする'
        task_list = all('.task_list')
        expect(page).to have_content '高'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
       visit tasks_path
       task_list = all('.task_list')
        expect(task_list[0]).to have_content 'test'
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