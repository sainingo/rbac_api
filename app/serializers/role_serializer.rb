class RoleSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :permissions
end
