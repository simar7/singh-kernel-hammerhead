#!/bin/bash

# cleanup files
make clean
make mrproper

# also remove any deleted files, if any
if [ `git ls-files --deleted` ]
then
	git rm $(git ls-files --deleted) 
fi
