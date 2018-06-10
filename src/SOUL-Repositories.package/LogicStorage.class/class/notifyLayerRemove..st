update mechanism
notifyLayerRemove: aClass
	
	self storageDependents
		do:
			[:class | class allInstances do: [:e | e update: #removeLayer with: aClass]]