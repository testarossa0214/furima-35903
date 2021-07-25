FactoryBot.define do
  factory :user do
    nickname {"tarou"}
    email {Faker::Internet.email}
    password = Faker::Internet.password
    password {password}
    password_confirmation {password}
    first_name {"太郎"}
    last_name {"山田"}
    first_name_zen_kana {"タロウ"}
    last_name_zen_kana {"ヤマダ"}
    birth_day {"2000-01-01"}
  end
end