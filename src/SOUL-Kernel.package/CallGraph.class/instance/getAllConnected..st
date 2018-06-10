private
getAllConnected: anInteger
	
	| res |
	res := OrderedCollection new.
	(nodes at: anInteger) doWithIndex: [:e :i | e isNil ifFalse: [res add: i]].
	^res