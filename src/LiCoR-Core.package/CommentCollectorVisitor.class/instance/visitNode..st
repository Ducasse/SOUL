visiting
visitNode: node

	node comments do: [ :commentNode | comments add: commentNode contents ].
	^ super visitNode: node