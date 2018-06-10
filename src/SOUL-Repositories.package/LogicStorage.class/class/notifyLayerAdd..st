update mechanism
notifyLayerAdd: aClass
	
	self storageDependents
		do:
			[:class | class allInstances do: [:e | e update: #addLayer with: aClass]]