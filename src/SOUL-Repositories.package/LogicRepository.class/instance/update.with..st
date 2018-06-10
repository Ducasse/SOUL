update mechanism
update: anAspect with: aLayerClass
	"set the flag that this repository is no longer up-to-date"

	"check if the loaded layers have not been expanded with sublayers"

	
	anAspect == #addLayer
		ifTrue:
			[(fromLayers includes: aLayerClass superclass)
				ifTrue:
					[self loadLayer: aLayerClass.
					storageChanged := true]].
	anAspect == #removeLayer
		ifTrue:
			[(fromLayers includes: aLayerClass)
				ifTrue:
					[self removeLayer: aLayerClass.
					storageChanged := true]].
	anAspect == #changePredicate & (fromLayers includes: aLayerClass)
		ifTrue: [storageChanged := true].
	anAspect == #factoryChanged
		ifTrue: [storageChanged := (compilationFactory = SoulFactory current) not]