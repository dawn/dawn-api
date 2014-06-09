Dawn-API
========
API for [Dawn](https://github.com/dawn/dawn)

## Installation
```shell
gem install dawn-api
```

## Building
```shell
gem pack dawn-api.gem
```

## Documentation:
[API Docs](http://dawn.github.io/docs/)

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
my_app.update(name: "DawnIsAwesome")
my_app.gears.restart
```
