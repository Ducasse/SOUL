visitor-double dispatching
acceptCascadeNode: aCascadeNode
	
	| sendInfo arguments receiver |
	receiver := self visitNode: aCascadeNode receiver.
	arguments := aCascadeNode messages
		collect:
			[:msg | 
			sendInfo := Array
				with: receiver
				with: (Constant name: msg selector)
				with: (self visitNodes: msg arguments).
			self makeCompoundTerm: 'cascadeSend' withTerms: sendInfo].
	^self
		makeCompoundTerm: 'cascade'
		withTerm: receiver
		andTerm: (SoulFactory current makeList termSequence: arguments)