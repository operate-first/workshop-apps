package main

empty(value) {
	count(value) == 0
}

no_violations {
	empty(deny)
}

test_allow {
	input := {
		"kind": "ApplicationSet",
		"metadata": {"name": "a"},
		"spec": {"template": {"spec": {
			"project": "workshops",
			"destination": {
				"namespace": "a-x",
				"name": "b",
			},
		}}},
	}

	no_violations with input as input
}

test_deny_wrong_project {
	input := {
		"kind": "ApplicationSet",
		"metadata": {"name": "a"},
		"spec": {"template": {"spec": {
			"project": "default",
			"destination": {
				"namespace": "a-x",
				"name": "b",
			},
		}}},
	}

	deny["Application must use the 'workshops' project"] with input as input
}

test_deny_destination_server {
	input := {
		"kind": "ApplicationSet",
		"metadata": {"name": "a"},
		"spec": {"template": {"spec": {
			"project": "default",
			"destination": {
				"namespace": "a-x",
				"server": "b",
			},
		}}},
	}

	deny["Application must be deployed to the cluster via destination.name"] with input as input
	deny["Application must be deployed to the cluster"] with input as input
}

test_deny_modified_namespace {
	input := {
		"kind": "ApplicationSet",
		"metadata": {"name": "a"},
		"spec": {"template": {"spec": {
			"project": "default",
			"destination": {
				"namespace": "x",
				"name": "b",
			},
		}}},
	}

	deny["Application resources must target the a-* namespaces only"] with input as input
}

test_deny_wrong_kind {
	input := {
		"kind": "SomethingElse",
		"metadata": {"name": "a"},
		"spec": {"template": {"spec": {
			"project": "workshops",
			"destination": {
				"namespace": "a-x",
				"name": "b",
			},
		}}},
	}

	deny["This repo allows ApplicationSets only"] with input as input
}
