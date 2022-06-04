class UserSerializer
  include JSONAPI::Serializer
  attributes :full_name, :email, :phone_number
  has_many :friends, serializer: :user

end
