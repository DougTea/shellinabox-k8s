#!/bin/bash

set -ex

uri=$1

arr=($(/usr/bin/python2.7 -c "import urlparse;q=urlparse.parse_qs(urlparse.urlparse(\"$uri\").query);print q[\"namespace\"][0],q[\"pod\"][0],q[\"container\"][0],q[\"command\"][0] if \"command\" in q else \"\";"))

namespace=${arr[0]}
pod=${arr[1]}
container=${arr[2]}
cmd=${arr[3]}

if [ -z $cmd ];then
  if /usr/local/bin/kubectl -n $namespace exec $pod -c $container -- test -f /bin/bash &> /dev/null
  then
    cmd="/bin/bash"
  elif /usr/local/bin/kubectl -n $namespace exec $pod -c $container -- test -f /bin/sh &> /dev/null
  then
    cmd="/bin/sh"
  else
    echo "No available command found in container!"
  fi
fi

exec /usr/local/bin/kubectl -n $namespace exec $pod -it -c $container -- $cmd