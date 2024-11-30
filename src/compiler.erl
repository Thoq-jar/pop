-module(compiler).
-export([
    compile_and_run/1,
    strip_shebang/1,
    transformations/0,
    apply_transformations/2
]).

transformations() ->
    [
        {"main()", "main()"},
        {"-mod(", "-module("},
        {"-export(", "-export("},
        {"io:", "io:"},
        {"print(", "format("},
        {"exec(", "cmd("},
        {"os:", "os:"}
    ].

compile_and_run(Filename) ->
    case file:read_file(Filename) of
        {ok, Content} ->
            SourceCode = binary_to_list(Content),
            CleanCode = strip_shebang(SourceCode),
            ErlangCode = apply_transformations(CleanCode, transformations()),
            TempFile = filename:rootname(Filename) ++ ".erl",
            ok = file:write_file(TempFile, list_to_binary(ErlangCode)),
            ModuleName = list_to_atom(filename:basename(Filename, ".pop")),
            compile:file(TempFile),
            file:delete(TempFile),
            ModuleName:main();
        {error, Reason} ->
            {error, Reason}
    end.

strip_shebang(Code) ->
    case string:split(Code, "\n") of
        [<<"#!", _/binary>>, Rest] -> Rest;
        [FirstLine | Rest] ->
            case string:prefix(FirstLine, "#!") of
                nomatch -> Code;
                _ -> string:join(Rest, "\n")
            end;
        _ -> Code
    end.

apply_transformations(Code, []) ->
    Code;
apply_transformations(Code, [{From, To}|Rest]) ->
    TransformedCode = lists:flatten(string:replace(Code, From, To, all)),
    apply_transformations(TransformedCode, Rest).
