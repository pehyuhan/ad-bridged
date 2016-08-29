class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
   
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
      @posts = @posts.order(created_at: :desc).paginate(page:params[:page], per_page: 6 )
  end
  
  def send_enquiry
    @post = Post.find(params[:id])
    EnquiryMailer.enquiry(@post).deliver_now
    
    redirect_to posts_path
  end

    def new
        @post = Post.new
    end
    
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = "Post created!"
        redirect_to @post
      else
        render :new #'static_pages/home'
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
          params.require(:post).permit(:company_name, :ad_type, :country_code, :number_of_enquiries, :all_tags, :image_url, :descriptions, :platform_type)
        end

        def signed_in_user
          redirect_to signin_url, notice: "Please sign in." unless signed_in?
        end
  
end