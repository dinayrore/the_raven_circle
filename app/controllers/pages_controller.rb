class PagesController < ApplicationController
  def hark
    @posts = Post.all.order('created_at DESC')
  end
end
