#!/bin/sh
if [ $# -le 1 ] || [ "$#" == "--help" ] || [ "$#" == "-h" ]; then
    echo "Create the Application resource."
    echo -e "\nUsage: $0 username repository_url\n"
    echo
    echo "Arguments:"
    echo "username          Your Openshift username"
    echo "repository_url    Path to your fork of the workshop repository. Url in format https://github.com/username/repo.git"
    exit 0
fi

pushd $(dirname $0)
cat <<EOF > $1.yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: $1
spec:
  project: workshops
  source:
    path: manifests
    repoURL: $2
    targetRevision: master
  destination:
    namespace: workshop-$1
    name: ml-prague-workshop
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
    syncOptions:
      - Validate=false
EOF

kustomize edit add resource $1.yaml

popd
