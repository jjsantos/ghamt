require 'octokit'
require 'git'

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
    puts "args          : #{@args}"
    puts "username      : #{@username}"
  end

  def commit
    @args.each_cons(2).map {|param, value| value if param == '--commit' }.compact[0]
  end

  def initialize params
    @path ||= `pwd`
    @git = Git.new @path
    @command ||= validate_command params[0]
    @args ||= params[1..-1]
    @commit = commit
    @sys_tags = { :current => 'current', :previous => 'previous' }
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

  def add_assets
    puts 'adding assets'
  end

  def manage_tags
    rotate_tags unless @git.current_tag_commit == @commit
  end

  def rotate_tags
    delete_tag_previous if exists_tag_previous
    create_tag_current unless exists_tag_current
    create_tag_alias
    refresh_tag_current
  end

  def delete_tag_previous
    @git.delete_tag @sys_tags[:previous]
  end

  def exists_tag_previous
    @git.tags.include? @sys_tags[:previous]
  end

  def create_tag_current
    @git.create_tag @sys_tags[:current]
  end

  def exists_tag_current
    @git.tags.include? @sys_tags[:current]
  end

  def create_tag_alias
    @git.make_tag_alias @sys_tags
  end

  def refresh_tag_current
    @git.refresh_tag @sys_tags[:current]
  end

  def upload
    manage_tags
    set_auth
    connect
    add_assets
  end

  def connect
    @gh_token = @git.get_gh_token
    raise "no token authentication provided" unless @gh_token

    @client = Octokit::Client.new :access_token => @gh_token
    @username = @client.login
  end

  def set_auth
    @git.get_gh_token
  end

end
