## Project

### Admin
Has access to all users(CRUD)
Has access to all posts (CRUD)

### User
Has to login for creating new post
Only can update/delete own post
Can follow other user
Can comment on own post
Also can comment on post whom they follow
Can like the post

### User Type
2 [admin, user]
Authentication => jwt?

### Tables
Users
Posts
Comments
Follows

### Table definitions
Users =>
first_name, last_name, email, password
Posts =>
Title, description, user_id
Comments =>
Comment, post_id, user_id
Followers =>
user_id(who follow), user_ids(whom he follows)

docker compose exec web rails g scaffold user first_name:string last_name:string email:string password:string --force

docker compose exec web rails g scaffold post title:string description:text user_id:integer --force

docker compose exec web rails g scaffold comment comment:text, post_id:integer user_id:integer --force

docker compose exec web rails g scaffold follower follower:integer follow:integer --force
