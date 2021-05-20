FactoryBot.define do
    factory :admin, class: "User" do
        sequence(:username) { |n| "admin#{n}@sheffield.ac.uk" }
        sequence(:email) { |n| "admin#{n}@sheffield.ac.uk" }
        admin { true }
        ou { 'COM' }
    end
end
  