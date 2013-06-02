Nikkou
======
Extract useful data from HTML and XML with ease!

Description
-----------

Nikkou adds additional methods to Nokogiri to make extracting commonly-used data from HTML and XML easier. It lets you transform HTML into structured data very quickly, and it integrates nicely with [Mechanize](https://github.com/sparklemotion/mechanize).

Method Overview
---------------

Here's a summary of the methods Nikkou provides (see "Methods" for details):

### Formatting

**parse_text** - Parses the node's text as XML and returns it as a Nokogiri::XML::NodeSet

**time(options={})** - Intelligently parses the time (relative or absolute) of either the text or a specified attribute; accepts a `time_zone` option

**url(attribute='href')** - Converts the href (or other specified attribute) into an absolute URL using the document's URI; `<a href="/p/1">Link</a>` yields `http://mysite.com/p/1`

### Searching

**attr_equals(attribute, string)** - Finds nodes where the attribute equals the string

**attr_includes(attribute, string)** - Finds nodes where the attribute includes the string
  
**attr_matches(attribute, pattern)** - Finds nodes where the attribute matches the pattern
  
**drill(*methods)** - Nil-safe method chaining
  
**find(path)** - Same as `search` but returns the first matched node

**text_equals(string)** - Finds nodes where the text equals the string
  
**text_includes(string)** - Finds nodes where the text includes the string
  
**text_matches(pattern)** - Finds nodes where the text matches the pattern

## Methods

### Formatting

#### time(options={})

Returns a Time object (in UTC) by automatically parsing the text or specified attribute of the node.

```ruby
# <a href="/p/1">3 hours ago</a>
doc.search('a').first.time
```

###### Options

`attribute`

The attribute to parse:

```ruby
# <a href="/p/1" data-published-at="2013-05-22 02:42:34">My link</a>
doc.search('a').first.time(attribute: 'data-published-at')
```

`time_zone`

The document's time zone (the time will be converted from that to UTC):

```ruby
# <a href="/p/1">3 hours ago</a>
doc.search('a').first.time(time_zone: 'America/New_York')
```

#### url(attribute='href')

Returns an absolute URL; useful for parsing relative hrefs. The document's `uri` needs to be set for Nikkou to know what domain to add to relative paths.

```ruby
# <a href="/p/1">My link</a>
doc.uri = 'http://mysite.com/mypage'
doc.search('a').first.url # "http://mysite.com/p/1"
```

If Mechanize is being used, the `uri` doesn't need to be manually set.

###### Options

`attribute`

The attribute to parse:

```ruby
# <a href="/p/1" data-comments-url="/p/1#comments">My Link</a>
doc.uri = 'http://mysite.com/mypage'
doc.search('a').first.url('data-comments-url') # "http://mysite.com/p/1#comments"
```

### Searching

#### attr_equals(attribute, string)

Selects nodes where the specified attribute equals the string.

```ruby
# <div data-type="news">My Text</div>
doc.attr_equals('data-type', 'news').first.text # "My Text"
```

#### attr_includes(attribute, string)

Selects nodes where the specified attribute includes the string.

```ruby
# <div data-type="major-news">My Text</div>
doc.attr_equals('data-type', 'news').first.text # "My Text"
```

#### attr_matches(attribute, pattern)

Selects nodes with an attribute matching a pattern. The pattern's matches are available in `Node#matches`.

```ruby
# <span data-tooltip="3 Comments">My Text</span>
doc.attr_matches('data-tooltip', /(\d+) comments/i).first.text # "My Text"
doc.attr_matches('data-tooltip', /(\d+) comments/i).first.matches # ["3 Comments", "3"]
```

#### drill(*methods)

Nil-safe method chaining. Replaces this:

```ruby
node = doc.find('.count')
if node
  attribute = node.attr('data-count')
  if attribute
    return attribute.to_i
  end
end
```

With this:

```ruby
return doc.drill([:find, '.count'], [:attr, 'data-count'], :to_i)
```

#### find(path)

Same as `search`, but returns the first matched node. Replaces this:

```ruby
nodes = node.search('h4')
if nodes
  return nodes.first
end
```

With this:

```ruby
return node.find('h4')
```

#### text_includes(string)

Selects nodes where the text includes the string.

```ruby
# <div data-type="news">My Text</div>
doc.text_includes('Text').first.text # "My Text"
```

#### text_matches(pattern)

Selects nodes with text matching a pattern. The pattern's matches are available in `Node#matches`.

```ruby
# <a href="/p/1">3 Comments</a>
doc.text_matches(/^(\d+) comments$/i).first.attr('href') # "/p/1"
doc.text_matches(/^(\d+) comments$/i).first.matches # ["3 Comments", "3"]
```

License
-------

Nikkou is released under the MIT License. Please see the MIT-LICENSE file for details.
