require_relative 'utils/initialize_markdown_renderer.rb'
class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_markdown_renderer
  def index
    me = current_user.profile
    @friends = me.friends
    @strangers = Profile.where.not(id: @friends.pluck(:id)).where.not(id: me.id)
    # @posts = Post.all
    @posts = Post.where(profile: @friends.pluck(:id)).or(Post.where(profile: me.id)).order(created_at: :desc)
  end

  def add_friend
    me = current_user.profile
    friend = Profile.find(params[:id])

    unless me.friends.include?(friend)
      me.friends << friend
    end
    redirect_back(fallback_location:"/")
  end

  def remove_friend
    me = current_user.profile
    friend = Profile.find(params[:id])

    if me.friends.include?(friend)
      me.friends.delete(friend)
    end
    redirect_back(fallback_location:"/")
  end
end
