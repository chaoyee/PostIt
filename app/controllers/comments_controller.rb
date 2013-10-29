class CommentsController < ApplicationController
  before_action :require_user

  # def index
  #   @comments = Comment.all
  # end

  # def new
  #   @comment = Comment.new
  # end

  def create    
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(com_params)  # equals to:   @comment = Comment.new(com_params)
                                               #              @comment.post = @post
    @comment.creator = current_user            # or @post.creator  
    if @comment.save
      flash[:notice] = "Your comment was created!"
      redirect_to post_path(@post)
    else
      render 'posts/show' 
    end
  end

  def edit
    
  end

  def show
    
  end

  def update
    @comment.update(params[:id])
  end

  def vote
    @comment = Comment.find(params[:id])
    vote = Vote.new(voteable: @comment, creator: current_user, vote: params[:vote]) # Vote.create   
    respond_to do |format|
      if vote.save
        # flash[:notice] = 'Your vote was counted!'
        format.html { redirect_to :back, notice: 'Your vote was counted!' }  # if it is a normal html response.
        format.js   { @msg = 'Your vote was counted!'}                       # if it is an ajax response.                               
      else
        # flash[:error] = vote.errors.full_messages[0]
        format.html { redirect_to :back, alert: vote.errors.full_messages.join('') }  # if it is a normal html response.
        format.js   { @msg = vote.errors.full_messages.join('')}                                                                # if it is an ajax response.      
      end
    end                  

    # if vote.save
    #   flash[:notice] = 'Your vote was counted!'  
    # else
    #   flash[:error] = vote.errors.full_messages[0]
    # end
    # redirect_to :back           
  end


  # def destroy
  #   @comment.destroy
  # end

  private

  def com_params
    params.require(:comment).permit(:body)
    # params.require(:post_id)
  end
end  