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
| Pop Syntax        | Erlang Syntax      |
|-------------------|--------------------|
| `main()`          | `main()`           |
| `-mod()`          | `-module()`        |
| `-export()`       | `-export()`        |
| `io:`             | `io:`              |
| `print()`         | `format()`         |
| `exec()`          | `cmd()`            |
| `os:`             | `os:`              |
