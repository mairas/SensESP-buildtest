#!/bin/sh

set -euxo pipefail

function clean_platformio {
    rm -rf ~/.platformio || true
    rm -rf .pio || true
}

function expect_success {
    if $1 ; then
        echo "Succeeded as expected"
    else
        echo "ERROR: should have succeeded"
        exit 1
    fi
}

function expect_fail {
    if $1 ; then
        echo "ERROR: should have failed"
        exit 1
    else
        echo "Failed as expected"
    fi
}

# Prerequisites: have PlatformIO CLI installed separately with:
# pip3 install platformio

#####
echo "first failure"

clean_platformio

expect_fail "pio run -e lolin_d32"

#####
echo "second failure"

clean_platformio

expect_fail "pio run -e esp32dev"

#####
echo "workaround: build a esp8266 platform version first"

clean_platformio

expect_success "pio run -e d1_mini"
expect_success "pio run -e esp32dev"
expect_success "pio run -e lolin_d32"

#####
echo "workaround fails if an esp32 build is attempted first"

clean_platformio

expect_fail "pio run -e esp32dev"
expect_success "pio run -e d1_mini"
expect_fail "pio run -e esp32dev"

echo "a lolin_d32 build hasn't been attempted yet, so it succeeds"

expect_success "pio run -e lolin_d32"
