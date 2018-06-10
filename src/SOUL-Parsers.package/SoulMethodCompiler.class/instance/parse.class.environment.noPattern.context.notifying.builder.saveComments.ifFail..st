public accessing
parse: aStream class: class environment: environment noPattern: noPattern context: context notifying: handler builder: aProgramNodeBuilder saveComments: mapFlag ifFail: failBlock
	
	^Parser new parse: aStream class: class environment: environment
		noPattern: noPattern context: context notifying: handler builder:
			aProgramNodeBuilder saveComments: mapFlag ifFail: failBlock