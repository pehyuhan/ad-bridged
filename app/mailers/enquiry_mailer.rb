class EnquiryMailer < ApplicationMailer
    def enquiry(post)     
        mail(to: post.user.email, subject: 'Welcome to My Awesome Site')
    end
end
