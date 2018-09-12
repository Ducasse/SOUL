public access
compile

	| selector result input compileClass |
	input := source contents.
	selector := self parseSelector: input.
	compileClass := self compilationContext getClass.

	result := OpalCompiler new 
		class: compileClass;
		source: selector , ' ^ self class parseInstanceStorageMethod: '
				, selector printString;
		compile.
	
	compileClass doingInternalStorage
		ifFalse:
			[
			"TODO: Is this the best place to do this? At this moment the actual code of the storage method has *not* yet been changed!"
			compileClass storageChangedExternally: selector newCode: input ].
	
	^ result