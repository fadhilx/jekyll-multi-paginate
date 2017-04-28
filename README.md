# Jekyll-Multi-Paginate

Welcome to jekyll-multi-paginate plugins. you may have found Jekyll pagination plugins before, but this plugins allows you to add pagination function to multiple Jekyll page. this also allow you to show only for same attribute


## Installation

There has Two ways to install this plugins to your jekyll pages

#### Method 1

1. Clone this repository
2. Copy `.rb` file into your `_plugins` folder
4. ready to initial

#### Method 2

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-multi-paginate'
```

And then execute:

    $ bundle

#### Method 3

Install it yourself as:

    $ gem install jekyll-multi-paginate

And then add `jekyll-multi-paginate` to your `plugins` or `plugins_dir` attribute in your `_config.yml` file.


## Usage

To initial your page as pagination page add attribute `paginate: ` to your specified page Front Matter attribute and set the value to maximum number of post for each pages

Here is the three attribute and its function that you can/need to add to your page Front Matter to make it works as you want

|Attributes			|Accepted Value/Type			|Function/Description	|
|-------------------|-------------------------------|-----------------------|
|`paginate`			|Maximum post(Number)			|Max post per page. this attribute will initial that page as pagination page and will give the `page` an attribute called `pagination`. Required to generate pagination page|
|`page_path`		|Url Patern(Path)				|will take the value as url format where `:num` is the pagination number. Default value: `/filname/page:num/`|
|`paginate_onlykey`	|Post stricted attribute(Atr)	|If set to value to any page attribute, the page will generate for post that contain that attribute with the same value only. Leave blank or set to `all` to generate for all post|

After you run add `paginate` to your page, this plugins will generate `.html` file for each page.

This attributes will stored under `page.pagination`:

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

## Examples - Basic
#### Structure
lets say that you have `10` posts and you add `paginate: 3` without `paginate_path` in `blog.html` Front Matter

```
.
├── _config.yml
├── _posts
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.md
|   ├── 2009-04-26-barcamp-boston-4-roundup.md
|   ├── 20010-05-28-barcamp-boston-5-roundup.md
|   !.. # 7 more posst
|
├── index.html
└── blog.html
```

#### Code
here is the example code that you can add to your page

```django
---
paginate: 3
---
<!-- post loop -->
{% for post in page.pagination.posts%}
   <div>
      <h4><a href="{{site.baseurl}}{{post.url}}">{{post.title}}</a></h4>
      <h5>{{post.date | date_to_string }} —</h5>
      <p class="postdesc">{{post.meta}}</p>
   </div>
{% endfor %}

<!-- post pagination -->
<div>
   {%if page.pagination.prev_path%}
      <a href="{{site.baseurl}}{{page.pagination.prev_path}}">Prev</a>
   {%else%}
      <span>Prev</span>
   {%endif%}
   {%if page.pagination.paginate_num>1%}
      {%for i in page.pagination.nums%}
         {%assign index = i | minus: 1%}
         {%if i==page.pagination.current_num%}
            <span>{{i}}</span>
         {%else%}
            <a href="{{site.baseurl}}{{page.pagination.paths[index]}}">{{i}}</a>
         {%endif%}
      {%endfor%}
   {%endif%}
   {%if page.pagination.next_path%}
      <a href="{{site.baseurl}}{{page.pagination.next_path}}">Next</a>
   {%else%}
      <span>Next</span>
   {%endif%}
</div>

```

#### Result
Code above will generate this structure for 10 posts with config `permalink: pretty`:
```
_site/
|
├── blog/
|   ├── index.html
|   ├── page1/
|   |   └── index.html	# have 3 posts
|   ├── page2/
|   |   └── index.html	# have 3 posts
|   ├── page3/
|   |   └── index.html	# have 3 posts
|   └── page4/
|       └── index.html	# have 1 posts
└── index.html
```

This structure for not set permalink:
```
_site/
|
├── blog/
|   ├── page1/
|   |   └── index.html	# have 3 posts
|   ├── page2/
|   |   └── index.html	# have 3 posts
|   ├── page3/
|   |   └── index.html	# have 3 posts
|   └── page4/
|       └── index.html	# have 1 posts
├── blog.html
└── index.html
```
## Examples - Paginate_onlykey
#### Structure
```
.
├── _config.yml
├── _posts
|   └──		# contain 5 post with attribute `lang: fr`, and 5 with `lang: en`
├── index.html
├── en.html
├── fr.html
├── en
|   └── blog.html
├── fr
|   └── blog.html
```

#### code
in fr/blog.html
```yaml
---
lang: fr
paginate: 3
paginate_onlykey: lang
---
<!-- any code-->
```

in fr/blog.html
```yaml
---
lang: en
paginate: 3
paginate_onlykey: lang
---
<!-- any code-->
```


#### Result
Code above will generate this structure for 10 posts with config `permalink: pretty`:
```
_site/
├── en/
|   ├── index.html
|   └── blog/
|       ├── index.html
|       ├── page1/
|       |   └── index.html	# have 3 posts with post.lang = en
|       ├── page2/
|           └── index.html	# have 2 posts with post.lang = en
├── fr/
|   ├── index.html
|   └── blog/
|       ├── index.html
|       ├── page1/
|       |   └── index.html	# have 3 posts with post.lang = fr
|       └── page2/
|           └── index.html	# have 2 posts with post.lang = fr
└── index.html
```
### Plugins on GitHub Pages
GitHub Pages is powered by Jekyll. However, all Pages sites are generated using the --safe option to disable custom plugins for security reasons. Unfortunately, this means your plugins won’t work if you’re deploying to GitHub Pages.

You can still use GitHub Pages to publish your site, but you’ll need to convert the site locally and push the generated static files to your GitHub repository instead of the Jekyll source files.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fadhilnapis/jekyll-multi-paginate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

