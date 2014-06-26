env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")


require_relative 'models/cheet'
require_relative 'models/user'
# DataMapper.auto_migrate!

# After declaring your models you should finalize them
DataMapper.finalize
# DataMapper.auto_migrate!
DataMapper.auto_upgrade!