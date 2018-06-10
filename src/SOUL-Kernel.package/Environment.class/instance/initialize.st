initialize
initialize
	"All elements must be nil, this is standard for making a new array"

	
	variableArray := Array new: self initialSize.
	bindingArray := Array new: self initialSize.
	bindingIndex := 1.
	variableIndex := 1.
	bindingMax := self initialSize.
	variableMax := self initialSize