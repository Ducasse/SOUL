private
convertCondition
	
	| counter newTerms |
	counter := 1.
	newTerms := OrderedCollection new.
	condition terms
		do:
			[:aTerm | 
			newTerms add: (aTerm asDCGConditionFor: counter).
			counter := counter + 1].
	condition terms: newTerms