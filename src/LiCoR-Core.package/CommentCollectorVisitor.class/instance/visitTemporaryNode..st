visiting
visitTemporaryNode: node

	node comments do: [ :commentNode | comments add: commentNode contents ].
	^ super visitTemporaryNode: node