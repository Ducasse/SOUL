visiting
visitNode: node
	
	node comments
		do:
			[:commentSourceInterval | comments add: (self commentContentIn: node for: commentSourceInterval)].
	^super visitNode: node