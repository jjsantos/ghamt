require 'manager.rb'

m = Manager.new ARGV
m.greet

m.check_values
# m.show_params
m.execute
# m.show_params
m.quit
