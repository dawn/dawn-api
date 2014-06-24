Dawn-API
========
[![Dependency Status](https://gemnasium.com/dawn/dawn-api.svg)](https://gemnasium.com/dawn/dawn-api)
[![Gem Version](https://badge.fury.io/rb/dawn-api.svg)](http://badge.fury.io/rb/dawn-api)
[![Code Climate](https://codeclimate.com/github/dawn/dawn-api.png)](https://codeclimate.com/github/dawn/dawn-api)
[![Inch-CI](http://inch-ci.org/github/dawn/dawn-api.png?branch=master)](http://inch-ci.org/github/dawn/dawn-api)

Ruby [API](https://github.com/dawn/dawn-api) for [Dawn](https://github.com/dawn/dawn)

## Installation
```shell
gem install dawn-api
```

## Building
```shell
gem pack dawn-api.gem
```

## Documentation:
[Rubydoc](http://rubydoc.info/gems/dawn-api)

[API Reference](http://dawn.github.io/docs/)

## Influential ENV variable
| VAR           | API default   | Description                                                |
| ------------- | ------------- | ---------------------------------------------------------- |
| DAWN_HOST     | dawn.dev      | Main hostname                                              |
| DAWN_SCHEME   | http          |                                                            |
| DAWN_API_HOST | api.dawn.dev  | Dawn API hostname, if not given, api.$DAWN_HOST is used    |
| DAWN_GIT_HOST | dawn.dev      | Target for git push dawn, if not given, $DAWN_HOST is used |
| DAWN_LOG_HOST | dawn.dev:8001 | Dawn logs hostname, if not given, $DAWN_HOST:8001 is used  |

## What is this?
This is the ruby API interface for [Dawn](https://github.com/dawn/dawn),
- It is not a standalone gem.
- It requires a dawn server.
- It is not a CLI, look at [Dawn-CLI](https://github.com/dawn/dawn-cli) instead

## Usage
One day I'll write this properly, however for now:

```ruby
Dawn.authenticate
my_app = Dawn::App.create
my_app.domains.all
my_app.gears.restart
```
