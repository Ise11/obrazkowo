class CommentsController < ApplicationController
	def create
		@pin = Pin.find(params[:pin_id])
		@comment = @pin.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save

		if @comment.save 
			redirect_to pin_path(@pin)
		else
			render 'new'
		end
	end	

	def edit
		@pin = Pin.find(params[:pin_id])
		@comment = @pin.comments.find(params[:id])
	end

	def update
		@pin = Pin.find(params[:pin_id])
		@comment = @pin.comments.find(params[:id])

		if @comment.update(params[:comment].permit(:comment))
			redirect_to pin_path(@pin)
		else
			render 'edit'
		end
	end

	def destroy
		@pin = Pin.find(params[:pin_id])
		@comment = @pin.comments.find(params[:id])
		@comment.destroy
		redirect_to pin_path(@pin)
	end
end
