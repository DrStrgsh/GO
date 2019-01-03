FactoryGirl.define do
	factory :post do
		title 	"Test title"
		summary "Test summary"
		body		"Test body"
		image		"Test image"
		user_id 1
	end
end