# DeepClassCompare

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/deep_class_compare`. To experiment with that code, run `bin/console` for an interactive prompt.

This is a container class extend gem that could compare the values class in it easily, clearly,and more colloquialism.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deep_class_compare'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install deep_class_compare

## Usage

```
    # Could compare container and value class with simple pattern
    ['string', 'string'].like_a? Array.of(String) => true
    [1, 2].like_a? Array.of(Hash) => false

    # Could compare nested value structure
    [['string'], ['string']].like_a? Array.of(Array).of(String) => true

    # Could match multiple classes within an array
    [1, 'string'].like_a? Array.of([String, Integer]) => true

    # Could compare key and value classes
    {symbol: 'string'}.like_a? Hash.of(Symbol, String) => true

    # Compare with more complicated nested condition
    {'string' => ['a', 'b', [1, 2, 3]]}.like_a? Hash.of(String, Array.of([String, Array.of(Integer)])) => true

    # See more in Rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/deep_class_compare. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/deep_class_compare/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DeepClassCompare project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/deep_class_compare/blob/master/CODE_OF_CONDUCT.md).
