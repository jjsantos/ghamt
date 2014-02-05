class Git

  def initialize path
    @path = path
  end

  def tags
    @tags ||= (`git tag -l`).split
  end

  def current_tag_commit
    return "" unless @tags.include? 'current'
    current_tag_commit ||= (`git show current | head -n 1`).split[1]
  end

  def create_current_tag
    `git tag current`
  end

  def rotate_tags
    # TO-DO: rotate between 'current' and 'previous' tags
    puts 'rotated tags'
  end

  def get_origin
    @origin = `git config remote.origin.url`
  end

  def get_gh_token
    @gh_token = `git config --global --get github.token`
  end

end
