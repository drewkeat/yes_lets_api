class HangtimeSerializer
  include JSONAPI::Serializer
  attributes :start, :end
end
