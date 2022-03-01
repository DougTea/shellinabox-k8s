#!/bin/bash

set -ex

uri=$1

arr=($(/usr/bin/python2.7 -c "import urlparse;q=urlparse.parse_qs(urlparse.urlparse(\"$uri\").query);print q[\"namespace\"][0],q[\"pod\"][0],q[\"container\"][0];"))

namespace=${arr[1]}
pod=${arr[2]}
container=${arr[3]}

/usr/local/bin/kubectl -n $namespace exec $pod -it -c $container -- 'bash || sh'