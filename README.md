[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/denispeplin/link_to_action)

# LinkToAction

Set of helpers: link_to_new, link_to_edit, link_to_destroy

Bonus helper: link_to_back

## Installation

Add this line to your application's Gemfile:

    gem 'link_to_action'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install link_to_action

## Usage

In general:

    link_to_{action} object, options
    
Per action:

    link_to_new MyModel
    link_to_edit @my_instance
    link_to_destroy @my_instance
    link_to_back

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
