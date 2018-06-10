printing
prettyPrintOn: aStream scope: id
	"see comment in AbstractClause"

	
	self prettyPrintCommentOn: aStream.
	self prettyPrintConclusionOn: aStream.
	aStream withAttributes:(Array with: TextEmphasis bold with:(TextColor red)) do:[
	aStream write: ' --> '].
	condition terms
		do: [:aCondition | self prettyPrintCondition: aCondition on: aStream]
		separatedBy: [aStream write: ',']