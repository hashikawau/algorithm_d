#! /bin/bash

src_path="${1}"

node -e "$(sed -e '/^#!/d' ${src_path})"

