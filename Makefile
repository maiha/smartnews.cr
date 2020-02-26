SHELL=/bin/bash

.SHELLFLAGS = -o pipefail -c

all: smartnews-dev

######################################################################
### compiling

# for mounting permissions in docker-compose
export UID = $(shell id -u)
export GID = $(shell id -g)

COMPILE_FLAGS=-Dstatic
BUILD_TARGET=

ON_ALPINE=docker-compose run --rm alpine

.PHONY: build
build:
	@$(ON_ALPINE) shards build $(COMPILE_FLAGS) --link-flags "-static" $(BUILD_TARGET) $(O)

.PHONY: smartnews-dev
smartnews-dev: BUILD_TARGET=smartnews-dev
smartnews-dev: build

.PHONY: smartnews
smartnews: BUILD_TARGET=--release smartnews
smartnews: build

.PHONY: console
console:
	@$(ON_ALPINE) sh

######################################################################
### testing

.PHONY: ci
ci: check_version_mismatch test smartnews

.PHONY: test
test: spec

.PHONY: spec
spec:
	@$(ON_ALPINE) crystal spec $(COMPILE_FLAGS) -v --fail-fast

.PHONY: check_version_mismatch
check_version_mismatch: README.cr.md shard.yml
	diff -w -c <(grep version: $<) <(grep ^version: shard.yml)

######################################################################
### generating

GENERATOR  ?= bin/smartnews-dev
JSON_FILES ?= $(wildcard json/smartnews/*.json)
CONVERTERS ?= $(addsuffix .cr,$(addprefix src/smartnews/converter/,$(basename $(notdir $(wildcard proto/smartnews/*.proto)))))

.PHONY: gen
gen: proto converter

.PHONY: converter
converter: $(CONVERTERS)

src/smartnews/converter/%.cr:proto/smartnews/%.proto $(GENERATOR)
	@if ! which "$(GENERATOR)" > /dev/null ; then echo "GENERATOR not set"; exit 1; fi
	$(GENERATOR) pb schema2converter $< "Smartnews::" > $@

proto/smartnews/%.proto:json/smartnews/%.json
	@if ! which "$(GENERATOR)" > /dev/null ; then echo "GENERATOR not set"; exit 1; fi
	$(GENERATOR) pb json2schema $< > $@

.PHONY: proto
proto: $(subst json,proto,$(JSON_FILES))
	@mkdir -p src/proto
	protoc -I proto --crystal_out src/proto proto/*.proto
	@mkdir -p src/smartnews/proto
	PROTOBUF_NS=Smartnews::Proto protoc -I proto -I proto/smartnews --crystal_out src/smartnews/proto proto/smartnews/*.proto

######################################################################
### versioning

VERSION=
CURRENT_VERSION=$(shell git tag -l | sort -V | tail -1)
GUESSED_VERSION=$(shell git tag -l | sort -V | tail -1 | awk 'BEGIN { FS="." } { $$3++; } { printf "%d.%d.%d", $$1, $$2, $$3 }')

.PHONY : version
version:
	@if [ "$(VERSION)" = "" ]; then \
	  echo "ERROR: specify VERSION as bellow. (current: $(CURRENT_VERSION))";\
	  echo "  make version VERSION=$(GUESSED_VERSION)";\
	else \
	  sed -i -e 's/^version: .*/version: $(VERSION)/' shard.yml ;\
	  sed -i -e 's/^    version: [0-9]\+\.[0-9]\+\.[0-9]\+/    version: $(VERSION)/' README.cr.md ;\
	  echo git commit -a -m "'$(COMMIT_MESSAGE)'" ;\
	  git commit -a -m 'version: $(VERSION)' ;\
	  git tag "v$(VERSION)" ;\
	fi

.PHONY : bump
bump:
	make version VERSION=$(GUESSED_VERSION) -s
