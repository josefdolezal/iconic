#!/bin/bash

if [[ ! -z $TRAVIS_TAG ]]; then
  echo "-- Running release action --"
  make VERSION="$TRAVIS_TAG" release
else
  echo "-- Running build action --"
  make build
fi
