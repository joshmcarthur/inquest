# inquest


Inquest is a simple, open-source callaboratively edited question and answer site by @joshmcarthur and @charles

## getting started

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

