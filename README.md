# Pop!

A simple Erlang-like dialect that compiles to Erlang.
It also supports scripting that compiles to Erlang on the fly.
This is a toy dialect that I made for fun- you probably shouldn't use it.

## Usage

```bash
make
./pop <filename>
```

## Syntax
| Pop | Erlang Syntax |
|-----|--------------|
| {"main()", "main()"} | `main().` |
| {"-mod(", "-module("} | `-module(ModuleName).` |
| {"-export(", "-export("} | `-export([Function1/Arity1, Function2/Arity2]).` |
| {"io:", "io:"} | `io:format("Message").` |
| {"print(", "format("} | `io:format("~s ~n", [String]).` |
| {"exec(", "cmd("} | `os:cmd("Command").` |
| {"os:", "os:"} | `os:getenv("EnvironmentVariable").` |
