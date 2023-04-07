#!/usr/bin/env bash

export KEYBASE_DEBUG=1

# Start keybase service.
keybase -debug -use-default-log-file service &

# Start kbfs service (without fuse mount).
kbfsfuse -debug -log-to-file -mount-type=none &

# Wait a few seconds for services to start.
keybase ctl wait --include-kbfs

# Keep the detached container running (since there are no other foregroud
# processes running). Run `docker attach keybase-daemon` to see logs.
tail -F \
  /root/.cache/keybase/keybase.service.log \
  /root/.cache/keybase/keybase.kbfs.log
