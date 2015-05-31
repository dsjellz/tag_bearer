## Tag Bearer ![Travis CI](https://travis-ci.org/dsjellz/tag_bearer.svg?branch=master "Build Status") [![Code Climate](https://codeclimate.com/github/dsjellz/tag_bearer/badges/gpa.svg)](https://codeclimate.com/github/dsjellz/tag_bearer) [![Test Coverage](https://codeclimate.com/github/dsjellz/tag_bearer/badges/coverage.svg)](https://codeclimate.com/github/dsjellz/tag_bearer/coverage)
A gem that handles tags in a "Key"/"Value" setup.

We've been using acts_as_taggable_on for a lot of projects, and if all you need are single tags, it's a great solution. But similar to AWS, we needed a solution that allowed us to use Keys and Values, and Tag Bearer was born. 

*This gem has been tested against mysql and postgresql*

Setup is simple 

``` bash
gem install tag_bearer
```

Generate and run rails migration
```bash
rails generate tag_bearer:install
rake db:migrate
```

*If you change the default table name you must let TagBearer know in an initializer*
```ruby
# config/initializers/tag_bearer.rb
TagBearer.tag_table = 'new_table_name'
```

Add to model
```ruby
class YourModel < ActiveRecord::Base
  acts_as_tag_bearer
end
```

Tag a model
```ruby
# single tag
instance.tag(key: 'environment', value: 'development')

# multiple tags
instance.assign_tag(environment: 'development', owner: 'appowner')

```

Get a tag value on a model
```ruby
instance.get_tag :environment
# development
```

Get a list of tag names a model is tagged with
```ruby
instance.tag_list
# ['environment', 'app_name', 'owner']
```

Do a complete sync of all tags
*Note: This is destructive and will remove all tags no longer included*
```ruby
params = [
  {key: 'environment', value: 'production'},
  {key: 'owner', value: 'you'}
]
instance.full_sync!(params)
```

Get the model associated with a specific tagging
```ruby
TagBearer::Tag.first.owner
##<YourModel id: 1, created_at: "2015-05-25 02:25:38", updated_at: "2015-05-25 02:25:38">
```

Find models that match tag conditions
```ruby
Model.with_tags(environment: 'production', owner: 'johndoe')
##[<YourModel id: 1, created_at: "2015-05-25 02:25:38", updated_at: "2015-05-25 02:25:38">]
```