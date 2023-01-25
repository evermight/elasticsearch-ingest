# PREQUISITES

These bash scripts require logstash.

# HOW TO SETUP

1. Copy `env.sample` to `.env`.
2. Update the values of `.env`.
3. Go `cd` to the directory of the `run.sh`.
4. Type `./run.sh` to run the program or run each file separately one at a time `./01-<filename>.sh`, `./02-<filename>.sh` etc...

# HOW TO TEARDOWN

1. Make sure your `.env` is up to date or look at step 1 and 2 of How to Setup
2. Go `cd` to the directory of the `teardown.sh`.
3. Type `./teardown.sh` to remove indices, policies and pipelines used by this project
