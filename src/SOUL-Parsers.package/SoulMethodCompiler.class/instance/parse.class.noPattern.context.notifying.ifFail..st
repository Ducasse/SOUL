compilation
parse: aStream class: class noPattern: noPattern context: context notifying: handler ifFail: failblock
	
	^Parser new
		parse: aStream
		class: class
		noPattern: noPattern
		context: context
		notifying: handler
		builder: ProgramNodeBuilder new
		saveComments: true
		ifFail: failblock