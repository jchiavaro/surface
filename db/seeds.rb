# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'administrator', password_confirmation: 'administrator',birthday: '2011-09-19
  ', gender: 'male', active: true);

ContactsList.create!(name: "Friends", description: "desc1");
ContactsList.create!(name: "Family", description: "desc2");
ContactsList.create!(name: "Work contacts", description: "desc3");
