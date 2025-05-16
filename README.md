# Opiniated Emacs Org-Github-Review

Flow:

* insert a pullerquest `<C-enter>`
* open pullrequest `<f8>`


```org-mode
* TODO REVIEWS PROJECT
:PROPERTIES:
:ORG-GITHUB-REVIEW-OWNER: bit4bit
:ORG-GITHUB-REVIEW-REPO: org-github-review
:END:
** TODO (#1) test
:PROPERTIES:
:ORG-GITHUB-REVIEW-PULL-ID: 1
:END:
* Local variables
# local variables:
# eval: (org-github-review-mode)
# end:
```

# Installation

add to `.emacs`

```
(require 'org-github-review)

;; change for private repositories
(setq org-github-review--github-token nil)
```
