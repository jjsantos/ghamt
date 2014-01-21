class Manager

  def greet
    puts "ghAMT starting"
  end

  def quit
    puts "ghAMT finished!"
  end

  def show_params
    puts "command : #{@command}"
    puts "path    : #{@path}"
    puts "commit  : #{@commit}"
    puts "args    : #{@args}"
  end

  def latest_commit path
    `git log -n 1 --pretty=oneline`.split(" ")[0]
  end

  def initialize params
    @path ||= `pwd`
    @command ||= validate_command params[0]
    @commit ||= latest_commit @path
    @args ||= params[1..-1]
  end

  def validate_command command
    case command
      when "upload", "manage", "download", "install", "reset", "test"
        command
      else
        nil
    end
  end

  def check_values
    raise "invalid command" unless @command
  end

  def execute
    case @command
      when "upload"
        upload self
      when "manage", "download", "install", "reset", "test"
        true
    end
  end

  def upload job
    true
  end
end
