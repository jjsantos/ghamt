# ghAMT

  The GitHub Asset Management Toolkit provides a set of ruby scripts able to manage release assets, namely packaged builds that are created through a Continuous Integration system like Travis, CMake or Jenkins.

  The base use case is a project's CI build that generates one or more installable packages as it builds. The package(s) are then checked for sanity and made available through upload in Github's release area.

## Installation

Install it with:

    $ gem install ghamt


Or, add this line to your application's Gemfile:

    gem 'ghamt'

and then execute:

    $ bundle

## Usage

ghamt --current [COMMIT_ID]

## Contributing

1. Fork it ( http://github.com/kitanda/ghamt/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
