#!/bin/bash

rebar3 compile
mkdir -p dist
BEAM_CONTENT=$(base64 _build/default/lib/pop/ebin/compiler.beam)

cat > dist/pop << EOF
#!/bin/bash
if ! command -v erl &> /dev/null; then
    if command apt -v &> /dev/null; then
        echo "Installing erlang..."
        sudo apt install erlang
    else
        echo "Error: Please install erlang"
        exit 1
    fi
fi
TEMP_DIR=\$(mktemp -d)
echo "$BEAM_CONTENT" | base64 -d > "\$TEMP_DIR/compiler.beam"
if [ \$# -ne 1 ]; then
    echo "Usage: pop <filename.pop>"
    exit 1
fi
FILE=\$1
if [ ! -f "\$FILE" ]; then
    echo "Error: File \$FILE does not exist"
    exit 1
fi
erl -noshell -pa "\$TEMP_DIR" -eval "compiler:compile_and_run(\"\$FILE\"), init:stop()."
rm -rf "\$TEMP_DIR"
EOF

chmod +x dist/pop
