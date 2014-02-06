class Git

  def initialize path
    @path = path
    tags
  end

  def tags
    @tags ||= (`git tag -l`).split
  end

  def current_tag_commit
    return "" unless @tags.include? 'current'
    current_tag_commit ||= (`git show current | head -n 1`).split[1]
  end

  def create_tag tag
    `git tag #{tag}`
  end

  def delete_tag tag
    `git tag -d #{tag}`
  end

  def refresh_tag tag
    delete_tag tag
    create_tag tag
  end

  def make_tag_alias tags
    `git tag #{tags[:previous]} #{tags[:current]}`
  end

  def get_origin
    @origin = `git config remote.origin.url`
  end

  def get_gh_token
    @gh_token = `git config --global --get github.token`
  end

end
