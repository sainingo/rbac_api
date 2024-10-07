class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  belongs_to :role
end
