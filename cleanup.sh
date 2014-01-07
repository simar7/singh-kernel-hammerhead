#!/bin/bash

# cleanup files
make clean
make mrproper

# also remove any deleted files, if any
`git rm $(git ls-files --deleted) `
