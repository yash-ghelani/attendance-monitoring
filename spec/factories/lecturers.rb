FactoryBot.define do
    factory :lecturer, class: "User" do
        sequence(:username) { |n| "lecturer#{n}@sheffield.ac.uk" }
        sequence(:email) { |n| "lecturer#{n}@sheffield.ac.uk" }
        lecturer { true }
        ou { 'COM' }
    end
end
  