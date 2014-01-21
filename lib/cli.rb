def greet
  puts "ghAMT starting"
end

def exit
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

def set_values params
  @path ||= `pwd`
  @command ||= params[0] if validate_command params[0]
  @commit ||= latest_commit @path
  @args ||= params[1..-1]
end

def validate_command command
  case command
    when "upload"
      true
    when "manage"
      true
    when "download"
      true
    when "install"
      true
    when "reset"
      true
    when "test"
      true
    else
      false
  end
end

def check_values
	raise "invalid command" unless @command
end

greet
set_values ARGV
check_values
show_params
exit

