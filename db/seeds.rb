# generate 20 users
(1..10).each do |id|
    User.create!(
# each user is assigned an id from 1-10
        id: id,
        email: Faker::Internet.email,
        username: Faker::Internet.email.split("@").first,
# issue each user the same password
        password: "password", 
        password_confirmation: "password",
        admin: Faker::Number.between(from: 0, to: 1)
    )
    1.times do 
    group = Group.create(
        name: Faker::Adjective.unique.positive
    )
    group.save!
  end   
    1.times do # assign some users to groups/admin roles in group_users table
        group_users = GroupUser.create(
            role: User.all().sample.admin? ? 1 : 0,
            user_id: User.all().sample.id,
            group_id: Group.all().sample.id
         )
        group_users.save!
    end
end 

# Seeding is not a perfect representation of DB, just gives some usable data to work with


