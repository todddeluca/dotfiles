#!/bin/sh
{
  echo "MONIT-WRAPPER date"
  date
  echo "MONIT-WRAPPER env"
  env
  echo "MONIT-WRAPPER $@"
  $@
  R=$?
  echo "MONIT-WRAPPER exit code $R"
} >>/tmp/monit.log 2>&1

# http://stackoverflow.com/questions/3356476/debugging-monit
# usage in monit config file:
# start program = "/path/to/bin/monit-wrapper.sh my-real-start-script and args"
# stop program = "/path/to/bin/monit-wrapper.sh my-real-stop-script and args"