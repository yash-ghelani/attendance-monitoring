FactoryBot.define do
    factory :lecturer, class: "User" do
        sequence(:username) { |n| "lecturer#{n}@sheffield.ac.uk" }
        sequence(:email) { |n| "lecturer#{n}@sheffield.ac.uk" }
        lecturer { true }
        admin { false }
        ou { 'COM' }

        trait :with_session do
            session
        end
    end
end
  