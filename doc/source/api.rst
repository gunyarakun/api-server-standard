.. vim: set expandtab ts=2 sw=2 nowrap ft=rst fenc=utf-8 ff=unix :

API specification
=================

Response
--------

All responses are returned in JSON. But some internal errors are responded when HTTP header 'Accept' contains 'text/html' and the server runs in debug mode.

.. http:response:: JSON Response

  All responses are returned in the same format.

  .. code-block:: js

    {
      "response_code": HTTP_RESPONSE_CODE,
      "message": ERROR_MESSAGE,
      "more_info": ERROR_DETAIL_URL,
      "code": ERROR_CODE
      "body": RESPONSE_BODY
    }

  :data string HTTP_RESPONSE_CODE: HTTP Response code. Exists only when a parameter 'supress_response_codes' is true. NOTE: not number, string.
  :data string ERROR_MESSAGE: Error message. The message are written in the language specified by HTTP request header 'Accept-Language'.
  :data string ERROR_DETAIL_URL: URL for more details about the error.
  :data string ERROR_CODE: Error code on the application domain.
  :data Object RESPONSE_BODY: Response body.

.. http:response:: Error stacktrace

  Error stack trace written in HTML.

.. http:response:: Single user response

  Response body for a single user is below.

  .. code-block:: js

    {
      "id": USER_ID,
      "name": USER_NAME
    }

  :data integer USER_ID: id number for user
  :data string USER_NAME: name of user

.. http:response:: Multiple user response

  Response body for multiple users is below.

  .. code-block:: js

    [
      ['id', 'name'],
      [USER_ID_1, USER_NAME_1],
      ...
    ]

  :data integer USER_ID_1: id number for the first user
  :data string USER_NAME_1: name of the first user

users
-----

.. http:method:: POST /v1/users[.json]?name&supress_response_codes
  :label-name: v1-users-post
  :title: API Users POST

  :param string name: new user name
  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.
  :response 200: create successfully.
  :response 400: required parameters not exists.

.. http:method:: GET /v1/users[.json]?fields&orderby&offset&limit&method&supress_response_codes

  :optparam string fields: columns contained in response
  :optparam string orderby: sort key
  :optparam integer offset: pager offset
  :optparam integer limit: pager limit
  :optparam string method: if 'post', :http:method:`v1-users-post`. if 'delete', :http:method:`v1-users-delete`.
  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.

  :response 200: list successfully.

.. http:method:: DELETE /v1/users[.json]?supress_response_codes
  :label-name: v1-users-delete
  :title: API Users DELETE

  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.
  :response 200: delete all users successfully.

.. http:method:: GET /v1/users/{user_id}[.json]?method&supress_response_codes

  Show the user.

  :optparam integer user_id: user_id
  :optparam string method: if 'put', :http:method:`v1-user-put`. if 'delete', :http:method:`v1-user-delete`.
  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.

  :response 200: list successfully.
  :response 404: no user found.

.. http:method:: PUT /v1/users/{user_id}[.json]?name&supress_response_codes
  :label-name: v1-user-put
  :title: API User PUT

  If exists update the user.
  If not error.

  :optparam integer user_id: user_id
  :optparam string name: user name
  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.

  :response 200: list successfully.
  :response 404: no user found.

.. http:method:: DELETE /v1/users/{user_id}[.json]?supress_response_codes
  :label-name: v1-user-delete
  :title: API User DELETE

  Delete the user.

  :optparam integer user_id: user_id
  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.

  :response 200: list successfully.
  :response 404: no user found.

.. http:method:: GET /v1/users/count[.json]?supress_response_codes

  Returns user count.

  :optparam boolean supress_response_codes: returns response with code 200 always. The response code is in the response body.

  :response 200: count successfully.
