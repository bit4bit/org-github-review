(require 'url)

(defun org-github-review--github-browser-url (host owner repo number)
  (format "https://%s/%s/%s/pull/%s" host owner repo number ))

(defun org-github-review--github-call (host method path token)
  (let* ((url-request-method method)
         (url-request-data path)
         (url-request-extra-headers (if token (list (cons "Authorization" (concat "Bearer " token)))))
         )
    (with-current-buffer
        (url-retrieve-synchronously (concat "https://" host path))
      (goto-char (point-min))
      (search-forward-regexp "\n\n")
      (buffer-substring (point) (point-max)))))

(defun org-github-review--github-pull (host token owner repo pull-number)
  (let* (
         (github-url (format "/repos/%s/%s/pulls/%s" owner repo pull-number))
         (data (org-github-review--github-call host "GET"  github-url token))
         (response (json-parse-string data)))
    (if (gethash "status" response)
        (error (format "GITHUB RESPONSE: " (gethash "message" response)))
        (list (cons 'number (gethash "number" response))
              (cons 'title (gethash "title" response))
              )
        )
))

(provide 'org-github-reviewlib)
