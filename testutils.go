package jsonrest

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
)

// NewTestRequest allows construction of a Request object with its internal
// members populated. This can be used to accomplish unit testing on endpoint handlers.
// This should only be used in test code.
func NewTestRequest(
	params httprouter.Params,
	req *http.Request,
	route string) Request {
	return Request{
		params: params,
		req:    req,
		route:  route,
	}
}
