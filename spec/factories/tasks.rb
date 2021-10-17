FactoryBot.define do
  factory :task do
    task_name {'test_title'}
    content { 'test_content' }
    limit { "002021-12-10" }
    status {'完了'}
    priority {'高'}

    # after(:build) do |label|
    #   label = create(:label)
    #   task.labellings << build(:labelling,task: task, label: label)
    # end
  end
  factory :second_task, class: Task do
    task_name {'test_title2'}
    content {'test_content2'}
    limit { "002025-12-20" }
    status {'完了'}
    priority {'高'}
  end
  factory :third_task, class: Task do
    task_name {'test_title3'}
    content {'test_content3'}
    limit { "2021-10-30" }
    status {'完了'}
    priority {'高'}
  end  
end
