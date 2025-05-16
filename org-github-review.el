(require 'org-github-reviewlib)

(defvar org-github-review--github-api-host "api.github.com")
(defvar org-github-review--github-host "github.com")
(defvar org-github-review--github-token nil)
(defvar org-github-review--keybind-insert-todo "<f8>")
(defvar org-github-review--keybind-browse-open "<f6>")

(defun org-github-review--org-entry-review-owner ()
  (org-entry-get nil "ORG-GITHUB-REVIEW-OWNER" t))

(defun org-github-review--org-entry-review-repo ()
  (org-entry-get nil "ORG-GITHUB-REVIEW-REPO" t))

(defun org-github-review-open-url--at-point ()
  "Open browser for current pull review."
  (interactive)
  (let ((owner (org-github-review--org-entry-review-owner))
        (repo (org-github-review--org-entry-review-repo))
        (number (org-entry-get nil "ORG-GITHUB-REVIEW-PULL-ID")))
    (browse-url (org-github-review--github-browser-url org-github-review--github-host owner repo number))))

(defun org-github-review-insert-from--at-point (pull-id)
  "Insert new pullrequest as TODO using PULL-ID."
  (interactive "sGITHUB PULLREQUEST: ")
  (let* ((owner (org-github-review--org-entry-review-owner))
         (repo (org-github-review--org-entry-review-repo))
         (pull (org-github-review--github-pull org-github-review--github-api-host
                                               org-github-review--github-token owner repo pull-id))
         (title (format "(#%s) %s" (alist-get 'number pull) (alist-get 'title pull)))
         )
    (org-insert-todo-heading-respect-content)
    (insert title)
    (org-entry-put nil "ORG-GITHUB-REVIEW-PULL-ID" pull-id)))


(define-minor-mode org-github-review-mode
  "Toggle org-github-review"
  :init-value nil
  :global nil
  :lighter "Org Github Review"
  :keymap
  '(
    ([C-return] . org-github-review-insert-from--at-point)
    ([f8] . org-github-review-open-url--at-point)
    )
)

(provide 'org-github-review)
