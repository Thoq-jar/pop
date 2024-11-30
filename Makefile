.PHONY: all test clean

all: clean
	rebar3 compile
	./build.sh

test: clean
	rebar3 eunit

clean:
	rebar3 clean
	rm -rf dist/* 