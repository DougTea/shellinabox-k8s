FROM alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && apk update && apk add curl && curl -L -O https://dl.k8s.io/v1.8.0/kubernetes-client-linux-amd64.tar.gz && tar zvxf kubernetes-client-linux-amd64.tar.gz kubernetes/client/bin/kubectl && mv kubernetes/client/bin/kubectl / && rm -rf kubernetes && rm -f kubernetes-client-linux-amd64.tar.gz
ADD kubectl-proxy.sh /kubectl-proxy.sh
RUN chmod +x /kubectl-proxy.sh
ENTRYPOINT /kubectl-proxy.sh
