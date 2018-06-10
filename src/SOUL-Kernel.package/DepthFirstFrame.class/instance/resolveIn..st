evaluation
resolveIn: anEnv
	"produces frames to be pushed onto the searchspace: one frame for the  
	resolution of the first condition with a first candidate from the  
	repository and a continuationFrame for the next candidates.  
	The other conditions in this frame are taken along into the new frames"

	
	| resolutionResult results resolver tempcuttop |
	"first roll back the environment"

	self rollback: anEnv.
	results := OrderedCollection new.
	resolver := conditionsList resolveIn: anEnv.
	conditionsList := conditionsList nextTerm.
	resolutionResult := resolver nextResolution.	"the resolver now encapsulates the resolution of the clause with other  
	candidate clauses"

	resolver isEmpty
		ifTrue:
			["an empty resolver means tail-recursion using the current  
			resolutionresult"

			resolutionResult
				ifNotNil:
					[results add: (self fromResolution: resolutionResult).
					resolutionResult cutTopDelimiter
						ifTrue: [results add: CutTopFrame new]]]
		ifFalse:
			["a non-empty resolver means splitting the searchspace in this  
			resolutionresult and a continuationframe containing the other  
			candidate expansionframes"

			tempcuttop := false.
			resolutionResult
				ifNotNil:
					[results add: (self clone fromResolution: resolutionResult).
					tempcuttop := resolutionResult cutTopDelimiter].
			results
				add:
					(DepthFirstChoiceFrame
						withResolver: resolver
						clauses: conditionsList
						rollbackInfo: self rollbackInfo
						cuttop: tempcuttop)].
	^results