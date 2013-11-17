source 'http://rubygems.org'

gem 'sinatra', '~> 1.2', :require => 'sinatra/base'
gem 'dragonfly', '~> 0.9.14'
#gem 'magickly', '~> 1.2'
gem('magickly',
    :git => 'git://github.com/afeld/magickly.git',
    :ref => 'cd17608a9c4468da1f738815a96dc2a9473fc029')
#gem 'magickly', :path => '../magickly'
gem 'activesupport', '< 4.0' # requires Ruby version >= 1.9.3

gem 'excon', '~> 0.25.3'
gem 'faraday', '~> 0.8.8'

gem 'addressable', '~> 2.2', :require => 'addressable/uri'
gem 'haml', '>= 3.0', '< 5'

gem "dimensions", "~> 1.2.0"

group :development do
  gem 'jeweler', '~> 1.6'
end

group :development, :test do
  gem 'rack-test', :require => 'rack/test'
  gem 'rspec', '~> 2.5'
  
  gem 'debugger'
end

group :test do
  gem 'webmock', '~> 1.6', :require => 'webmock/rspec'
  gem 'vcr', '~> 2.2'
end

group :production do
  gem 'newrelic_rpm', :require => false
end
