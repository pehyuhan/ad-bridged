class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
   
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
      @posts = Post.filter(params.slice(:platform_type, :ad_type))
      @posts = @posts.order(created_at: :desc).paginate(page:params[:page], per_page: 6 )
  end
  
  def send_enquiry
    begin
      @post = Post.find(params[:id])
      EnquiryMailer.enquiry(@post).deliver_now
      flash[:notice] = "Email has been sent."
      
      @post.update_attribute(:number_of_enquiries, @post.number_of_enquiries + 1)
      
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:success] = "Problems sending mail"
    end
    
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