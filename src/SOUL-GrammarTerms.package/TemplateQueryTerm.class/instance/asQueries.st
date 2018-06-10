private
asQueries
	
	| results thesequeries parsetreerepresentation queryclauses conversionQueryString associations |
	thesequeries := OrderedCollection new.
	self parsetrees
		do:
			[:parsetree | 
			parsetreerepresentation := (parsetree accept: VariableWrapperVisitor new)
				asString.
			associations := self associationsForConversionQueryString.
			conversionQueryString := self conversionQueryStringForParseTree:
					parsetreerepresentation.
			results := (SoulFactory current evaluatorForTemplateCompilation
				eval: conversionQueryString
				in: SoulFactory compilingRepository
				withAssociations: associations) allResults.
			results size = 0 ifTrue: [self error: 'conversion error in quotedcode'].
			results
				do:
					[:query :annotation | 
					| evaluator queryCopy annotationCopy |
					queryclauses := OrderedCollection new.
					query listDo: [:aTerm | queryclauses add: aTerm].	"not so nice solution: in order to overcome the shared compound term instances problem in these queries, we create an entirely new query through parsing"

					evaluator := SoulFactory current evaluatorForTemplateCompilation
						eval: (Query condition: (TermSequence terms: queryclauses)) asString
						in: SoulFactory compilingRepository.
					queryCopy := evaluator query condition
						accept: VariableUnwrapperVisitor new.
					annotationCopy := annotation accept: CopyingVisitor new.
					thesequeries add: (Array with: queryCopy with: annotationCopy)]
				forVariableNames: (OrderedCollection with: 'query' with: 'annotation')].
	^thesequeries