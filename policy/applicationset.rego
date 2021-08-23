package main

deny[msg] {
	input.kind == "ApplicationSet"
	not input.spec.template.spec.project == "workshops"
	msg := "Application must use the 'workshops' project"
}

deny[msg] {
	input.kind == "ApplicationSet"
	not input.spec.template.spec.destination.namespace == null
	not startswith(input.spec.template.spec.destination.namespace, input.metadata.name)
	msg := concat("", ["Application resources must target the ", input.metadata.name, "-* namespaces only"])
}

has_key(obj, key) {
	_ = obj[key]
}

deny[msg] {
	input.kind == "ApplicationSet"
	not has_key(input.spec.template.spec.destination, "name")
	msg := "Application must be deployed to the cluster"
}

deny[msg] {
	input.kind == "ApplicationSet"
	has_key(input.spec.template.spec.destination, "server")
	msg := "Application must be deployed to the cluster via destination.name"
}

deny[msg] {
	not input.kind == "ApplicationSet"
	not input.kind == "Kustomization"

	msg := "This repo allows ApplicationSets only"
}
