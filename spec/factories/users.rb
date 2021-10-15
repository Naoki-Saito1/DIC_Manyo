FactoryBot.define do
  factory :user do
    user_name {"test"}
    email {"test@gmail.com"}
    password {"55555555"}
    password_confirmation {"55555555"}
    admin {false}
  end
  factory :second_user, class: User do
    user_name {"test_2"}
    email {"test_2@gmail.com"}
    password {"22222222"}
    password_confirmation {"22222222"}
    admin {true}
  end
end
