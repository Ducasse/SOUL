private - storage
printClausesWithKey: key
	
	| printStream |
	printStream := WriteStream on: String new.
	printStream
		cr;
		cr.
	(self clausesCollectionForKey: key)
		do: [:cl | cl printOn: printStream]
		separatedBy:
			[printStream
				write: '.';
				cr;
				cr].
	^printStream contents