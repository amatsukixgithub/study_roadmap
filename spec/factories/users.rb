FactoryBot.define do
  # 正常なユーザー
  factory :user do
    name             { 'default_user' }
    # buildごとにnが+1されるため、ユニークなemailを作成できる
    sequence(:email) { |n| "user#{n}@example.com" }
    password         { 'password' }

    # 管理ユーザー
    trait :admin_authority do
      admin { true }
    end

    # 一般ユーザー
    trait :general_authority do
      admin { false }
    end
  end
end
