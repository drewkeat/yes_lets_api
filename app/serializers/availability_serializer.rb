class AvailabilitySerializer
  include JSONAPI::Serializer
  attributes :start, :end
  belongs_to :user
end
