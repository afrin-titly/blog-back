# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: "admin@myblog.com", password: "secret123", first_name: "Ms.", last_name: "Admin")
user1 = User.create(email: "user1@testmail.com", password: "secret", first_name: "Ms.", last_name: "User 1")
user2 = User.create(email: "user2@testmail.com", password: "secret", first_name: "Ms.", last_name: "User 2")

post1 = Post.create(title: "Title 1", description: "Long post 1", user: admin)
post2 = Post.create(title: "Title 2", description: "Long post 2", user: user1)
post3 = Post.create(title: "Title 3", description: "Long post 3", user: user2)
post4 = Post.create(title: "Title 4", description: "Long post 4", user: user2)
f1 = Follower.create(user_id: 2, follow: 1)
f2 = Follower.create(user_id: 2, follow: 3)
f3 = Follower.create(user_id: 3, follow: 2)

uc1 = UserComment.create(user_id:2, post_id:1, comment_id: 1)
uc2 = UserComment.create(user_id:3, post_id:2, comment_id: 2)
comment1 = Comment.create(comment: "long comment 1")
comment2 = Comment.create(comment: "long comment 2")
