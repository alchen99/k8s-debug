# Docker/K8 debugging tools

Containerized AWS CLI, kubectl, aws-iam-authenticator, curl, and jq on alpine to help with debugging K8s and containers.

## Build

```
docker build -t alchen99/k8s-debug .
```

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
