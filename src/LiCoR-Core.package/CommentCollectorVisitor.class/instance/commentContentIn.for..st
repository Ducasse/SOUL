private
commentContentIn: node for: commentSourceInterval
	"RBParser in Squeak has different behavior for parsing comments than the VW version"

	
	^(node methodNode source
		copyFrom: commentSourceInterval first + 1
		to: commentSourceInterval last - 1) asString