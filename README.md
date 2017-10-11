github: https://github.com/djkullas/microblog
microblog url: http://microblog.kullasdj.com

Login:

My microblog allows the user little functionality without logging in. All
you can do is look at the posts of every user and the users themselves. Logging in
allows the user to follow other and post messages. The logged in user can only
edit and delete their own information and posts. Logging out returns the user
to the previous state before being logged in. You login by using the user's email.

Post:

Posting adds a post to the current user that posted it. This post goes on their
profile and can later be edited or deleted. Users who follow this user will see
this post on their home screen. Other users cannot edit or delete your posts.

Follow:

Following another user causes their posts to show up on your home screen. It also
adds them to your following page so you can keep track of the users you are following.
You can remove them from this list at any time. When you follow a user, you will
now show up on their followers page, and they can remove you at any time. You cannot
remove users from another user's followers or following list.

Likes:

Likes are visible for each post when you go to the post show.html page. It shows the
number of likes for that post. Users can only like a post one time. If the current user
has already liked the post, the like button is not displayed. If the current user
likes the post, the like button becomes disabled and the like count goes up by one.
Users are able to like their own posts.

Deploy Script:

The deploy script is run on the server. It is run by going to the checked out git
repo and typing "./deploy.sh <PATH TO DEPLOY TO>". It unzips the build file to
the directory specified and starts the phoenix app.
