docs:
	@# ldoc --all --dir docs src
	ldoc .

docs-with-config:
	ldoc --all --config docs/config.ld

markdown-docs:
	ldoc --all --dir docs --format markdown src

.PHONY: docs
