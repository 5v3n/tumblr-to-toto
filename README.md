# tumblr-to-toto

Basically, I just wanted to try that ruby based blog: [toto](http://github.com/cloudhead/toto).

As it turned out, that test made me want to migrate to toto completely. So I had to move my [Tumblr](http://tumblr.com) blog.

This little tool helped me to do so: it migrates exported Tumblr posts into valid toto posts.

## Features

- convert regular posts from Tumblr to toto
- that's basically all there is - feel free to write a converter for foto / video / quote posts as well

## Usage

- Export your tumblr posts using [tumblr backup](http://staff.tumblr.com/post/286303145/tumblr-backup-mac-beta)
- I know there must be elegant ways to do so, but in the meantime use these rake tasks to migrate a file or a directory

    `rake convert_file[<file>]`

    `rake convert_directory[<directory>]`

- the result will be stored in a directory named after the timestamp you started the export on and contains directories for the different post types (regular, video, conversation etc.)
- that's it - congrats, you just migrated your blog posts from Tumblr to toto