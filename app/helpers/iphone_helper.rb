module IphoneHelper
  
  def topic_title(topic)
    s = []
    s << image_tag('clearbits/lock.gif', :class => "icon darkgrey") if topic.locked?
    s << "<span class='sticky'>STICKY</span>" if topic.sticky?
    s << "#{topic.title} (#{topic.posts_count})"
    s.join ' '
  end

  def application_title
    'Beast'[:beast_title]
  end

  def iui_menu_start(title)
    "<ul title=\"#{title}\">" unless params[:page]
  end

  def iui_menu_end
    "</ul>" unless params[:page]
  end

  def iui_menu_next(col, label = "Next #{col.per_page}")
    unless col.current_page == col.page_count or col.page_count == 0
      "<li>#{link_to(label, { :page => col.current_page.next }.merge(params.reject{|k,v| k=="page"}), :target => '_replace')}</li>"
    end
  end

end
