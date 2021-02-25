package main

deny[msg] {
    input.kind == "Application"
    input.spec.project != "workshops"

    msg := "Application must use the 'workshops' project"
}

deny[msg] {
    input.kind == "Application"
    not startswith(input.spec.destination.namespace, "workshop-")

    msg := "Application resources must target the 'workshop-*' namespaces only"
}

deny[msg] {
    input.kind == "Application"
    input.spec.destination.name == null

    msg := "Application must be deployed to the cluster"
}

deny[msg] {
    input.kind == "Application"
    input.spec.destination.server != null

    msg := "Application must be deployed to the cluster via destination.name"
}
