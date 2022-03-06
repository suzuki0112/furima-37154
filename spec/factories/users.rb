FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    first_name            { person.first.kanji }
    family_name           { person.last.kanji }
    read_first            { person.first.katakana }
    read_family           { person.last.katakana }
    birth                 { Faker::Date.birthday }
  end
end
