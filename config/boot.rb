ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
Bootsnap.setup(
  cache_dir:            'tmp/cache', # Path to your cache
  development_mode:     ENV['MY_ENV'] == 'development',
  load_path_cache:      true,        # Should we optimize the LOAD_PATH with a cache?
  compile_cache_iseq:   true,        # Should compile Ruby code into ISeq cache?
  compile_cache_yaml:   true         # Should compile YAML into a cache?
)
