# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.create!(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'administrator', password_confirmation: 'administrator',birthday: '2011-09-19
  ', gender: 'male', active: true);

@user.contacts_list.create!(name: "Friends", description: "desc1");
@user.contacts_list.create!(name: "Family", description: "desc2");
@user.contacts_list.create!(name: "Work contacts", description: "desc3");


@other_user = User.create!(first_name: 'admin2', last_name: 'admin2', email: 'admin2@admin.com', password: 'administrator', password_confirmation: 'administrator',birthday: '2011-09-19
  ', gender: 'male', active: true);

@other_user.contacts_list.create!(name: "List 1", description: "desc1");
@other_user.contacts_list.create!(name: "List 2", description: "desc2");
@other_user.contacts_list.create!(name: "List 3", description: "desc3");