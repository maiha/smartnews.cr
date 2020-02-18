# smartnews.cr [![Build Status](https://travis-ci.org/maiha/smartnews.cr.svg?branch=master)](https://travis-ci.org/maiha/smartnews.cr)

> [Setup](#Setup) | [api](#api) | [batch](#batch) | [pb](#pb) | [Lib](#lib)

Useful command line interface for [SmartNews](https://www.smartnews.com/ja/).
It consists of the following commands:

* **api** provides handy access to SmartNews API
* **batch** gets reports from SmartNews API and save to DB
* **pb** browses PB format intermediate data used in batch

## Setup

##### `smartnews`

Static Binary is ready for x86_64 linux
* https://github.com/maiha/smartnews.cr/releases

##### `.smartnewsrc`

You can generate config by `config sample`. Then, edit it about `api.access_token` and `clickhouse.*`.

```console
$ smartnews config sample > .smartnewsrc

$ vi .smartnewsrc
[api]
access_token = "123456789abcdef"
```

## api

`api` provides handly cli wrapper for the API.
`accounts` is a subcommand dedicated to calling the `/accounts` API.
This is useful for checking access key and config file.

```console
$ smartnews api accounts
```

Generally, use `get` subcommand. That allows all API access by specifying arbitrary PATH.

```console
$ smartnews api get '/api/v1.0/accounts/1000000/insights'
{
  "meta": {
    "updatedAt": "2020-02-19T11:00:00Z"
  },
  "data": [
    {
      "accountId": "1000000",
...
```

Parameters can be easily presented by `-d key=val`.
```console
$ smartnews api get '/api/v1.0/accounts/1000000/insights -d level=creative'
$ smartnews api get '/api/v1.0/accounts/1000000/insights -d level=creative -d date_preset=last_7_days'
```

`-n` provides powerful dryrun that builds curl command.
The `smartnews` can execute an API by itself because it incorporates an HTTP engine,
but it can also be used as a tool to generate curl commands.

```console
$ smartnews api get '/api/v1.0/accounts/1000000/insights -d level=creative' -n
curl -s -G \
     -H 'X-Auth-Api: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
     https://partners.smartnews-ads.com/api/v1.0/accounts/24270004/insights
```

## batch

The `batch` command provides an automatic reporting tool.
By simply specifying the date and executing it, you will get the performance report and save it in the DB.
This is suitable for running from cron.

```console
$ smartnews batch run yesterday
```

`run` is a meta-command that runs `recv`,`tsv` and `db` in order.
If you use DB other than ClickHouse, you can get TSV file by executing just `recv` and `tsv`.

```console
$ smartnews batch recv 2020-02-18
$ smartnews batch tsv  2020-02-18
$ ls -lh recv/20200218/report.tsv
-rw-r--r-- 1 maiha maiha 56K Feb 20 00:13 recv/20200218/report.tsv
```

##### <DATE>
- `today`, `yesterday`, `2019-12-31`, and any strings recognized by `date(1)`.

## pb

`batch` command creates temporary files in `recv/<DATE>` with Protobuf format.
`pb` command is a browser for it.

For example, `HttpCall` directory stores all HTTP tracing.

```console
$ smartnews pb count recv/20200218/HttpCall
47

$ smartnews pb list recv/20200218/HttpCall
[200] GET https://partners.smartnews-ads.com/api/v1.0/accounts
(...snip...)

$ smartnews pb tail -v recv/20200218/HttpCall
Row 47:
──────
  url          : "https://partners.smartnews-ads.com/api/v1.0/accounts/xxxxxxx/insights?level=creative&since=2020-02-18&until=2020-02-18"
  method       : "GET"
  header       : ""
  body         : ""
  requested_at : Datetime(2020-02-20 00:13:45 +09:00)
(...snip...)
```

## Usage (lib)

See [README.cr.md](./README.cr.md) when using as a crystal library.

## Contributing

1. Fork it (<https://github.com/maiha/smartnews.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) - creator and maintainer
