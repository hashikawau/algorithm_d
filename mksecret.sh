#! /bin/bash

mkdir -p /tmp/secret
zip -r -b /tmp/secret -e secret.bin \
    secret/.classpath \
    secret/.project \
    secret/.settings \
    secret/erd.a5er \
    secret/pom.xml \
    secret/README.txt \
    secret/run_script \
    secret/src

