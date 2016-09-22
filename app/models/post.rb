class Post < ActiveRecord::Base
    
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates_presence_of :ad_type, :country_code, :image_url, :all_tags, :platform_type
    validates :company_name, presence: true, length: { maximum: 30 }
    validates :user_id, presence: true
    validates :descriptions, presence: true, length: { maximum: 260 }

    has_many :taggings
    has_many :tags, through: :taggings
    
    include Filterable
    scope :platform_type, -> (platform_type) { where platform_type: platform_type }
    scope :ad_type, -> (ad_type) { where ad_type: ad_type }

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