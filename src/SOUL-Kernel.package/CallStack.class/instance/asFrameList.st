printing
asFrameList
	
	| list |
	list := List new.
	(1 to: currentIndex - 1) do: [:index | list add: (self at: index)].
	^list reverse