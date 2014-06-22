class Posts
	include DataMapper::Resource

	property :id, Serial
	property :post, String

end