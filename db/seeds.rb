# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
# Create permissions
manage_users = Permission.create!(name: 'manage_users')
manage_roles = Permission.create!(name: 'manage_roles')
manage_permissions = Permission.create!(name: 'manage_permissions')
read_only = Permission.create!(name: 'read_only')

# Create roles
admin_role = Role.create!(name: 'Admin')
admin_role.permissions << [manage_users, manage_roles, manage_permissions]

manager_role = Role.create!(name: 'Manager')
manager_role.permissions << [manage_users, read_only]

user_role = Role.create!(name: 'User')
user_role.permissions << [read_only]

# Create initial admin user
User.create!(
  email: 'admin@example.com',
  password: 'password',
  role: admin_role
)