#!/bin/bash
dub remove-local ../.
dub add-local ../.
dub build --force && mv testing /tmp/_testing && sudo /tmp/./_testing

# clean up
rm /tmp/_testing
