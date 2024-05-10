class CommentsController < ApplicationController
   



    def index
        @comments = Comment.all
    end


    def show
    
        @comment = Comment.find(params[:id])
    
    end


    def new
        
        @comment = @post.comments.build
        respond_to do |format| 
            format.html 
            format.js
            end
    end

    def create
       
        @comment = @post.comments.create(comment_params)

        flash[:message] = "The comment was created successfully"
        redirect_to post_path(@post)
    end


    def edit
        
        @comment = @post.comments.find(params[:id])
    end




    def update
        
        @comment = Comment.find(params[:id])
    
        if @comment.update(comment_params)
            flash[:message] = "The comment was updated successfully"
            redirect_to post_path(@comment.post)
        else
          render :edit, status: :unprocessable_entity
        end
        
    end


    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            flash[:message] = "The comment was deleted successfully"
            redirect_to root_path, status: :see_other
        else
            flash[:message] = "Error deliting comment"
            redirect_to root_path
            end
    end



    
    private

    def set_post
        @post = Post.find(params[:post_id])
    end


    def comment_params
        params.require(:comment).permit(:body, :user_id)
    end

end
    
