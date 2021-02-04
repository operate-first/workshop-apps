package main

deny[msg] {
    input.kind == "Application"
    input.spec.project != "workshops"

    msg := "Application must use the 'workshops' project"
}

deny[msg] {
    input.kind == "Application"
    not startswith(input.spec.destination.namespace, "ws-")

    msg := "Application resources must target the 'ws-*' namespaces only"
}
