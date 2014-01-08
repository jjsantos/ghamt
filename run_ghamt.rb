require_relative "lib/ghamt.rb"

def check_parameters argv
  case argv[0]
  when 'upload' || 'download' || 'install' || 'reset'
    @command = argv[0].to_sym
  else
    raise RuntimeError, "bad command: #{argv}."
  end
end

def create_client
  token=`git config --global --get github.token`
  raise RuntimeError, 'Token missing.' if token == nil
  github = Github.new :oauth_token => token.chomp
end

check_parameters ARGV
@gh_client = create_client
