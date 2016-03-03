class User < BaseModel
  include Ohm::Timestamps

  attribute :name

  # Unique identifier for this user, in the form "{provider}|{provider-id}"
  attribute :uid
  index     :uid
  unique    :uid

  # Unique email for this user
  attribute :email
  index     :email
  unique    :email

  # Session token
  attribute :token
  index     :token

  # Submitted movies
  collection :movies, :Movie
end
