class CommentsController < ApplicationController
	def create
		if logged_in?
			@comment = Comment.new(comment_params)
			@comment.user_id = current_user.id
			@comment.post = Post.find params[:post_id]
				if @comment.save
					flash[:success] = "Your comment has been saved. Thank you for contributing to the conversation."
					redirect_to :back
				end
		else
			flash[:danger] = "Existance is mysterious. You must have an account to post comments."
			redirect_to :back
		end
	end

	def destroy
		if current_user.try(:admin?)
			@comment = Comment.find params[:id]
			@comment.destroy
			flash[:success] = "Walk In Harmony. Comment destroyed."
			redirect_to :back
		else
			flash[:danger] = "Darkness falls. You do not have permission to perform this function."
			redirect_to :back
		end
	end

	private

  def comment_params
		params.require(:comment).permit(:body)
  end
end


# currently deleting a comment deletes the post...? check model relations on Code Karma to verify here... you're getting there keep it up!
