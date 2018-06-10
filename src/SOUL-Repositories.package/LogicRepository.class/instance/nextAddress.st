private
nextAddress
	"returns the next free address in the repository"

	
	currentAddress := currentAddress + 1.
	currentAddress > maxAddress ifTrue: [self expandStorage: 500].
	^currentAddress