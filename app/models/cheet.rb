require 'dm-core'
require 'dm-validations'

class Cheet
	include DataMapper::Resource

	belongs_to :user

	property :id, Serial
	property :cheet, Text, :required => true, :message => 'You cannot submit an empty cheet'

end