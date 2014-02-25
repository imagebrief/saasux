$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'yaml'

require 'simplecov'
SimpleCov.start

require 'saasux'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# Helper method to recursively symbolize keys when reading a YAML
# configuration file. Rails provides HashWithIndifferentAccess but as
# we are testing a gem we cannot rely on it here.
# See: http://devblog.avdi.org/2009/07/14/recursively-symbolize-keys/
def symbolize_keys(hash)
  hash.inject({}){|result, (key, value)|
    new_key = case key
              when String then key.to_sym
              else key
              end
    new_value = case value
                when Hash then symbolize_keys(value)
                else value
                end
    result[new_key] = new_value
    result
  }
end

# VCR configuration
VCR.configure do |c|
  c.cassette_library_dir = 'vcr/saasu'
  c.hook_into :webmock
  # c.filter_sensitive_data('<WSACCESSKEY>') { 'wsaccesskey' }
  # c.filter_sensitive_data('<FILEUID>') { 'fileuid' }
end


# Load YAML file and symbolize hash keys
saasu_config = symbolize_keys(YAML.load_file("spec/saasu.yml"))

# Set into rspec config so it is available within specs
RSpec.configure do |config|
  config.add_setting :saasu_config
  config.saasu_config = saasu_config
end