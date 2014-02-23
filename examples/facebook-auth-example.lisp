(defpackage oauth2.test.facebook-login
  (:use cl oauth2))

(in-package oauth2.test.facebook-login)

(defparameter *app-id* NIL
  "Facebook app ID.")

(defparameter *app-secret* NIL
  "6094834c1ef28e5fb73cf786ba4e807f"
  "Facebook app secret")

(defparameter *redirect-uri*
  NIL 
  )

(defparameter *redirect*
  (request-code
    "https://www.facebook.com/dialog/oauth"
    *app-id*
    :other `(("redirect_uri" . ,*redirect-uri*))))

(format t "Go to ~A and come back with the code: " *redirect*)
(defparameter *code* (read-line))

(defparameter *token*
  (request-token
   "https://graph.facebook.com/oauth/access_token"
   *code* 
   :redirect-uri *redirect-uri*
   :method :post
   :other `(("client_id" . ,*app-id*)
            ("client_secret" . ,*app-secret*))
   :token-parser 'oauth2:facebook-token->alist))

(format t "I got a token:~%~A~%" *token*)
