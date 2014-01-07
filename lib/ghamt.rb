require "ghamt/version"
require 'rubygems'
require 'github_api'
require 'open-uri'

ERROR_MISSING_TOKEN = 'Token missing.'

module Ghamt
  puts "ghAMT #{VERSION}"

  TOKEN=`git config --global --get github.token`
  raise RuntimeError, ERROR_MISSING_TOKEN if TOKEN == nil

  github = Github.new :oauth_token => TOKEN.chomp
end
