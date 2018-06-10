compilation
compile: aCode in: aClass classified: cat notifying: aRequestor ifFail: aFailBlock
	
	| selector result input |
	input := aCode contents.
	selector := Parser new parseSelector: input.
	result := Compiler new
		compile:
			selector , ' ^ self class parseInstanceStorageMethod: '
				, selector printString
		in: aClass
		notifying: nil
		ifFail: [^nil].
	"Change the source pointer of the method node"
	result sourceText: aCode.
	aClass doingInternalStorage
		ifFalse:
			["TODO: Is this the best place to do this? At this moment the actual code of the storage method has *not* yet been changed!"

			aClass storageChangedExternally: selector newCode: aCode].
	^result