FactoryBot.define do
    factory :student, class: "User" do
        sequence(:username) { |n| "student#{n}@sheffield.ac.uk" }
        sequence(:email) { |n| "student#{n}@sheffield.ac.uk" }
      
    end
end
  