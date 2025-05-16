(require 'el-mock)
(require 'org-github-review)

;; UNIT
;; INTEGRATION
(ert-deftest github-pull--github-call-json>pull ()
  (with-mock
   (stub org-github-review--github-call => "{\"number\":9999,\"state\":\"open\",\"title\":\"Test\",\"locked\":true}")
   (should (equal
            '((number . 9999) (title . "Test"))
            (org-github-review--github-pull "github.com" "token" "myowner" "myrepo" "9999")))
   )
  )

;; ACCEPTANCE
;; MANUAL


(provide 'org-github-review-tests)

