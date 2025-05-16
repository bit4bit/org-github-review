.PHONY: test
test:
	emacs --batch -L . -L tests -l org-github-review-tests.el -f ert-run-tests-batch
