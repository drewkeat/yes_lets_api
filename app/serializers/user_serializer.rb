class UserSerializer
  include JSONAPI::Serializer
  attributes :full_name, :email, :phone_number
end
