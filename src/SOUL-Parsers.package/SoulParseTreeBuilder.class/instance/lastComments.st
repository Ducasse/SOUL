comment handling
lastComments
	
	^parser
		ifNil: ['']
		ifNotNil: [parser giveAndWipeComment]