class SubscriptionsSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency, :customer_id, :tea_id
end