class PostsController < ApplicationController
	before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

	def index
		tag = Tag.find_by(name: params[:name])
		@posts = tag.posts
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		if current_user.try(:admin?)
			@post = Post.new(post_params)
			@post.user_id = current_user.id
			if @post.save
				flash[:success] = "We are as one my sister. Your post has been saved."
				redirect_to @post
			else
				flash[:danger] = "Existance is mysterious. Your post was not saved."
				render 'new'
			end
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		if current_user.try(:admin?)
			@post = Post.find(params[:id])
			@post.user_id = current_user.id
			if @post.update(params[:post].permit(:title, :body))
				flash[:success] = "Walk In Harmony. Your post has been updated."
				redirect_to @post
			else
				flash[:danger] = "There is disquiet within you. Your post was not updated."
				render 'edit'
			end
		end
	end

	def destroy
		if current_user.try(:admin?)
			@post = Post.find(params[:id])
			@post.destroy
			flash[:success] = "Walk In Harmony. Post destroyed."
			redirect_to hark_path
		else
			flash[:danger] = "Darkness falls. You do not have permission to perform this function."
			redirect_to hark_path
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :body)
	end

	def admin_user
		redirect_to(root_url) unless current_user.try(:admin?)
	end
end
