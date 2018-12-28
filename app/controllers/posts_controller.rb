class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order(params[:sort])
    @post = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments.order("created_at DESC")
  end

  # GET /posts/new
  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  # GET /posts/1/edit
  def edit
    if user_signed_in? && (current_user || current_user.admin?)
      @post = Post.find(params[:id])
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  # POST /posts
  # POST /posts.json
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :summary, :body, :user_id)
    end
end
