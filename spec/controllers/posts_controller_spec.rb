# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context 'GET #index' do
    it 'render the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  context 'GET #show' do
    it 'assigns the requested post to @post' do
      post = create(:post)
      get :show, params: { id: post }
      expect(assigns(:post)).to eq post
    end

    it 'renders the :show template' do
      post = create(:post)
      get :show, params: { id: post }
      expect(assigns(:post)).to render_template :show
    end
  end

  context 'GET #new' do
    before(:each) do
      sign_in create(:user)
    end
    it 'assigns a new Post to @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  context 'GET #edit' do
    it 'assigns the requested post to @post' do
      post = create(:post)
      get :edit, params: { id: post }
      expect(assigns(:post)) == post
    end

    it 'renders the :edit template' do
      post = create(:post)
      get :edit, params: { id: post }
      expect(response).to redirect_to '/posts'
    end
  end

  context 'POST #create' do
    it 'saves the new post in the database' do
      expect  do
        create(:post)
      end.to change(Post, :count).by(1)
    end

    it 'redirects to post#show' do
      post = create(:post)
      get :show, params: { id: post }
      expect(assigns(:post)).to render_template :show
    end
  end
end
