# group-users-api

# Auth
Is on User only, so subsequent models can be used with 'before_action :authenticate_user!' in its controller. Uses JWT, JTI in users table for current token

# Group create/assign in group_users, only by admin user
# Group show/index in groups, by any registered user.

# Set up
bundle install
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
rake secret  (& place in .env file after copy _env-example - DEVISE_JWT_SECRET_KEY=generated-secret-key-here) 

# Start server
bin/dev  (port 5000)

# Register test user no 11
curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "id": 11, "username": "randomuser","email": "myemail@email.com", "password": "mypassword" } }' http://localhost:5000/signup

# Login (header jwt token) test user
curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "username": "randomuser", "email": "myemail@email.com",  "password": "mypassword" } }' http://localhost:5000/login 

# To test user as admin and (to create/assign groups) (GroupUsers relation class/table) - console basics.

1. Register user with curl as above, then open rails console:
2. group = Group.create(name: "Test Group") - so we have a new group_id
3. user = User.where(id: 11).update(admin: "admin") - so we have a new admin user_id
4. guseradmin = GroupUser.create(user_id: 11, group_id: 11) - assign the new admin user to the new group
5. guser = GroupUser.create(user_id: 10, group_id: 11) - assign a standard user to the new group (get one from seeded data)

# Admins
uadmins = User.where(admin: "admin")  (users who are admins) users table
gadmins = GroupUser.where(role: "admin") (group_users with admin role) group_users table

In theory should match! (not with seeds file)

# Seeding (if used) - populate db with sample data for 10 users, groups and group_users tables.

rail db:seed

# Routes
                           Prefix Verb   URI Pattern                                                                                       Controller#Action
                        new_user_session GET    /login(.:format)                                                                                  users/sessions#new
                            user_session POST   /login(.:format)                                                                                  users/sessions#create
                    destroy_user_session DELETE /logout(.:format)                                                                                 users/sessions#destroy
                       new_user_password GET    /password/new(.:format)                                                                           devise/passwords#new
                      edit_user_password GET    /password/edit(.:format)                                                                          devise/passwords#edit
                           user_password PATCH  /password(.:format)                                                                               devise/passwords#update
                                         PUT    /password(.:format)                                                                               devise/passwords#update
                                         POST   /password(.:format)                                                                               devise/passwords#create
                cancel_user_registration GET    /signup/cancel(.:format)                                                                          users/registrations#cancel
                   new_user_registration GET    /signup/sign_up(.:format)                                                                         users/registrations#new
                  edit_user_registration GET    /signup/edit(.:format)                                                                            users/registrations#edit
                       user_registration PATCH  /signup(.:format)                                                                                 users/registrations#update
                                         PUT    /signup(.:format)                                                                                 users/registrations#update
                                         DELETE /signup(.:format)                                                                                 users/registrations#destroy
                                         POST   /signup(.:format)                                                                                 users/registrations#create
                            current_user GET    /current_user(.:format)                                                                           current_user#index
                             group_users POST   /group_users(.:format)                                                                            group_users#create
                              group_user PATCH  /group_users/:id(.:format)                                                                        group_users#update
                                         PUT    /group_users/:id(.:format)                                                                        group_users#update
                                         DELETE /group_users/:id(.:format)                                                                        group_users#destroy
                                  groups GET    /groups(.:format)                                                                                 groups#index
                                   group GET    /groups/:id(.:format)                                                                             groups#show
                group_users_create_group POST   /group_users/create_group(.:format)                                                               group_users#create_group
                                         POST   /group_users/:id(.:format)                                                                        group_users#assign_user_to_group


# To fix

1. No token when login with only the username/pw