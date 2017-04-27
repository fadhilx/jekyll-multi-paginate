# Jekyll::Multi::Paginate

Welcome to jekyll-multi-paginate plugins. you may have found Jekyll pagination plugins before, but this plugins allows you to add pagination function to multiple Jekyll page

## Installation

There has Two ways to install this plugins to your jekyll pages

#### Method 1

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-multi-paginate'
```

And then execute:

    $ bundle

**OR**

Install it yourself as:

    $ gem install jekyll-multi-paginate

And then, add this attribute to _config.yml

#### Method 2

1. Copy `.rb` file to your `_plugins` folder
2. To initial `paginate: ` to your specified page and set the value to maximum number of post for each pages
3. ready to use attribute that stored under `page.pagination`

## Usage

1. Three attribute and its function that you can/need to put to your page Front Matter to make it works as you want

|Attributes			|Accepted Value/Type			|Function/Description	|
|-------------------|-------------------------------|-----------------------|
|`paginate`			|Maximum post(Number)			|Max post per page. this attribute will initial that page as pagination page and will give the `page` an attribute called `pagination`. Required to generate pagination page|
|`page_path`		|Url Patern(Path)				|will take the value as url format where `:num` is the pagination number. Default value: `/filname/page:num/`|
|`paginate_onlykey`	|Post stricted attribute(Atr)	|If set to value to any page attribute, the page will generate for post that contain that attribute with the same value only. Leave blank or set to `all` to generate for all post|

2. This attributes will stored under `page.pagination`:

|Attributes		|Description												|
|---------------|-----------------------------------------------------------|
|`posts`		|list of post on that have in current page					|
|`nums`			|list of pagination number available. sorted by pagenumber	|
|`paths`		|list of pagination path that has been generated. sorted by pagenumber|
|`paginate_num`	|total pagination pages										|
|`paginate_path`|pagination link patern that has been set or generated(if not set)|
|`total_post`	|total post available in post list that only contain same attribute with you `paginate_onlykey` (if set)|
|`current_num`	|current post number index for each page					|
|`prev_path`	|previous page path											|
|`next_path`	|next page path												|
|`prev_num`		|previous page number										|
|`next_num`		|next page number											|

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll-multi-paginate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

