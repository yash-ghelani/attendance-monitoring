# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [{"username" => 'aca18mms', "email" => 'mmsarpatwar1@sheffield.ac.uk', "admin" => true},
                {"username" => 'aca18yg', "email" => 'yghelani1@sheffield.ac.uk', "admin" => true},
                {"username" => 'aca18rf', "email" => 'rfaiz1@sheffield.ac.uk', "admin" => true},
                {"username" => 'aca18ag', "email" => 'agoody1@sheffield.ac.uk', "admin" => true},
                {"username" => 'acd19yc', "email" => 'ychen1@sheffield.ac.uk', "admin" => true},
                {"username" => 'mea17nh', "email" => 'nheath2@sheffield.ac.uk', "admin" => true}]

users.each do |user_details|
    user = User.find_or_initialize_by({"username" => user_details['username'], "email" => user_details["email"]})
    user.admin = user_details["admin"] ? true : false
    user.lecturer = user_details["lecturer"] ? true : false
    user.save!
end

TimetabledSession.first_or_create({"id"=>2, "session_code"=>"EFGH-5678", "session_title"=>"COM1008 - Javascript practical", "session_desc"=>"Anonymous functions and the arrow function", "department_code"=>"COM1008", "start_time"=>"2021-03-26T02:00:00.000Z", "end_time"=>"2021-03-26T03:00:00.000Z", "creator"=>1, "report_email"=>"", "created_at"=>"2021-03-22T16:34:58.823Z", "updated_at"=>"2021-03-22T16:34:58.823Z"})
TimetabledSession.first_or_create({"id"=>3, "session_code"=>"IJKL-9101", "session_title"=>"COM2008 - Java MySQL connector tutorial", "session_desc"=>"Using MySQL adaptor with jdbc driver", "department_code"=>"COM2008", "start_time"=>"2021-03-29T12:00:00.000Z", "end_time"=>"2021-03-29T13:00:00.000Z", "creator"=>1, "report_email"=>"", "created_at"=>"2021-03-22T16:37:26.712Z", "updated_at"=>"2021-03-22T16:37:26.712Z"})
TimetabledSession.first_or_create({"id"=>1, "session_code"=>"ABCD-1234", "session_title"=>"COM1001 - Practical", "session_desc"=>"Ruby tutorial", "department_code"=>"COM1001", "start_time"=>"2021-03-22T13:00:00.000Z", "end_time"=>"2021-03-22T14:00:00.000Z", "creator"=>1, "report_email"=>"", "created_at"=>"2021-03-22T16:33:43.635Z", "updated_at"=>"2021-03-22T16:37:51.490Z"})
