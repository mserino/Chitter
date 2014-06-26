require 'bcrypt'

class User
	include DataMapper::Resource

	has n, :cheets

	property :id, Serial
	property :email, String, :unique => true, 
												   :message => "This email is already taken",
												   :required => true
	property :name, String, :required => true
	property :username, String, :required => true,
															:unique => true
	property :password_digest, Text, :required => true

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, :message => "Your passwords don\'t match"
	validates_length_of :password, :min => 5

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

end