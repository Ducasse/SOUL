private
asParseTrees
	"This method is only called after the repository of clauses has been loaded. It parses the contents and builds a set of logic parsetrees of the source, using the DCG grammar rules in the repository."

	
	| results trees |
	results := (SoulFactory current evaluatorForTemplateParsing
		eval:
			'if parse(' , type functor asString , ',[''' , source asString ,
					'''],?result)'
		in: SoulFactory parsingRepository) allResults.
	results size = 0 ifTrue: [self error: 'Parse error in quotedcode'].
	trees := OrderedCollection new.
	results
		do: [:value | trees add: (value accept: CopyingVisitor new)]
		forVariableNames: (OrderedCollection with: 'result').
	^trees