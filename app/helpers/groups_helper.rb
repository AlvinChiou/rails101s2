module GroupsHelper
  # 這個Helper會導致標題前綴被加入<p>
  def render_group_title(group)
    truncate(simple_format(group.title), length:15)
  end
end
