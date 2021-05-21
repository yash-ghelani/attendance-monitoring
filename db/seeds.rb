# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [{"username" => 'ac1jww', "email" => 'jacob.walker@sheffield.ac.uk', "admin" => true},
                {"username" => 'aca18mms', "email" => 'mmsarpatwar1@sheffield.ac.uk', "admin" => true},
                {"username" => 'aca18yg', "email" => 'yghelani1@sheffield.ac.uk', "admin" => true},
                {"username" => 'aca18rf', "email" => 'rfaiz1@sheffield.ac.uk', "admin" => true},
                {"username" => 'acc18ag', "email" => 'agoody1@sheffield.ac.uk', "admin" => true},
                {"username" => 'acd19yc', "email" => 'ychen1@sheffield.ac.uk', "admin" => true},
                {"username" => 'mea17nh', "email" => 'nheath2@sheffield.ac.uk', "admin" => true}]

users.each do |user_details|
    user = User.find_or_initialize_by({"username" => user_details['username'], "email" => user_details["email"]})
    user.admin = user_details["admin"] ? true : false
    user.lecturer = user_details["lecturer"] ? true : false
    user.save
end