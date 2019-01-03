# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    sign_in create(:user, email: "oleo@gmail.com")
    @post = create(:post)
  end
  context 'POST #create' do
    it 'saves the new comment in the database' do
      expect  do
        create(:comment)
      end.to change(Comment, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
  	before(:each) do
  		@comment = create(:comment)
  	end

  	it "deletes the comment" do
  		expect do
  			delete :destroy, params: {id: @comment.id, post_id: @post}
  		end.to change{@post.comments.count}.by(-1)
  		expect(response).to redirect_to post_path
  	end
  end
end
