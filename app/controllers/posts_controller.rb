# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy like unlike]
  impressionist actions: [:show], unique: %i[impressionable_type impressionable_id session_hash]
  def index
    @posts = Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    @post = Post.new
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order('created_at DESC')
  end

  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  def edit
    if user_signed_in? && (current_user || current_user.admin?)
      @post = Post.find(params[:id])
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  def create
    if user_signed_in?
      @post = current_user.posts.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
          format.js
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
          format.js
        end
      end
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  def update
    if (@post.user == current_user || current_user.admin?) && user_signed_in?
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to posts_path, notice: 'You do not have roots'
    end
  end

  def destroy
    if (@post.user == current_user || current_user.admin?) && user_signed_in?
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to posts_path, notice: 'You do not have roots'
    end
  end

  def like
    @post.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: post_path }
      format.js { render layout: false }
    end
  end

  def unlike
    @post.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: post_path }
      format.js { render layout: false }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title,
      :summary, 
      :body, 
      :image, 
      :user_id
    )
  end
end
