private
endOfLastToken
	"The bad VW implementation of Text>>makeSelectorBoldIn: gives 
	trouble. It needs to emphasize the selector of a method in 
	bold. Therefore it first parses the selector (which, as a side 
	effect means that the parser holds on to the position just after 
	the selector). Then, this position is asked for with the general 
	#endOfLastToken message (hence assuming lots of 
	implementation details of the parser)."

	"We mimic this behavior by setting an instance variable with 
	the position of the end of the selector. This is then returned 
	when the #endOfLastToken message is called."

	
	| end |
	end := endOfLastToken.
	end isNil
		ifTrue:
			[self error:
					'SOULMethodParser is in trouble (endOfLastToken is being used where it wasn''t supposed to!)']
		ifFalse:
			[endOfLastToken := nil.
			^end]