package main

deny[msg] {
	input.kind == "Application"
	not input.spec.project == "workshops"
	msg := "Application must use the 'workshops' project"
}

has_key(obj, key) {
	_ = obj[key]
}

deny[msg] {
	input.kind == "Application"
	not has_key(input.spec.destination, "name")
	msg := "Application must be deployed to the cluster"
}

deny[msg] {
	input.kind == "Application"
	has_key(input.spec.destination, "server")
	msg := "Application must be deployed to the cluster via destination.name"
}

deny[msg] {
	not input.kind == "Application"

	msg := "This repo allows Application only"
}
