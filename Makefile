LOC_BIN = "C:\Users\xbl\AppData\Roaming\luarocks\bin\ldoc.bat"

docs:
	@# ldoc --all --dir docs src
	$(LOC_BIN) .

docs-with-config:
	$(LOC_BIN) --all --config docs/config.ld

markdown-docs:
	$(LOC_BIN) --all --verbose --dir docs --format markdown .

.PHONY: docs
