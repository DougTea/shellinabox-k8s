#!/bin/bash

set -e

if [ ! -z $DEBUG ]; then
  set -x
fi

uri=$1

arr=($(/usr/bin/python2.7 -c "import urlparse;q=urlparse.parse_qs(urlparse.urlparse(\"$uri\").query);print q[\"namespace\"][0],q[\"pod\"][0],q[\"container\"][0] if \"container\" in q else \"_\",q[\"command\"][0] if \"command\" in q else \"_\";"))

namespace=${arr[0]}
pod=${arr[1]}
container=${arr[2]}
cmd=${arr[3]}

COMMAND="/usr/local/bin/kubectl -n $namespace exec $pod -it"

if [ "$container" != "_" ];then
  COMMAND+=" -c $container"
else
  echo "No container specified,use first instead!"
fi

if [ "$cmd" = "_" ]; then
  echo "No command passed,trying to infer from container"
  if $COMMAND -- test -f /bin/bash &>/dev/null; then
    echo "'/bin/bash' found in container,use it"
    cmd="/bin/bash"
  elif $COMMAND -- test -f /bin/sh &>/dev/null; then
    echo "'/bin/sh' found in container,use it"
    cmd="/bin/sh"
  else
    echo "No available command found in container!Please specify a command!"
    exit 1
  fi
fi

COMMAND+=" -- $cmd"

exec $COMMAND
