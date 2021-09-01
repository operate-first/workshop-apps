#!/bin/sh

echo "Generating 'apps/devconf-us-2021/$1.yaml'"
cat <<EOM > apps/devconf-us-2021/$1.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: devconf-us-2021-$1
spec:
  project: workshops
  source:
    path: manifests/overlays/test
    repoURL: "https://github.com/$1/elyra-aidevsecops-tutorial.git"
    targetRevision: HEAD
    kustomize:
      namePrefix: $1-
  destination:
    namespace: elyra-aidevsecops-tutorial
    name: devconfus2021
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
    syncOptions:
      - Validate=false
EOM
