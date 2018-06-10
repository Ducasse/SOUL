compilation support
addSubclass: aSubclass
	
	| res |
	res := super addSubclass: aSubclass.
	self notifyLayerAdd: aSubclass.
	^res