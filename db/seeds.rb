# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Generate a bunch of additional users.
2.times do |n|
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  user = User.create!(
               email: email,
               password:password,
               password_confirmation: password,
               confirmed_at: Time.zone.now + n.seconds)

  user.create_user_profile!(first_name: 'Adminvijay', phone: '123456789')
  user.create_role!(role_name: 'admin')
  org = user.create_organization!(organization_name: "Ongraph + #{n}")
  user.organization_memberships.create!(organization_id: org.id)

  10.times do |i|
    invite = User.invite!({email: "leader1-#{i}@gmail.com"}, user)
    invite.create_user_profile!(first_name: 'Leadervijay', phone: '123456789')
    invite.create_role!(role_name: 'leader')
    invite.organization_memberships.create!(organization_id: org.id)
    invite.groups.create!(group_name: "group1-#{i}", organization_id: org.id)
    invite.update!(confirmed_at: Time.zone.now + i.minutes,
      invitation_accepted_at: Time.zone.now + i.minutes)

    10.times do |m|
      member = User.invite!({email: "member1-#{m}@gmail.com"}, invite)
      member.create_user_profile!(first_name: 'Membervijay', phone: '123456789')
      member.create_role!(role_name: 'member')
      member.organization_memberships.first_or_create!(organization_id: org.id)
      member.update!(confirmed_at: Time.zone.now + m.minutes,
        invitation_accepted_at: Time.zone.now + m.minutes)
    end

    10.times do |m|
      member = User.invite!({email: "member2-#{m}@gmail.com"}, invite)
      member.create_user_profile!(first_name: 'Membervijay', phone: '123456789')
    end
  end

  10.times do |i|
    invite = User.invite!({email: "leader2-#{i}@gmail.com"}, user)
    invite.create_user_profile!(first_name: 'Leadervijay', phone: '123456789')
    invite.groups.create!(group_name: "group2-#{i}", organization_id: org.id)
  end
end
