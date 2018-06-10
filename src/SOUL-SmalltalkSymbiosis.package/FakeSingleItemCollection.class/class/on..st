instance creation
on: anItem
	
	^(anItem isKindOf: Boolean)
		ifTrue:
			[anItem	"Because of an optimisation in the VM for booleans and ifTrue:ifFalse:, the FakeSingleItemCollection trick doesn't work well for booleans, so just return the boolean and hope the programmer doesnt want to send collection messages to it :)"
]
		ifFalse: [self new zzzOn: anItem]