# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Microblog.Repo.insert!(%Microblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Microblog.Repo
alias Microblog.Blog.User

 Microblog.Repo.insert!(%User{name: "John Doe", handle: "jdoe123", email: "jdoe@gmail.com",
 password: "password"})

 Microblog.Repo.insert!(%User{name: "Bill Bob", handle: "bbabc", email: "bbob@gmail.com",
 password: "password"})

 Microblog.Repo.insert!(%User{name: "Sally Jones", handle: "sjones", email: "sjones@gmail.com",
 password: "password"})

 Microblog.Repo.insert!(%User{name: "George Bush", handle: "gbush", email: "gbush@gmail.com",
 password: "password"})

 Microblog.Repo.insert!(%User{name: "Steve Jobs", handle: "sjobs", email: "sjobs@gmail.com",
 password: "password"})

 Microblog.Repo.insert!(%User{name: "Candy Cain", handle: "ccain", email: "ccain@gmail.com",
 password: "password"})

 Microblog.Repo.insert!(%User{name: "Shirley Temple", handle: "stemple", email: "stemple@gmail.com",
 password: "password"})
