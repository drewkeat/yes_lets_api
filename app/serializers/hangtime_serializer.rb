class HangtimeSerializer
  include JSONAPI::Serializer
  attributes :start, :end
  has_many :users
end
