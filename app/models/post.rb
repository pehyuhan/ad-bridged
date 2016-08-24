class Post < ActiveRecord::Base
    
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates_presence_of :company_name, :ad_type, :country_code, :image_url
    validates :user_id, presence: true
    validates :descriptions, presence: true, length: { maximum: 260 }

    has_many :taggings
    has_many :tags, through: :taggings

    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end
        
    def all_tags
        self.tags.map(&:name).join(", ")
    end
        
    def self.tagged_with(names)
        joins(:tags).where(tags: { name: names })
    end

end