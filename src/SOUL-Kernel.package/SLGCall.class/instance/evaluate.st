evaluation
evaluate
	"Start the evaluation of the call"

	
	| name list associations fun |
	self addToStack: true.	"evaluator := Soul.Evaluator
		eval: 'if slg' , (callTerm asString allButLast: 1) , ',' , cid asString , ')'
		in: callTerm definitionRepository."

	fun := callTerm functor.	"party in the parleh"

	fun isMessageFunctor
		ifTrue: [name := '#id:' , 'slg' , fun smalltalkValue asString]
		ifFalse: [name := 'slg' , fun smalltalkValue asString].
	list := ListTerm termSequence: callTerm termSequence.
	associations := OrderedCollection
		with: #Arguments -> list
		with: #Id -> cid.
	evaluator := SoulFactory current evaluatorForLogicQuery
		eval: 'if ' , name , '@(<?Id | ?Arguments >)'
		in: callTerm definitionRepository
		withAssociations: associations.
	evaluator allResults