class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post
    before_action :set_comment, only: [:show, :edit,:update ,:destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]


    def index
        @comments = Comment.all
    end


    def show
    
        @comment = Comment.find(params[:id])

    
    end


    def new
        @comment = @post.comments.build
        
    end

    def create
        
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
        
    end




    def update
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
          flash[:notice] = "The comment was updated successfully"
          redirect_to post_path(@post)
        else
          flash[:alert] = "There was an error updating the comment"
          render :edit, status: :unprocessable_entity
        end
      
      
  end

    
    def destroy
        if @comment.destroy
          flash[:notice] = "The comment was deleted successfully"
          redirect_to post_path(@post), status: :see_other
        else
          flash[:alert] = "Error deleting comment"
          redirect_to post_path(@post)
        end
      end




    
    private


    
    
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

    def authorize_user!
      @comment = Comment.find(params[:id]) 
      unless current_user == @comment.user
        redirect_to posts_path, alert: 'You are not authorized to perform this action.'
      end
    end


    def comment_params
        params.require(:comment).permit(:body, :user_id)
    end

end
    
