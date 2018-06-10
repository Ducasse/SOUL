private
dynamicPredicate: aPredicate inEnv: anEnv startAt: anIndex
	
	| evaluator result |
	(self definitionRepository addressForPredicate: 'dynamic')
		ifNil: [^false]
		ifNotNil:
			[evaluator := SoulFactory current evaluatorForLogicQuery
				eval: 'if dynamic(#' , aPredicate , ')'
				in: self definitionRepository.
			result := evaluator nextResult.
			^result success]