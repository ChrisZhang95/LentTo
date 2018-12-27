# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
    Delete /db/development.sqlite3 

    **if database schema is inconsistent.**

    After cloning, run `bundle install` (Resolve any gem version issues)

    Migrate database `rails db:migrate`

      * Figaro config/application.yml

        GOOGLE_CLIENT_ID: `xxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

        GOOGLE_CLIENT_SECRET: `XXXXXXXXXXXXXXXX`

        FACEBOOK_APP_ID: `XXXXXXXXXX`

        FACEBOOK_APP_SECRET: `XXXXXXXXXXXXXXXX`

        SSL_LOCATION: `C:/RailsInstaller/cacert.pem`

        production:
          SSL_LOCATION: /usr/lib/ssl/certs/ca-certificates.crt


* Database creation

  * **User Table**

    | Column Name            | Data Type                                |
    | ---------------------- | ---------------------------------------- |
    | id                     | integer [auto]                           |
    | email                  | string                                   |
    | encrypted_password     | string                                   |
    | reset_password_token   | string                                   |
    | reset_password_sent_at | datetime                                 |
    | remember_created_at    | datetime                                 |
    | confirmation_token     | string                                   |
    | confirmed_at           | datetime                                 |
    | confirmation_sent_at   | datetime                                 |
    | unconfirmed_email      | string                                   |
    | timestamps**           | [auto]                                   |
    Note: This module works with the devise gem. Also, future development will include columns for OmniAuth

* **Profile Table**

    | Column Name     | Data Type                                |
    | --------------- | ---------------------------------------- |
    | id              | integer [auto]                           |
    | first_name      | string                                   |
    | last_name       | string                                   |
    | picture         | string                                   |
    | user(_id)       | references (user table)                  |
    | transaction(_id)| references (transaction table)          |

    We may add more personal information (ie. linked social media info, gender, etc) to this table later.

  * **Category Table**

    | Column Name | Data Type                       |
    | ----------- | -------------------------       |
    | id          | integer [auto]                  |
    | name        | string                          |
    | item(_id)   | references  (item table)        |

    No subcategories at the moment. We might introduce it in future developments.

    ​

  * **Item Table**

    | Column Name           | Data Type                           |
    | --------------------- | ----------------------------------- |
    | id                    | integer [auto]                      |
    | name                  | string                              |
    | user(_id)             | references  (user table)            |
    | category(_id)         | references  (category table)        |
    | transaction(_id)      | references  (transaction table)     |

    All general item information will go in here.

  * **Transaction Table**

    | Column Name   | Data Type                    |
    | ------------- | ---------------------------- |
    | id            | integer [auto]               |
    | item(_id)     | references  (item table)     |
    | profile(_id)  | references  (profile table)  |
    | start_date    | datetime                     |
    | end_date      | datetime                     |

    Note: user id in transaction table is the borrower.

    More personalized information about the transaction will be included here

* Database initialization
  You can initialize the database with: `rails db:seed`

  Also if you wish to fill the database with dummy data, do:

  ​	 `rails db:fixtures:load`
  	then replace `storage` folder with `storage_test` folder
  	This will clear any existing record in the database.
  	4 Users are automagically created with password `123456`:
  		ben@example.com
  		bryan@example.com
  		eve@example.com
  		stacy@example.com



* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
