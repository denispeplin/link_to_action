[![Code Climate](https://codeclimate.com/github/denispeplin/link_to_action.png)](https://codeclimate.com/github/denispeplin/link_to_action)
[![Build Status](https://secure.travis-ci.org/denispeplin/link_to_action.png)](http://travis-ci.org/denispeplin/link_to_action)
[![Gem Version](https://fury-badge.herokuapp.com/rb/link_to_action.png)](http://badge.fury.io/rb/link_to_action)

# LinkToAction

Set of helpers: link_to_new, link_to_index, link_to_show, link_to_edit, link_to_destroy

Bonus helper: link_to_back

Demo application sources with Twitter Bootstrap enabled: [link_to_action_demo](https://github.com/denispeplin/link_to_action_demo)

Want to use this gem with [Zurb Foundation](http://foundation.zurb.com/)? Make a
[feature request](https://github.com/denispeplin/link_to_action/issues).

## Why

Rails scaffold-generated links are not DRY, and it becomes even worse,
when someone tries to make them I18n-friendly (they are not by default).

If you have twitter-bootstrap installed, and want to make your links look like
a buttons, there will be another addition, 'class' option. To make these buttons
really pretty, you will also need icons.

So how I18n-friendly button-style link with icon looks like in a view code?
Well, it can look like this:

```erb
<%= link_to raw("<i class=\"icon-edit\"></i> #{t(:edit)}"), edit_comment_path(@comment), class: 'btn' %>
```

And scaffolded code was:

```erb
<%= link_to 'Edit', edit_comment_path(@comment) %>
```

Even in simple scaffolded link words 'edit' and 'comment' was repeated twice.
In the more complex example word 'edit' was written three times.

Using `link_to_action` gem, you can avoid those duplications completely:

```erb
<%= link_to_edit @comment %>
```

That's all for this link, but not all for this gem. It is configurable, it can be
tuned up to suit other than twitter-bootstrap CSS frameworks (which is off by
default anyway), and it even can take advantage of cancan's abilities.

## When

This gem is especially useful when an application contains many similar-looking
links. Many global and link-specific options are exists, so this gem is flexible.
And you still have `link_to` if you want some link to look really simple!

## Installation

Add this line to your application's Gemfile:

    gem 'link_to_action'

And then execute:

    $ bundle

Add initializer, locale file and templates. Note that CSS classes, icons and
cancan are disabled by default. To leave it as it is, just run:

    $ rails generate link_to_action:install

Edit `config/initializers/link_to_action.rb` to change some options. The list of
options with defaults provided below.

To install `link_to_action` with Twitter Bootstrap and icons enabled, run:

    $ rails generate link_to_action:install --bootstrap

## Usage

In general:

    link_to_{action} object, options
    
Per action, with commented-out link_to equivalents (no CSS or icons, just to
keep it simple):

```ruby
link_to_new MyModel # link_to 'New MyModel', new_my_model_path
link_to_index MyModel # link_to 'My Models', my_models_path
link_to_show @my_model # link_to @my_model.name, my_model_path(@my_model)
link_to_edit @my_model # link_to 'Edit MyModel', edit_my_model_path(@my_model)
link_to_destroy @my_model # link_to 'Delete MyModel', my_model_path(@my_model),
# method: :delete, data: { confirm: 'Are you sure?' }
link_to_back # link_to :back
```

`link_to_show` tries some methods (by default :name and :to_s) to get
name for the link. This can be changed by specifying `i18n` option. Other
helpers use I18n to get link names unless `name` option specified.

## I18n

`link_to_action` comes with I18n preconfigured, nested in `helpers.link_to`
section. Custom (or localized) model names can be added to `activerecord.models`
section.

```yml
en:
  activerecord:
    models:
      my_model: 'My Awesome Model'
  helpers:
    link_to:
      new: 'New %{model}'
      show: 'Show %{model}'
      index: 'All %{model}'
      edit: 'Edit %{model}'
      destroy: 'Delete %{model}'
      destroy_confirm: 'Are you sure?'
      back: 'Back'
```

`%{model}` variables are not used by default for `show`, `edit`, and `destroy`.

## Global CSS styles, icons, and other options

Default options are:

```ruby
use_cancan = false # overwrite this to use cancan
use_icons = false # overwrite this to use FontAwesome icons
icons_place_left = true
icons_size = 'large'
icon_new = 'plus'
icon_index = ''
icon_edit = 'edit'
icon_destroy = 'trash'
icon_back = 'undo'
use_classes = false # overwrite this to use Twitter Bootstrap classes
classes_append = false
class_default = 'btn'
class_new = 'btn-primary'
class_index = ''
class_edit = nil
class_destroy = 'btn-danger'
class_back = nil
size_class_default = nil
size_class_large = 'btn-large'
size_class_small = 'btn-small'
size_class_mini = 'btn-mini'
show_methods = [ :name, :to_s ]
destroy_confirm = true
destroy_skip_pjax = false # overwrite this if pjax is used
```
Look to `config/initializers/link_to_action.rb` for detailed descriptions.

## Per-link options

```ruby
:name # overwrites default name of the link
:class # overwrites or appends class list
:size # size of the button-like link
:params # hash for to polymorphic_path, see examples
:icon # Font-Awesome icon
:icon_size # Size of icon
:icon_swap # Swap default position of icon left-right
```

`link_to_destroy` options:
```ruby
:confirm # true/false or some text per-link basis
```

`link_to_show` options:
```ruby
:name # overwrites default name of the link
:send # method to send to object to get name
:raw # method to send to object to get name, output raw
:i18n # if `i18n: true` is set, I18n name is displayed
```

## Examples

```ruby
# Link with parameters
link_to_new Comment, params: {user_id: 1} # /comments/new?user_id=1

# Nested link
link_to_new [ @user, Comment ] # /users/1/comments/new
```

## TODO

1. Better testing.
2. Improve README, add more examples.
3. Add templates for Zurb Foundation.
4. Whitespace fix in templates.

## Credits

This gem was heavily inspired by Platformatec's
[show_for](https://github.com/plataformatec/show_for) and
[simple_form](https://github.com/plataformatec/simple_form) gems. Some code
samples were taken from these gems.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
