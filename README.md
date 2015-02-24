#PC ACCESS

## About
Simple Ruby on Rails app to detect which computers are available.

<strong>Note:</strong> Development just started. Not ready for production use.

## Setting up Capistrano config file(s)
- Copy the folder config/deploy/production.sample.rb to config/deploy/production.rb
- Edit production.rb and fill in your server details. 


## Setting up Database 
- Create the mysql database on your server
- Copy database.sample.yml to database.yml
- Edit database.yml with you database information.
 - Default setting for dev and test is SQLlite. Mysql is for production. 
 - Make sure to edit your dbuser/dbpassword for mysql.


## Deployment Notes: 
config/deploy/*.rb (e.g. production.rb) and database.yml are in .gitignore. You will need to copy them to your server and place them in the application shared directory. Capistrano 3 has linked_files option to symlink them easily. 

```
set :linked_files, %w{
  config/database.yml
  config/deploy/production.rb
}
```
Therefore, config/database.yml will actually be a symlink which points to shared/config/database.yml and so on.

## Troubleshooting

