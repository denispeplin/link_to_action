[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/denispeplin/link_to_action)
[![Build Status](https://secure.travis-ci.org/denispeplin/link_to_action.png)](http://travis-ci.org/denispeplin/link_to_action)

# LinkToAction

Set of helpers: link_to_new, link_to_show, link_to_edit, link_to_destroy

Bonus helper: link_to_back

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
In more complex example word 'edit' was written three times.

Using link_to_action gem, you can avoid those duplication completely:

```erb
<%= link_to_edit @comment %>
```

That's all for this link, but not all for this gem. It configurable, it can be
tuned up to suit other than twitter-bootstrap CSS frameworks (which is off by
default anyway), and it even can take advantage of cancan's abilities.

## When

This gem is especially useful when application contains many simular-looking
links. Many global and link-specific options are exists, so this gem is flexible.
And you still have link_to if you want some link to look really simple!

## Installation

Add this line to your application's Gemfile:

    gem 'link_to_action'

And then execute:

    $ bundle

Add initializer and locale file:

    $ rails generate link_to_action:install

Edit `config/initializers/link_to_action.rb`. Note that CSS classes, icons and
cancan are disabled by default.

## Usage

In general:

    link_to_{action} object, options
    
Per action, with commented-out link_to equivalents:

```ruby
link_to_new MyModel # link_to 'New MyModel', new_my_model_path
link_to_show @my_model # link_to @my_model.name, my_model_path(@my_model)
link_to_edit @my_model # link_to 'Edit MyModel', edit_my_model_path(@my_model)
link_to_destroy @my_model # link_to 'Delete MyModel', my_model_path(@my_model),
# method: :delete, data: { confirm: 'Are you sure?' }
link_to_back # link_to :back
```

`link_to_show` tries some methods (by default :name, :title, and :to_s) to get
name for the link. Other helpers uses I18n to get link names.

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
      edit: 'Edit %{model}'
      destroy: 'Delete %{model}'
      destroy_confirm: 'Are you sure?'
      back: 'Back'
```

## Global CSS styles, icons, and other options

Default options are:

```ruby
config.use_cancan = false
config.use_icons = false
config.icons_place_left = true
config.icons_size = 'large'
config.icon_new = 'plus'
config.icon_edit = 'edit'
config.icon_destroy = 'trash'
config.icon_back = 'undo'
config.use_classes = false
config.classes_append = false
config.class_default = 'btn'
config.class_new = 'btn-primary'
config.class_edit = nil
config.class_destroy = 'btn-danger'
config.class_back = nil
config.size_class_default = nil
config.size_class_large = 'btn-large'
config.size_class_small = 'btn-small'
config.size_class_mini = 'btn-mini'
config.show_methods = [ :name, :title, :to_s ]
```
Look to `config/initializers/link_to_action.rb` for detailed description.

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

`link_to_show` options:
```ruby
:name # overwrites default name of the link
:send # method to sent to object to get name
```

## Examples

```ruby
# Link with parameters
link_to_new Comment, params: {user_id: 1} # /comments/new?user_id=1

# Nested link
link_to_new [ @user, Comment ] # /users/1/comments/new
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
