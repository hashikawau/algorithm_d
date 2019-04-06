#! /bin/bash

orig_src_path="${1}"
tmp_src_path=/tmp/tmp.java
tmp_build_dir_path=/tmp/java/

case "$(uname)" in
    CYGWIN*)
        orig_src_path=$(cygpath -w ${orig_src_path})
        tmp_src_path=$(cygpath -w ${tmp_src_path})
        tmp_build_dir_path=$(cygpath -w ${tmp_build_dir_path})
        ;;
    *);;
esac

sed '/^#!/d' ${orig_src_path} > ${tmp_src_path} \
    && mkdir -p ${tmp_build_dir_path} \
    && javac -d ${tmp_build_dir_path} ${tmp_src_path} \
    && java -cp ${tmp_build_dir_path} Main \
    && rm -rf ${tmp_src_path} ${tmp_build_dir_path}

