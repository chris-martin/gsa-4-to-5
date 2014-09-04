#!/bin/bash
cabal configure && cabal build && cabal run -- $@
