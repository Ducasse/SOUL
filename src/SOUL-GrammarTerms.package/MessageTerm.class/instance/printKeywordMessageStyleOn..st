printing
printKeywordMessageStyleOn: aStream
	"see comment in AbstractTerm"

	
	self receiver printAsKeywordArgOn: aStream.
	aStream write: ' '.
	self functor keywords
		with: (termsequence terms allButFirst: 1)
		do:
			[:keyword :aterm | 
			keyword printOn: aStream.
			aStream write: ': '.
			aterm printAsKeywordArgOn: aStream]
		separatedBy: [aStream write: ' ']