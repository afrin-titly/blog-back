# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: "admin@myblog.com", password: "secret123", first_name: "Ms.", last_name: "Admin")

post1 = Post.create(title: "Title 1", description: "Long post", user: admin)
comment1 = Comment.create(comment: "long comment 1", user: admin, post: post1)
comment2 = Comment.create(comment: "long comment 2", user: admin, post: post1)
