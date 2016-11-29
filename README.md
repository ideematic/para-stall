# Para::Stall

This gems allows integration between the [Stall](https://github.com/rails-stall/stall)
e-commerce framework and the [Para](https://github.com/para-cms/para) content
management system.

This includes (or will include) default views and fields for handling carts,
products and other selling related tasks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'para-stall'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install para-stall

## Usage

This gem comes with the following components, some usable in the admin panel
others for the front.

A. Admin :
  1. [Variants matrix input](#1-variants-matrix-input)
  2. [Carts view](#2-carts-view)

B. Front :
  1. [Variants select](#1-variants-select)


## A. Admin

### 1. Variants matrix input

The `:variants_matrix` input allows to generate product variants based on
different properties. For example, a t-shirt product may belong to a color
and a size, and you'd like to generate all combinations of colors and sizes
for those products.

> **Note**: It's a [Simple Form](https://github.com/plataformatec/simple_form)
  input

The supported models architecture is the following :

- You have a product model, let's say `Product`
- It has many variants, of the name of your choice, and accepts nested attributes for that relation

```ruby
class Product < ActiveRecord::Base
  has_many :product_variants
  accepts_nested_attributes_for :product_variants, allow_destroy: true
end
```

- The variants model (here `ProductVariant`) belongs to some properties.

```ruby
class ProductVariant < ActiveRecord::Base
  belongs_to :color
  belongs_to :size
end
```

- The properties models are random models, here `Color` and `Size` and must
  define one the Para's supported name methods : `#name`, `#title` or
  `#admin_name`, as a model field or method.

- You have some entries in your properties models, to try the field out, don't
  forget to populate those models.


Now, when you generate the `Product`'s admin form, you need to add the following
`:product_variants` input :

```ruby
= form.input :product_variants, as: :variants_matrix, properties: [:color, :size], require_all_properties: true
```

The `:properties` param allows you to pass the different properties relations
that you want to use to generate your variants.

When set to `true`, the `:require_all_properties` param forces the user to
select at least one of each of the properties before the fields starts
generating combinations to create variants.

The form should display a field that'll allow you to select properties and
edit variants when they're generated.

### 2. Carts view

Add a CRUD component for yout carts, and use the provided `para/stall/admin/carts`
controller.

```ruby
component :carts, :crud, controller: '/para/stall/admin/carts'
```

Partials for the cart filters, table, and form are provided.
Also, nested fields partials are provided for the customer, addresses, shipment,
payment and line_item models.


## B. Front

### 3. Variants select


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/para-cms/para-stall.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

