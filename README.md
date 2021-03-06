# COM Attendance 📚
 
### Description
COM Attendance is a system for monitoring student attendance in the Computer Science department,
 
![COM Attendance Logo](logo.png "COM Logo")
 
The system is intended for 3 types of users:
- Student users
- Lecturer users
- Admin users
 
 
### Significant Features/Technology
The system has the following:
 
##### Students
- Students can login to the system using their university credentials. If it is their first time logging in, an account will be automatically created for them.
- Students can enter a session code given to them by a lecturer for a particular session in order to register as present for that session.
- Students can view which sessions they have attended in the past by accessing the history page from the dashboard.
- Students can scan a QR code provided by the lecturer which will take them to a page where they can log in and then confirm their attendance at that particular session in order to log in. This is an alternative to signing in using a code.
<img src="https://i.imgur.com/87wRLiG.png" width="500">
 
 
##### Lecturers
- Lecturers can sign into the system using their university credentials.
- Lecturers can create new sessions from the dashboard by navigating to the new session page - sessions can be created by specifying title, start time and end time.
- Lecturers can register other lecturers to their session.
- Lecturers can display the session code for an upcoming session.
- Lecturers can see a list of upcoming sessions on their dashboard. This is filtered by week.
- Lecturers can edit an existing session’s details and update the same details as when they created the session.
- Lecturers have the option to delete an upcoming session of theirs.
<img src="https://i.imgur.com/mhD4FlR.png" width="500">

 
##### Admins
- Initially there is a single admin that is able to create new lecturers and admins that will use the attendance system.
- These other admins will be able to log into an admin dashboard with their university credentials once they have been given admin privileges by the admin.
- The administrators will use the system to download SAM reports for past sessions as csv files - which should contain all of the required information automatically.
- The past sessions are accessible from the dashboard in chronological order.
- Admins can create sessions in bulk from the dashboard by uploading a csv file.
<img src="https://i.imgur.com/ovijOI2.png" width="500">
 
 
 
### Installing
* Download the code from the [repository](https://git.shefcompsci.org.uk/com3420-2020-21/team11/project).
* Ensure your VPN is turned on
* If on WSL, start postgresql server with `sudo service postgresql start`
* Install dependancies with `bundle install`
* Migrate database with `rails db:create db:migrate`
* Start rails server with `bundle exec rails s`
* Download the code from the repository https://git.shefcompsci.org.uk/com3420-2020-21/team11/project
* Ensure your VPN is turned on
* If on WSL, start postgresql server with `sudo service postgresql start`
* Create a new file called database.yml in config folder `config/database.yml`
* Copy from all content from `config/database_sample-pg.yml` if using postgres else `config/database_sample-sqlite.yml` to `config/database.yml`
* If on WSL, comment out lines as instructed in `config/database.yml`
* Run `./bin/setup`
* Install rails dependencies with `bundle install`
* Install yarn dependencies with `yarn install`
* Migrate database with rails `db:migrate`
* Seed database with rails `db:seed`
* Start rails server with `bundle exec rails s`

 
### Tests
To run the RSpec tests for the system, please run:

`bundle exec rspec spec`


### Support
Project Contact <agoody1@sheffield.ac.uk>
 
 
### Authors
 
* **Angus Goody** 
* **Manas Sarpatwar**
* **Nathanael Heath** 
* **Yash Ghelani** 
* **Rihan Faiz** 
* **Yuxuan Chen**
