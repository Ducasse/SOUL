printing
printAsPrologFunctorOn: aStream scope: id in: env startAt: idx
	"TODO: What if any of the keywords are variables?"

	
	self keywords
		do: [:keyword | aStream write: keyword name]
		separatedBy: [aStream write: '_']	"Clearer without the last underscore, but potential ambiguity between unary messages and keyword messages with one argument. Uncomment if unambigous translation is needed"
	"aStream write: '_'."