smartnews for [Crystal](http://crystal-lang.org/).

- crystal: 0.33.0

### Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  smartnews:
    github: maiha/smartnews.cr
    version: 0.4.1
```

2. Run `shards install`

### example

```crystal
require "smartnews"

client = Smartnews::Client.new
client.auth = "123456789abcdef"
res = client.get("/api/v1.0/accounts")
puts res.body
```

## Development

### test

```console
$ make test
```

### build

```console
$ make smartnews
```
