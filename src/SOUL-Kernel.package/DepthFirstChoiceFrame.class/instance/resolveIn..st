evaluation
resolveIn: anEnv
	"fetch the resolution of the next candidate clause, produce a frame and  
	check if the resolver still has candidate clauses"

	"first rollback the environment"

	
	| resolutionResult results newFrame |
	self rollback: anEnv.
	results := OrderedCollection new.
	resolutionResult := resolver nextResolution.
	resolutionResult
		ifNotNil:
			[newFrame := DepthFirstFrame fromConditionsStack: conditionsList.
			newFrame fromResolution: resolutionResult.
			results add: newFrame.
			cuttop := resolutionResult cutTopDelimiter].
	resolver isEmpty
		ifFalse: [results add: self]
		ifTrue: [cuttop ifTrue: [results add: CutTopFrame new]].
	^results