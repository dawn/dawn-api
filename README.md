Dawn-API
========
API for [Dawn](https://github.com/dawn/dawn)

## Installation
```shell
gem install dawn-api
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
