#! /bin/bash

src_path="${1}"

cat "${src_path}" \
    | sed -e '/^#!/d' \
    | clisp -C -
