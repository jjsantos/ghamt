require 'octokit'

class Manager

  def greet
    puts "starting"
  end

  def quit
    puts "finished!"
  end

  def show_params
    puts "command       : #{@command}"
    puts "path          : #{@path}"
    puts "latest_commit : #{@latest_commit}"
    puts "args          : #{@args}"
    puts "username      : #{@username}"
  end

  def latest_commit path
    `git log -n 1 --pretty=oneline`.split(" ")[0]
  end

  def tags
    tags = `git tag -l`
    tags.split
  end

  def commit
    @args.each_cons(2).map {|param, value| value if param == '--commit' }.compact[0]
  end

  def current_tag_commit
    return "" unless @tags.include? 'current'

    msg = `git show current | head -n 1`
    msg.split[1]
  end

  def initialize params
    @path ||= `pwd`
    @command ||= validate_command params[0]
    @latest_commit ||= latest_commit @path
    @args ||= params[1..-1]
    @tags = tags
    @commit = commit
    @current_tag_commit = current_tag_commit
  end

  def validate_command command
    case command
      when "--help", "upload", "manage", "download", "install", "reset", "test"
        command
      else
        nil
    end
  end

  def check_values
    begin
      puts "No known command given to ghamt: #{@command}. Run 'ghamt --help'"
      exit
    end unless @command
  end

  def help
    puts "Run: 'ghamt <command>'"
    puts "Commands are: upload, manage, download, install, reset, test or --help"
  end

  def execute
    case @command
      when "--help"
        help
      when "upload"
        upload
      when "manage", "download", "install", "reset", "test"
        true
    end
  end

  def create_current_tag
    current = `git tag current`
  end

  def add_assets
    puts 'adding assets'
  end

  def manage_tags
    if @tags.include? 'current'
      rotate_tags unless @current_tag_commit == @commit
    else
      puts "no 'current' tag exists, creating..."
      create_current_tag
    end
  end

  def rotate_tags
    # TO-DO: rotate between 'current' and 'previous' tags
    puts 'rotated tags'
  end

  def upload
    manage_tags
    set_auth
    connect
    add_assets
  end

  def connect
    raise "no token authentication provided" unless @gh_token

    @client = Octokit::Client.new :access_token => @gh_token
    @username = @client.login
  end

  def get_origin
    @origin = `git config remote.origin.url`
  end

  def set_auth
    get_gh_token
  end

  def get_gh_token
    @gh_token = `git config --global --get github.token`
  end

end
