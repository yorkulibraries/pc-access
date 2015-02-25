#PC ACCESS

## About
Simple Ruby on Rails app to detect which computers are available.

><strong>Note:</strong> Development just started. Not ready for production use.

## Requirements
- Rails 4.2
- Ruby 2.1.x


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
}
```
Therefore, config/database.yml will actually be a symlink which points to shared/config/database.yml and so on.

## Troubleshooting

###<strong>Issue</strong>
```
$> cap deploy 
Stage not set, please call something such as `cap production deploy`, where production is a stage you have defined.
```
###<strong>Solution</strong> 
The project currently only has a production file. Just run
$> cap production deploy

<hr />

###<strong>Issue</strong>

```
ERROR LOG:
App 17468 stderr: [ 2015-02-25 11:44:18.0345 18177/0x007fb68a53d548(Worker 1) utils.rb:68 ]: *** Exception RuntimeError in Rack application object (Missing `secret_key_base` for 'production' environment, set this value in `config/secrets.yml`) (process 18177, thread 0x007fb68a53d548(Worker 1)):
```
and/or 
```
APP ERROR LOG:
[Wed Feb 25 11:18:13 2015] [error] [client xxx.xxx.xxx.xxx] Premature end of script headers: 
```
###<strong>Solution</strong>

Make sure that you have either 
- ```export SECRET_KEY_BASE=`MY_SECRET_KEY``` in your .bash_profile OR 
- symlinked to config/secret.yml in your production server. 
>Hint: You can use :linked_files to symlink it.

<hr />