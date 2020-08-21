require 'bundler/setup'
require 'lolcat'
Bundler.require

require_all 'lib'

ActiveRecord::Base.logger = nil