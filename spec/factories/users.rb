FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"0000000"}
    password_confirmation {"0000000"}
    first_name            {"あああ"}
    first_name_furigana   {"アアア"}
    last_name             {"いいい"}
    last_name_furigana    {"イイイ"}
    date_of_birth         {"19851115"}
  end
end
