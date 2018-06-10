private
dynamicPredicate: aPredicate inEnv: anEnv startAt: anIndex
	
	| evaluator result resRep |
	resRep := self callRepositoryInEnv: anEnv startAt: anIndex.
	(resRep addressForPredicate: 'dynamic')
		ifNil: [^false]
		ifNotNil:
			[evaluator := SoulFactory current evaluatorForLogicQuery
				eval: 'if dynamic(' , aPredicate , ')'
				in: self definitionRepository.
			result := evaluator nextResult.
			^result success]