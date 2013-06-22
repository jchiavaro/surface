FactoryGirl.define do
  factory :contacts_list do |f|
    f.user  {FactoryGirl.create(:user)}
    f.name "Friends "
    f.description "some description"
  end

  factory :user do |u|
    u.first_name "john"
    u.last_name "smith"
    u.email "js@domain.com"
    u.password "secret"
    u.password_confirmation "secret"
    u.gender "male"
    u.birthday "1984-11-11"
    u.active true
  end

  factory :inactive_user, class: User do |u|
    u.first_name "john"
    u.last_name "smith"
    u.email "dr@domain.com"
    u.password "secret"
    u.password_confirmation "secret"
    u.gender "male"
    u.birthday "1984-11-11"
    u.active false
  end

end
