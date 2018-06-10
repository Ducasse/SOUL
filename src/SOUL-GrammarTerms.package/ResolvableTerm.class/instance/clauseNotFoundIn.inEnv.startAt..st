resolving
clauseNotFoundIn: repository inEnv: env startAt: anIndex
	
	(self
		dynamicPredicate: (self predicateInEnv: env startAt: anIndex)
		inEnv: env
		startAt: anIndex)
		ifTrue:
			[^SoulFactory current makeNativeResolver
				onBlock: [:res | res]
				withArguments: #(nil)]
		ifFalse:
			[self
				error:
					'Cannot resolve ' , self asString , ' in repository ' , repository name]