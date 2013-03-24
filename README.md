# inquest

[![Code Climate](https://codeclimate.com/github/joshmcarthur/inquest.png)](https://codeclimate.com/github/joshmcarthur/inquest) [![Build Status](https://travis-ci.org/joshmcarthur/inquest.png)](https://travis-ci.org/joshmcarthur/inquest)


Inquest is a host-your own, private Q&A application, a la StackOverflow. Created at Railscamp NZ '13.

### Features:

Take a look at the development Trello board for what's complete, what's being worked on, and what's in the backlog:

#### [Trello Board](https://trello.com/board/inquest-development/514f7c67000aa67f660056d8)

### Getting Started:


1. Clone the repo and cd into the new project
  ``` bash
    git clone git@github.rc:joshmcarthur/inquest.git
    cd inquest
  ```

2. Create a database
  ``` bash
    cp config/database.yml.example config/database.yml
    rake db:setup
  ```

3. Run the specs
  ``` bash
    rake spec
  ```
  
4. Start the server
  ``` bash
    bundle exec rails s 
  ```
  
### Bugs, Issues and Features:

**If you find a bug, or have a feature that you think should be added to the project - awesome!** Please add an issue to the Github project, so that we can work on it together and figure out the best way to either fix the bug or build the feature. If it's a a feature, then we'll add it to our backlog on the Trello board, so that everyone else can see that it's an outstanding feature. If it's a bug, then either you or us will fix it as soon as possible.

### License

MIT License. See the `LICENSE` file for details.

