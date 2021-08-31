package main

empty(value) {
	count(value) == 0
}

no_violations {
	empty(deny)
}

test_allow {
	input := {
		"kind": "Application",
		"metadata": {"name": "a"},
		"spec": {
			"project": "workshops",
			"destination": {
				"namespace": "a-x",
				"name": "b",
			},
		},
	}

	no_violations with input as input
}

test_deny_wrong_project {
	input := {
		"kind": "Application",
		"metadata": {"name": "a"},
		"spec": {
			"project": "default",
			"destination": {
				"namespace": "a-x",
				"name": "b",
			},
		},
	}

	deny["Application must use the 'workshops' project"] with input as input
}

test_deny_destination_server {
	input := {
		"kind": "Application",
		"metadata": {"name": "a"},
		"spec": {
			"project": "default",
			"destination": {
				"namespace": "a-x",
				"server": "b",
			},
		},
	}

	deny["Application must be deployed to the cluster via destination.name"] with input as input
	deny["Application must be deployed to the cluster"] with input as input
}

test_deny_wrong_kind {
	input := {
		"kind": "SomethingElse",
		"metadata": {"name": "a"},
		"spec": {
			"project": "workshops",
			"destination": {
				"namespace": "a-x",
				"name": "b",
			},
		},
	}

	deny["This repo allows Application only"] with input as input
}
