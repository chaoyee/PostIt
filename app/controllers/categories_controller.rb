class CategoriesController < ApplicationController
  before_action :require_user
  before_action :require_admin
  
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(cat_params)  
    if @category.save
      flash[:notice] = "Your category was saved!"
      redirect_to posts_path
    else
      render :new   # render the new template
    end
  end  

  # def edit
  #   @category = Category.find(params[:id]) 
  # end  
  
  def show
    @category = Category.find_by(slug: params[:id])
  end  
  
  # def update
  #   @category = Post.find(params[:id])
  #   if @post.update(cat_params)
  #     flash[:notice] = 'This post was updated!'
  #     redirect_to category_path(@category)    #, notice = 'This category was updated!'
  #   else
  #     render :edit
  #   end  
  # end  
  
  private

  def cat_params
    params.require(:category).permit(:name)
  end

end 