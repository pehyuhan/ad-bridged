class PostsController < ApplicationController
   
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end
    
    def new
        @post = Post.new
    end
    
    def create
      @post = Post.new(post_params)
        if @post.save
          redirect_to @post, notice: 'You have successfully posted!'
        else
          render :new
        end
    end
    
      def show
        @post = Post.find(params[:id])
      end
    
      def destroy
        @post = Post.find(params[:id])
        @post.destroy
  
        redirect_to posts_path
      end
      
    private
      def post_params
        params.require(:post).permit(:company_name, :ad_type, :country_code, :number_of_enquiries, :all_tags, :image_url)
      end
        
end