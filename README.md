# jsonrest-go

[![Go Reference](https://pkg.go.dev/badge/github.com/mbranch/jsonrest-go.svg)](https://pkg.go.dev/github.com/mbranch/jsonrest-go)
[![Go Report Card](https://goreportcard.com/badge/github.com/mbranch/jsonrest-go)](https://goreportcard.com/report/github.com/mbranch/jsonrest-go)

Package jsonrest implements a microframework for writing RESTful web
applications[^1].

Endpoints are defined as:

```go
func(ctx context.Context, req *jsonrest.Request) (interface{}, error)
```

If an endpoint returns a value along with a nil error, the value will be
rendered to the client as JSON.

If an error is returned, it will be sanitized and returned to the client as
json. Errors generated by a call to `jsonrest.Error(status, code, message)`
will be rendered in the following form:

```
{
    "error": {
        "message": message,
        "code": code
    }
}
```

along with the given HTTP status code.

If the error returned implements HTTPErrorResponse (i.e. has a `StatusCode() int` method), it will be marshaled as-is to the client with the provided status
code.
Any other errors will be obfuscated to the caller (unless `router.DumpError` is
enabled).

Example:

```go
func main() {
    r := jsonrest.NewRouter()
    r.Use(logging)
    r.Get("/", hello)
}

func hello(ctx context.Context, req *jsonrest.Request) (interface{}, error) {
    return jsonrest.M{"message": "Hello, world"}, nil
}

func logging(next jsonrest.Endpoint) jsonrest.Endpoint {
    return func(ctx context.Context, req *jsonrest.Request) (interface{}, error) {
        start := time.Now()
        defer func() {
            log.Printf("%s (%v)\n", req.URL().Path, time.Since(start))
        }()
        return next(ctx, req)
    }
}
```

[^1]:
    This repo is a copy (not a fork) of [github.com/deliveroo/jsonrest-go](https://github.com/deliveroo/jsonrest-go) which was
    deleted. It will be maintained separately from the original repo.
