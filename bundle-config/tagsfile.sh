#!/usr/bin/env bash
# exec 1> >(tee /tmp/tagsfile.log)
if [ -e .vim/tagsfile.sh ]; then
    # prefer local version
    source .vim/tagsfile.sh
else
    git ls-files
    git ls-files --others --exclude-standard
fi

