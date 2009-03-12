def patch_file(path, after, insert)
  content = File.open(path) { |f| f.read }
  content.gsub!(after, "#{after}\n#{insert}") unless content =~ /#{Regexp.escape(insert)}/mi
  File.open(path, 'w') { |f| f.write(content) }
end

File.unlink 'public/index.html' rescue Errno::ENOENT

file 'script/test-adva-cms', <<-src
  #!/usr/bin/env ruby
  paths = ARGV.clone
  load 'vendor/adva/script/test'
src

patch_file 'config/environment.rb',
  "require File.join(File.dirname(__FILE__), 'boot')",
  "require File.join(File.dirname(__FILE__), '../vendor/adva/engines/adva_cms/boot')"

git :clone => 'git://github.com/svenfuchs/adva_cms.git vendor/adva # this might take a bit, grab a coffee meanwhile :)'

rake 'adva:install:core'
rake 'adva:assets:copy'

# overwrite the rake file so it points to the new location
rakefile "adva-cms.rake", <<-src
  require 'tasks/rails'
  load 'vendor/plugins/adva_cms/lib/tasks/adva_cms.rake'
src

