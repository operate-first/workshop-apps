# Workshop apps

Repository of ArgoCD application for different workshops.

These applications are auto-deployed via ArgoCD into MOC clusters.

## Adding a new application as a participant

Please select the workshop folder named after the event you are attending and create an application resource in this folder. E.g. attendee of a workshop at ML Prague 2021 creates an application at `ml-prague-2021/application-name.yaml`. This application has to be a valid [ArgoCD application resource](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#applications):

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: <NAME> # <-- Change this to be unique
spec:
  project: workshops
  source:
    path: <PATH_WITHIN_REPO> # <-- Change this to point to manifests path in your repository
    repoURL: <YOUR_REPO_URL> # <-- Change this to your repository
    targetRevision: master
  destination:
    namespace: ws-ml-prague
    server: "https://kubernetes.default.svc"
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
    syncOptions:
      - Validate=false
```

Please list your resource file in the `kustomization.yaml` file in the workshop folder.

### Tests

OPA will test the `Application` for target namespace and ArgoCD project. Please ensure:

1. The application resource itself points to a valid repository.
2. The target repository manifests are buildable via kustomize/helm.
3. The application resource manifest is included in the `kustomization.yaml`.
