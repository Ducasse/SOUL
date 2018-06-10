compilation support
removeSubclass: aSubclass
	
	| res |
	res := super removeSubclass: aSubclass.
	self notifyLayerRemove: aSubclass.
	^res