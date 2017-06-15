module PostsHelper
  def render_with_hashtags(body)
    body.gsub(/#\w+/){ |name| link_to name, "/harks/#{name.delete('#')}" }.html_safe
  end
end
