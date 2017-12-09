# README
{<img src="https://travis-ci.org/mkdevprogects/patients.svg?branch=master" alt="Build Status" />}[https://travis-ci.org/mkdevprogects/patients]

Application: the main application that manages complex business logic.
Functionality: processing of patients' appointments, search of doctors and clinics for symptoms and remoteness.

Running:

* Clone app: `git clone git@github.com:mkdevprogects/base.git`
* `cd base/`
* Set the environment variables:
```
  PGUSER  
  PGPASSWORD  
  ENVPOSTGRES_DB  
  VOLUMES  
  ENVPGDATA  
  DB_HOST  
  DB_PG_PORT  
  DB_REDIS_HOST  
  DB_REDIS_PORT  
  HUTCH_MQ_HOST  
  HUTCH_MQ_API_HOST
```  
* `docker-compose -f docker-compose.demo.yml up`
* open browser and go to [http://0.0.0.0:3000/](http://0.0.0.0:3000/) and see patient app
* open browser and go to [http://0.0.0.0:4000/](http://0.0.0.0:4000/) and see manager app
* open browser and go to [http://0.0.0.0:5000/](http://0.0.0.0:5000/) and see history app

Example environment variables:
```
PGUSER=postgres
PGPASSWORD=12345
ENVPOSTGRES_DB=mkdev_dev
VOLUMES=/Users/user_name/pg_data
ENVPGDATA=/Users/user_name/pg_data
DB_HOST=postgres
DB_PG_PORT=5432
DB_REDIS_HOST=redis
DB_REDIS_PORT=6379
HUTCH_MQ_HOST=rabbitmq
HUTCH_MQ_API_HOST=rabbitmq
```
