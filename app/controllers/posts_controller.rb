class PostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
    
  end

  def index
    @posts= Post.all
  end

  def show
    @post = Post.includes(:user, :tags).find(params[:id])

  end

 


  def create
    @post = Post.new(post_params)

    if params[:post][:comments_attributes] && params[:post][:comments_attributes]["0"][:body].blank?
      @post.comments = []  
    end

    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end



  def destroy
     
    @post = Post.find(params[:id])
    if @post.destroy
        flash[:message] = "The post was deleted successfully"
        redirect_to root_path, status: :see_other
    else
        flash[:message] = "Error deleting comment"
        redirect_to root_path
        end
   end




  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
    
  end


  





  private 
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :published_at, :answers_count, :likes_count, comments_attributes: [:body,:user_id])
  end

  

end
