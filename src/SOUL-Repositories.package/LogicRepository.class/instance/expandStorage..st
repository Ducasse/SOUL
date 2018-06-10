private
expandStorage: aSize
	
	| newArray |
	"grow the repository"

	maxAddress := maxAddress + aSize.
	newArray := Array new: maxAddress.
	1
		to: currentAddress - 1
		do:
			[:i | 
			newArray
				at: i
				put: (clauseArray at: i)].
	clauseArray := newArray