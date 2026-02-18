#!/bin/bash

git submodule foreach "git fetch || exit 0";
git fetch