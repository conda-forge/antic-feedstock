#!/usr/bin/env bash
set -exo pipefail

chmod +x configure

export CFLAGS="$CFLAGS -funroll-loops -g -Wno-unknown-pragmas"

./configure --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX --with-flint=$PREFIX --disable-static
make -j${CPU_COUNT} AT= QUIET_CC= QUIET_CXX= QUIET_AR=
make install
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check -j${CPU_COUNT} || (cat test-suite.log; false)
fi
