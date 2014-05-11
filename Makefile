
REBAR?=./rebar

.PHONY: all clean deps compile xref doc test

all: compile

deps:
	$(REBAR) get-deps

clean:
	$(REBAR) clean -r

compile:
	$(REBAR) compile

xref:
	$(REBAR) xref skip_deps=true

doc:
	@rm -rf README.md doc/edoc-info doc/*.md
	$(REBAR) -C rebar.config.doc get-deps compile
	$(REBAR) -C rebar.config.doc doc skip_deps=true

test:
	(cd ebin; erl -pz ../deps/ubf/ebin \
		-s hello_world_example setup \
		-s hello_world_example run \
		-s hello_world_example teardown \
		-s erlang halt \
	)
