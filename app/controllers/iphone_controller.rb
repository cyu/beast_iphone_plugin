class IphoneController < ApplicationController

  prepend_view_path File.join(Beast::Plugins::Iphone::plugin_path, 'app', 'views')
  
  @@post_query_options = {
      :per_page => 10,
      :select => "#{Post.table_name}.*, #{Topic.table_name}.title as topic_title",
      :joins => "inner join #{Topic.table_name} on #{Post.table_name}.topic_id = #{Topic.table_name}.id",
      :order => "#{Post.table_name}.created_at desc"
  }
  
  layout false

  def index
    @forums = Forum.find(:all, :order => "position")
  end
  
  def forum
    @forum = Forum.find(params[:id])
    @topics = Topic.paginate_by_forum_id @forum.id, :per_page => 10, :page => params[:page],
        :include => :replied_by_user, :order => 'sticky desc, replied_at desc'
  end

  def topic
    @posts = Post.paginate(@@post_query_options.merge(:conditions => Post.send(:sanitize_sql, ["#{Post.table_name}.topic_id = ?", params[:id]]),
        :page => params[:page], :count => {:select => "#{Post.table_name}.id"}))
    @users = User.find(:all, :select => 'distinct *', :conditions => ['id in (?)', @posts.collect(&:user_id).uniq]).index_by(&:id)
  end

end
