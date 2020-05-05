# Docker/K8 debugging tools

Container to help with debugging K8s and other containers. Some of the things configured are as follows:

* bash and bash-completion
* AWS CLI and aws-iam-authenticator
* kubectl with alias k defined
* curl, httpie
* jq
* mysql-client
* openldap-clients
* openssl
* screen
* vim and vimdiff

## Build

```
docker build -t alchen99/k8s-debug .
```

Automated build on Docker Hub

[![DockerHub Badge](http://dockeri.co/image/alchen99/k8s-debug)](https://hub.docker.com/r/alchen99/k8s-debug/)

## Usage

Configure:

```
export AWS_ACCESS_KEY_ID="<id>"
export AWS_SECRET_ACCESS_KEY="<key>"
export AWS_DEFAULT_REGION="<region>"
```

## References

* AWS CLI Docs: https://aws.amazon.com/documentation/cli/
* aws-iam-authenticator: https://github.com/kubernetes-sigs/aws-iam-authenticator
* kubectl: https://kubernetes.io/docs/reference/kubectl/overview/
* jq Manual: https://stedolan.github.io/jq/manual/
* jq Tutorial: https://stedolan.github.io/jq/tutorial/
