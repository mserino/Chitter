require 'sinatra'
require 'sinatra/flash'
require 'data_mapper'
require 'sinatra/partial'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
set :views, Proc.new{ File.join(root, 'views') }
set :partial_template_engine, :erb

use Rack::Static, :urls => ['/css', '/js', '/images'], :root => 'public'