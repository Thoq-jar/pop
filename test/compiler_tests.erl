-module(compiler_tests).
-include_lib("eunit/include/eunit.hrl").

strip_shebang_test() ->
    Code = "#!/usr/bin/env pop\nHello",
    ?assertEqual("Hello", compiler:strip_shebang(Code)),
    ?assertEqual("Test", compiler:strip_shebang("Test")).

transformations_test() ->
    Code = "-mod(test).\n"
           "main() ->\n"
           "    io:print(\"test\").",
    Expected = "-module(test).\n"
               "main() ->\n"
               "    io:format(\"test\").",
    Result = compiler:apply_transformations(Code, compiler:transformations()),
    ?assertEqual(Expected, Result). 