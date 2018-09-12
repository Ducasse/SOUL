private
isRemovalNecessaryFor: anElement
	"return whether it is necessary to remove 1 or more elements before adding the 
	argument"

	
	^self elements size >= self maxSize