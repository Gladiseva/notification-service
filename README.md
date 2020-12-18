# Back-End for a new notification center

### Technology stack
- **Ruby 2.7.2**
- **Rails 5.2.4.4**
- **PostgreSQL 12**



##### Below are the setups to run Ruby on Rails application on your system:

#### Dependencies

Install all dependencie: `bundle install`

#### Configuration
Pre-configured `dev` (database.yml section) profile includes:
- DB connection to local PostgreSQL database called `notification-service_development` (inherited from default), with credentials:
  - host: `localhost`
  - username: `postgres`
  - password: `1password!`

#### Database
Create db and migrate schema:
- `rake db:create`
- `rake db:migrate`

The data can then be loaded in DB with the rails `rake db:seed` command.

Now run your application: `rails s`

### Usage

Two users are created to seed the database with its default values:

- User1: `email: 'admin@admin.com', password: '1admin!'` with `role: admin`
- User2: `email: 'client@client.com', password: 'clientclient'` with `role: client`

Users with **admin** role has permissions to:
 - see all notifications (where user is sender or recipient)
 - create new notifications
 
Users with **client** role has permissions to:
  - see all notifications (where user is sender or recipient)
  - delete notifications, but only those, which are already read/seen

#### Routes
- GET localhost:3000 (accessible by all roles, whether recipient or sender)
- GET localhost:3000/notifications (accessible by all roles, whether recipient or sender)
- GET localhost:3000/notifications/:id (accessible by all roles, but only for user who is recipient)
- POST localhost:3000/notifications (accessible by admin)
- DELETE localhost:3000/notifications/:id (accessible by client)

##### Back-end can be tested with Postman (Example):
Select: Authorization -> Basic Auth:

-`email: 'admin@admin.com', password: '1admin!'`

(POST localhost:3000/notifications).

Body: `{"recipient_id":2,"title":"title1","description":"description1"}`


