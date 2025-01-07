require_relative "utils/initialize_markdown_renderer.rb"

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :initialize_markdown_renderer

  
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(title: post_params[:title], profile: current_user.profile, body: post_params[:body], stats: { likes: [], dislikes: [] }.to_json)
    
    

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # LIKE /posts/1/like
  def like
    post = Post.find(params[:id])
    stats = JSON.parse(post.stats)
    if stats["likes"].include?(current_user.profile.id)
      stats["likes"].delete(current_user.profile.id)
    else
      stats["likes"] << current_user.profile.id unless stats["likes"].include?(current_user.profile.id)
    end
    post.update(stats: stats.to_json)
    redirect_to post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :profile_id, :body, :stats)
    end

end
