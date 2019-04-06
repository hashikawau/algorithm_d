#! /bin/bash

orig_src_path="${1}"
tmp_src_path=/tmp/tmp.cpp
tmp_exe_path=/tmp/tmp.exe

sed '/^#!/d' ${orig_src_path} > ${tmp_src_path} \
    && g++ -o ${tmp_exe_path} ${tmp_src_path} \
    && ${tmp_exe_path} \
    && rm ${tmp_src_path} ${tmp_exe_path}

