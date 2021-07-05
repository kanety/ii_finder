# IIFinder

A base finder to support building relations from parameters.

## Dependencies

* ruby 2.3+
* activesupport 5.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ii_finder'
```

Then execute:

    $ bundle

## Usage

Prepare model:

```ruby
class User < ActiveRecord::Base
end
```

Prepare finder:

```ruby
class UsersFinder < IIFinder::Base
  parameters :name

  def name(value)
    @relation.where(name: value)
  end
end
```

Use finder as follows:

```ruby
UsersFinder.call(name: 'NAME').to_sql
#=> SELECT "users".* FROM "users" WHERE "users"."name" = 'NAME'
```

You can also specify relation as first argument:

```ruby
UsersFinder.call(User.where(id: [1, 2, 3]), name: 'NAME').to_sql
#=> SELECT "users".* FROM "users" WHERE "users"."id" IN (1, 2, 3) AND "users"."name" = 'NAME'
```

### Finder

Finder loops keys of `parameters` and call the corresponding method with value of parameter as argument.
Finder method will not be called when the value of parameter is blank.
If you want to receive such value, set `allow_blank` as follows:

```ruby
class UsersFinder < IIFinder::Base
  parameters :name, allow_blank: true

  def name(value)
    @relation.where(name: value)
  end
end

UsersFinder.call(name: '').to_sql
#=> SELECT "users".* FROM "users" WHERE "users"."name" = ''
```

Finder has following attributes:

```ruby
class UsersFinder < IIFinder::Base
  parameters :name

  def name(value)
    puts "relation: #{@relation}"
    puts "criteria: #{@criteria}"
    puts "model: #{@model}"
    puts "table: #{@table}"
  end
end

UsersFinder.call(name: 'NAME')
#=> relation: #<User::ActiveRecord_Relation:
#   criteria: {:name=>'NAME'}
#   model: User
#   table: #<Arel::Table ...>
```

Return value of each finder method is merged into `@relation` if it is a kind of `ActiveRecord::Relation`.
In case you want to merge by yourself, set configuration as follows:

```ruby
IIFinder.configure do |config|
  config.merge_relation = false
end

class UsersFinder < IIFinder::Base
  parameters :name

  def name(value)
    @relation = @relation.where(name: value)
  end
end

UsersFinder.call(name: 'NAME').to_sql
#=> SELECT "users".* FROM "users" WHERE "users"."name" = 'NAME'
```

#### Callbacks

Following callbacks are available.

* `before_call`
* `around_call`
* `after_call` 

For example:

```ruby
class UsersFinder < IIFinder::Base
  after_call :default_order

  def default_order
    @relation = @relation.order(id: :desc)
  end
end

UsersFinder.call.to_sql
#=> SELECT "users".* FROM "users" ORDER BY "users"."id" DESC
```

Note that finder does not handle the return value of callback.
When you want to update `@relation` in the callback,
reassign `@relation` or use methods like `where!` or `order!`.

### Lookup for model

Finder lookups related model by its class name when the first argument of `call` is not relation.
So the name of finder class should be composed of the name of model class.
For example:

```ruby
class User < ActiveRecord::Base
end

class UsersFinder < IIFinder::Base
end

IIFinder::Base.lookup(UsersFinder)
#=> User
```

Note that superclass of finder is also looked up until related model is found.

```ruby
class User < ActiveRecord::Base
end

class UsersFinder < IIFinder::Base
end

class InheritedUsersFinder < UsersFinder
end

IIFinder::Base.lookup(InheritedUsersFinder)
#=> User
```

### Scope for model

In case you want to call finder from model, include `IIFinder::Scope` into model as follows:

```ruby
class User < ActiveRecord::Base
  include IIFinder::Scope
end

User.finder_scope(name: 'NAME').to_sql
#=> SELECT "users".* FROM "users" WHERE "users"."name" = 'NAME'
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_finder.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
