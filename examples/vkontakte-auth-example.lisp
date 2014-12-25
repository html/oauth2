(defpackage oauth2.test.vkontakte-login
  (:use cl oauth2))

(in-package oauth2.test.vkontakte-login)

(defparameter *app-id* NIL
  "Vkontakte app ID.")

(defparameter *app-secret* NIL
  "Vkontakte app secret")

(defparameter *redirect-uri*
  NIL 
  )

(defparameter *redirect*
  (format nil
    "https://oauth.vk.com/authorize?client_id=~A&redirect_uri=~A"
    *app-id*
    (hunchentoot:url-encode *redirect-uri*)))

(format t "Go to ~A and come back with the code: " *redirect*)
(defparameter *code* (read-line))

(defparameter *token*
  (request-token
   "https://oauth.vk.com/access_token"
   *code* 
   :redirect-uri *redirect-uri*
   :method :post
   :other `(("client_id" . ,*app-id*)
            ("client_secret" . ,*app-secret*))
   :token-parser (lambda (item)
                      (let ((data (oauth2::parse-json item)))
                        (list* (cons :token--type "Bearer") data)))))

(format t "I got a token:~%~A~%" *token*)
