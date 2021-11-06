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
class Item < ActiveRecord::Base
end
```

Prepare finder:

```ruby
class ItemsFinder < IIFinder::Base
  parameters :name

  def name(value)
    @relation.where(name: value)
  end
end
```

Use finder as follows:

```ruby
ItemsFinder.call(name: 'NAME').to_sql
#=> SELECT "items".* FROM "items" WHERE "items"."name" = 'NAME'
```

You can also specify relation as first argument:

```ruby
ItemsFinder.call(Item.where(id: [1, 2, 3]), name: 'NAME').to_sql
#=> SELECT "items".* FROM "items" WHERE "items"."id" IN (1, 2, 3) AND "items"."name" = 'NAME'
```

### Finder

Finder loops keys of `parameters` and call the corresponding method with value of parameter as argument.
Finder method will not be called when the value of parameter is blank.
If you want to receive such value, set `allow_blank` as follows:

```ruby
class ItemsFinder < IIFinder::Base
  parameters :name, allow_blank: true

  def name(value)
    @relation.where(name: value)
  end
end

ItemsFinder.call(name: '').to_sql
#=> SELECT "items".* FROM "items" WHERE "items"."name" = ''
```

Finder has following attributes:

```ruby
class ItemsFinder < IIFinder::Base
  parameters :name

  def name(value)
    puts "relation: #{@relation}"
    puts "criteria: #{@criteria}"
    puts "model: #{@model}"
    puts "table: #{@table}"
  end
end

ItemsFinder.call(name: 'NAME')
#=> relation: #<Item::ActiveRecord_Relation:
#   criteria: {:name=>'NAME'}
#   model: Item
#   table: #<Arel::Table ...>
```

Return value of each finder method is merged into `@relation` if it is a kind of `ActiveRecord::Relation`.
In case you want to merge by yourself, set configuration as follows:

```ruby
IIFinder.configure do |config|
  config.merge_relation = false
end

class ItemsFinder < IIFinder::Base
  parameters :name

  def name(value)
    @relation = @relation.where(name: value)
  end
end

ItemsFinder.call(name: 'NAME').to_sql
#=> SELECT "items".* FROM "items" WHERE "items"."name" = 'NAME'
```

#### Callbacks

Following callbacks are available.

* `before_call`
* `around_call`
* `after_call` 

For example:

```ruby
class ItemsFinder < IIFinder::Base
  after_call :default_order

  def default_order
    @relation = @relation.order(id: :desc)
  end
end

ItemsFinder.call.to_sql
#=> SELECT "items".* FROM "items" ORDER BY "items"."id" DESC
```

Note that finder does not handle the return value of callback.
When you want to update `@relation` in the callback,
reassign `@relation` or use methods like `where!` or `order!`.

### Lookup for model

Finder lookups related model by its class name when the first argument of `call` is not relation.
So the name of finder class should be composed of the name of model class.
For example:

```ruby
class Item < ActiveRecord::Base
end

class ItemsFinder < IIFinder::Base
end

IIFinder::Base.lookup(ItemsFinder)
#=> Item
```

Note that superclass of finder is also looked up until related model is found.

```ruby
class Item < ActiveRecord::Base
end

class ItemsFinder < IIFinder::Base
end

class InheritedItemsFinder < ItemsFinder
end

IIFinder::Base.lookup(InheritedItemsFinder)
#=> Item
```

### Scope for model

In case you want to call finder from model, include `IIFinder::Scope` into model as follows:

```ruby
class Item < ActiveRecord::Base
  include IIFinder::Scope
end

Item.finder_scope(name: 'NAME').to_sql
#=> SELECT "items".* FROM "items" WHERE "items"."name" = 'NAME'
```

### Logging

Finder supports instrumentation hook supplied by `ActiveSupport::Notifications`.
You can enable log subscriber as follows:

```ruby
IIFinder::LogSubscriber.attach_to :ii_finder
```

This subscriber will write logs in debug mode as the following example:

```
Called ItemsFinder with {:id=>1} (Duration: 9.9ms, Allocations: 915)
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_finder.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
