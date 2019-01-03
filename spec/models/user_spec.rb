require 'rails_helper'

RSpec.describe User, type: :model do

	context "validation tests" do

		it "has a valid factory" do
			expect(build(:user)).to be_valid
		end

		it "is invalid without password" do
			user = build(:user, password: nil)	
			expect(user.valid?).to eq(false)
		end

		it "is invalid without email" do
			user = build(:user, email: nil)
			expect(user.valid?).to eq(false)
		end

		it "should be able to save user" do
			user = build(:user)
			expect(user.save) == true
		end

		it "is invalid with a duplacate email address" do
			create(:user, email: 'sasha@example.com')
			user = build(:user, email: 'sasha@example.com')
			expect(user.valid?).to eq(false)
		end
	end

	context "test for instance methods" do
		it "returns a username" do
			user = build(:user)
			expect(user.username).to eq "Oleh"
		end
	end
end