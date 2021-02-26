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
    path: manifests/overlays/test
    repoURL: $2
    targetRevision: HEAD
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

if ! [ -x "$(command -v kustomize)" ]; then
    grep -q "resources:" kustomization.yaml  || echo "resources:" >> kustomization.yaml
    grep -q "\- $1.yaml" kustomization.yaml  || echo "- $1.yaml" >> kustomization.yaml
else
    kustomize edit add resource $1.yaml
fi

popd
