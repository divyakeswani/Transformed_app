# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
return unless Rails.env == 'development' || Rails.env == 'test' || ENV['HEROKU_BRANCH'].present?

# Method to make users
def make_user(attrs)
  options = attrs.dup

  options[:confirmed_at] = DateTime.now
  options[:password] = 'password'
  options[:password_confirmation] = 'password'

  User.first_or_create(options)
end

# Method to make organization Admins
def make_organization_admin(attrs)
  user = make_user(attrs)

  # Create Organization
  organization = Organization.create!(
    organization_name: 'Example Organization', user_id: user.id
  )

  # Create Membership and Set Role
  OrganizationMembership.create!(
    organization: organization, user: user
  )

  UserProfile.create!(
    first_name: 'john', user: user, phone: '123456'
  )
end