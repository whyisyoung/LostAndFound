FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password 'foobar'
		password_confirmation 'foobar'

		factory :admin do
			admin true
		end
	end

	factory :category do
		name 'electronics'
	end

	factory :lost_item do
		lost_time 	DateTime.now
		detail 		'A white cup'
		place 		'Library'
		status 		'unclaimed'
		finder 		'Lin'
		phone 		'18817551234'
		category_id 1
		user
	end
end