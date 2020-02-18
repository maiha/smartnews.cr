SHELL=/bin/bash

WARNINGS := none

export UID = $(shell id -u)
export GID = $(shell id -g)

VERSION=
CURRENT_VERSION=$(shell git tag -l | sort -V | tail -1)
GUESSED_VERSION=$(shell git tag -l | sort -V | tail -1 | awk 'BEGIN { FS="." } { $$3++; } { printf "%d.%d.%d", $$1, $$2, $$3 }')

.SHELLFLAGS = -o pipefail -c

JSON2SCHEMA ?= bin/smartnews-dev

BUILD := docker-compose run --rm static shards build --link-flags "-static /v/libcurl.a"

all: smartnews-dev
release: release/smartnews

.PHONY: smartnews-dev
smartnews-dev:
	shards build $@

.PHONY: smartnews
smartnews:
	shards build $@ --release

.PHONY: release/smartnews
release/smartnews:
	@mkdir -p $(dir $@)
	$(BUILD) $(notdir $@) --release $(0)
	@cp -p bin/$(notdir $@) $@

JSONS   ?= $(wildcard json/smartnews/*.json)
PROTOS  ?= $(subst json,proto,$(JSONS))
CONVERTERS ?= $(addsuffix .cr,$(addprefix src/smartnews/converter/,$(basename $(notdir $(wildcard proto/smartnews/*.proto)))))

.PHONY: gen
gen: proto converter

.PHONY: converter
converter: $(CONVERTERS)

src/smartnews/converter/%.cr:proto/smartnews/%.proto $(JSON2SCHEMA)
	@if ! which "$(JSON2SCHEMA)" > /dev/null ; then echo "JSON2SCHEMA not set"; exit 1; fi
	$(JSON2SCHEMA) pb schema2converter $< "Smartnews::" > $@

proto/smartnews/%.proto:json/smartnews/%.json
	@if ! which "$(JSON2SCHEMA)" > /dev/null ; then echo "JSON2SCHEMA not set"; exit 1; fi
	$(JSON2SCHEMA) pb json2schema $< > $@

.PHONY: proto
proto: $(PROTOS)
	@mkdir -p src/proto
	protoc -I proto --crystal_out src/proto proto/*.proto
	@mkdir -p src/smartnews/proto
	PROTOBUF_NS=Smartnews::Proto protoc -I proto -I proto/smartnews --crystal_out src/smartnews/proto proto/smartnews/*.proto

.PHONY: ci
ci: test smartnews

.PHONY: test
test: check_version_mismatch spec

.PHONY: spec
spec:
	crystal spec -v --fail-fast

.PHONY : check_version_mismatch
check_version_mismatch: README.cr.md shard.yml 
	diff -w -c <(grep version: $<) <(grep ^version: shard.yml)

.PHONY : version
version:
	@if [ "$(VERSION)" = "" ]; then \
	  echo "ERROR: specify VERSION as bellow. (current: $(CURRENT_VERSION))";\
	  echo "  make version VERSION=$(GUESSED_VERSION)";\
	else \
	  sed -i -e 's/^version: .*/version: $(VERSION)/' shard.yml ;\
	  sed -i -e 's/^    version: [0-9]\+\.[0-9]\+\.[0-9]\+/    version: $(VERSION)/' README.md ;\
	  echo git commit -a -m "'$(COMMIT_MESSAGE)'" ;\
	  git commit -a -m 'version: $(VERSION)' ;\
	  git tag "v$(VERSION)" ;\
	fi

.PHONY : bump
bump:
	make version VERSION=$(GUESSED_VERSION) -s
