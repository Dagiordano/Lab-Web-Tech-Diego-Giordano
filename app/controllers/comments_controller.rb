class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]



    def index
        @comments = Comment.all
    end


    def show
    
        @comment = Comment.find(params[:id])
    
    end


    def new
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build
        
    end

    def create
        @post = Post.find(params[:post_id])
        
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user


        if @comment.save
            flash[:notice] = "The comment was created successfully"
            redirect_to post_path(@post)
          else
            flash[:alert] = "There was an error creating the comment"
            render :new, status: :unprocessable_entity
          end
    end


    def edit
        @post = Post.find(params[:post_id])
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
         flash[:message] = "Error deleting comment"
         redirect_to root_path
         end
    end




    
    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def authorize_user!
        @post = Post.find(params[:id])
        unless current_user == @post.user
          redirect_to posts_path, alert: 'You are not authorized to perform this action.'
        end
    end


    def comment_params
        params.require(:comment).permit(:body, :user_id)
    end

end
    
