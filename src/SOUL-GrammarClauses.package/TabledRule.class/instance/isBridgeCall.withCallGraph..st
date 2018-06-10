private
isBridgeCall: aTerm withCallGraph: aCallGraph
	"not calls are no bridges (I think), as not's can not generate bindings for variables
	as they are supposed to be ground"

	
	| connectedBy bridges |
	aTerm functor asString = 'not'
		ifFalse:
			[connectedBy := aCallGraph isTermConnected: aTerm withClause: self.
			bridges := connectedBy
				collect: [:term | term isBridgeNeeded: self withCallGraph: aCallGraph].
			^bridges isEmpty not]
		ifTrue: [^false]