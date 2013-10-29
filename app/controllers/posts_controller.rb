class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :vote]
  # 1. set up something
  # 2. redirect away from action 

  def index
    @posts = Post.all.sort_by {|x| x.total_votes}.reverse
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Your post was saved!"
      redirect_to posts_path
    else
      render :new   # render the new template
    end
  end

  def edit
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml  { render xml: @post }
    end  
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'This post was updated!'
      redirect_to post_path(@post)    #, notice: 'This post was updated!'
    else
      render :edit
    end  
  end


  def vote
    vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])   
    respond_to do |format|
      format.html do           # if it is a normal html response.
        if vote.valid?
          flash[:notice] = 'Your vote was counted!'                                                                                  
        else
          flash[:error] = vote.errors.full_messages.join('')       
        end   
        redirect_to :back   
      end   
      format.js do             # if it is an ajax response. 
        if vote.valid?
          @msg = 'Your vote was counted!'   
        else
          @msg = vote.errors.full_messages.join('')
        end  
      end 
    end                           
  end

  # def destroy
  #   @post.destroy
  # end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids:[])
  end

  def set_post
    # @post = Post.find(params[:id])         # using post.id
    @post = Post.find_by(slug: params[:id])  # using slug
  end
end
