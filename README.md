# Workshop apps

Repository of ArgoCD application for different workshops.

These applications are auto-deployed via ArgoCD into MOC clusters.

## Adding a new application as a participant

Edit the `ApplicationSet` manifest from `apps` folder named after the event you're attending, e.g. if you're attending DevConf US 2021, open `apps/devconf-us-2021.yaml`.

Add your Github username to the users list:

```yaml
spec:
    generators:
        - list:
              elements:
                  - user: some
                  - user: other
                  - user: attendees
                  ...
                  - user: MY_USERNAME
```

Commit and push to your fork of this repo and create a PR.
