# Democrance Insurance API


### Pre-requisites

Please ensure that ruby 2.7.2 is installed

### Install your project's gems
```
cd <PROJECT> && bundle install
```

### Create Postgres User

Use the below credentials when prompted:

- username: `postgres_user`

- password: `mysecurepass`

If asked, the new role shall be a `super user`
```
sudo -u postgres createuser --interactive --pwprompt
```

If this does not work, try:
```
psql -U postgres
CREATE USER postgres_user WITH PASSWORD 'mysecurepass' SUPERUSER;
```

### Database setup

```
bin/rails db:drop db:create db:schema:load db:migrate:with_data && rails db:seed
```

### Run tests
```
bundle exec rspec
```

### Generate api docs using redoc
```
rake api:doc:html\[v1\]
```
This will generate an html file which you can open in the browser

### Boot rails app
```
bin/rails server -b 0.0.0.0 -p 3000
```

## Endpoints

- API: http://localhost:3000/api
- Admin: http://localhost:3000/admin
