class PostsController < ApplicationController
	before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		if current_user == 'raven'
			@post = Post.new(post_params)
			if @post.save
				redirect_to @post
			else
				render 'new'
			end
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end

	def admin_user
		redirect_to(root_url) unless current_user.try(:admin?)
	end
end
