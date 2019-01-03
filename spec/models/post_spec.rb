require 'rails_helper'

RSpec.describe Post, type: :model do
	context "validation tests" do
		it "ensures title is present" do
			post = build(:post, title: nil)
			expect(post.valid?).to eq(false)
		end

		it "ensures summary is present" do
			post = build(:post, summary: nil)
			expect(post.valid?).to eq(false)
		end

		it "ensures body is present" do
			post = build(:post, body: nil)
			expect(post.valid?).to eq(false)
		end

		it "should be able to save post" do
			post = build(:post)
			expect(post.save) == true
		end

		context "preferences" do
			it "post have user id" do
				post = build(:post)
				expect(post.user_id).to eq(1)
			end
		end
	end
end