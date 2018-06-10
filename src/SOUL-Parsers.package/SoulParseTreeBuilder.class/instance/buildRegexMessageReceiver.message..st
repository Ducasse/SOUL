building SOUL
buildRegexMessageReceiver: receiver message: keywordedMessageCompound
	
	| term |
	term := RegexTerm newFromMessageTerm: keywordedMessageCompound withGoals:
			receiver.
	^term generateStates