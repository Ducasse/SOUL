printing
printKeywordStyleOn: aStream
	"see comment in AbstractTerm"

	
	self functor keywords
		with: termsequence terms
		do:
			[:keyword :aterm | 
			keyword printOn: aStream.
			aStream write: ': '.
			aterm printAsKeywordArgOn: aStream]
		separatedBy: [aStream write: ' ']