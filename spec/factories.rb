FactoryGirl.define do
	factory :user do
		name     "Linus Young"
		email    "whyisyoung@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end