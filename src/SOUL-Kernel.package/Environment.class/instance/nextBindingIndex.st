private
nextBindingIndex
	
	| temp |
	bindingIndex = bindingMax ifTrue: [self resizeBindings].
	temp := bindingIndex.
	bindingIndex := bindingIndex + 1.
	^temp