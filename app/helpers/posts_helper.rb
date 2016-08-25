module PostsHelper
  
  def tag_links(tags)
    tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ") 
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size-1)
      yield(tag, classes[index.round])
    end
  end
  
  def platform_type
    I18n.t(:platform_type).map { |key, value| [ value, key ] }
  end
  
  #def pltform_views(value)
    #I18n.t(:contrat_strings)[value]
  #end
  
  def platform_type_to_s(platform_type)
    if platform_type == "1"
      I18n.t("website", default: "Website")
    elsif platform_type == "2"
      I18n.t("mobile", default: "Mobile")
    elsif platform_type == "3"
      I18n.t("tv", default: "TV")
    elsif platform_type == "4"
      I18n.t("prints", default: "Prints")
    else
      I18n.t("others", default: "Others")
    end
  end

  def ad_type
    I18n.t(:ad_type).map { |key, value| [ value, key ] } 
  end
  
  def ad_type_to_s(ad_type)
    if ad_type == "1"
      I18n.t("banners", default: "Banners")
    elsif ad_type == "2"
      I18n.t("pop-ups", default: "Pop-Ups")
    elsif ad_type == "3"
      I18n.t("articles", default: "Articles")
    elsif ad_type == "4"
      I18n.t("videos", default: "Videos")
    else
      I18n.t("others", default: "Others")
    end
  end
  
end
