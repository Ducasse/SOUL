private
resizeBindings
	"TODO: use Array replaceFrom: to: with:"

	
	| newArray |
	bindingMax := bindingMax + self incrementSize.
	newArray := Array new: bindingMax.
	1
		to: bindingIndex
		do:
			[:i | 
			newArray
				at: i
				put: (bindingArray at: i)].
	bindingArray := newArray