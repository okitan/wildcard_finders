# wildcard_finders [![Build Status](https://secure.travis-ci.org/okitan/wildcard_finders.png?branch=master)](http://travis-ci.org/okitan/wildcard_finders) [![Dependency Status](https://gemnasium.com/okitan/wildcard_finders.png)](https://gemnasium.com/okitan/wildcard_finders)

For people struggling with non-semantic html.

## Installation

Add this line to your application's Gemfile:

```sh
gem 'wildcard_finders'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install wildcard_finders
```

## Usage

```ruby
it "can find image using regexp" do
  page.find_img_like :src => /\.png$/ # => <Capybara::Node> # first img tag which is png

  page.should have_img_like    :src => /\.jpg$/ # => expect at least one img tag of jpg
  page.should have_no_img_like :src => /\.bmp$/ # => expect no img tag of bmp
end
```

See WildcardFinders::Finders::METHODS for ohter available finders.
Every finder has automatically have matchers: both has_xxx_like? and has_no_xxx_like?.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
