FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    task_name {'test_title'}
    content { 'test_content' }
  end
  factory :second_task, class: Task do
    task_name {'test_title2'}
    content {'test_content2'}
  end
end
