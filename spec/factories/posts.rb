# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title 'Test title'
    summary 'Test summary'
    body 'Test body'
    image 'Test image'
    user
    user_id 1
    id 1
  end
end
