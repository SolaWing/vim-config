#!/bin/bash
ls ~/.vim/view | xargs -I ! sed -i "" -e '/^lcd/D' ~/.vim/view/'!'
