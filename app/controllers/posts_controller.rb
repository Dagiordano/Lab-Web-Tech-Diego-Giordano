class PostsController < ApplicationController


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
