require 'rails_helper'

RSpec.describe Comment, type: :model do
	context "validation tests" do
		it "ensures body is present" do
			comment = build(:comment, body: nil)	
			expect(comment.valid?).to eq(false)
		end

		it "should be able to save comment" do
			comment = build(:comment)
			expect(comment.save) == true
		end
	end

	context "preferences" do
		it "comment have user id" do
			comment = build(:comment)
			expect(comment.user_id).to eq(1)
		end
		it "comment have post id" do
			comment = build(:comment)
			expect(comment.post_id).to eq(1)
		end
	end
end