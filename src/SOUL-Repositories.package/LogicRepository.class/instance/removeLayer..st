add/del - from storage
removeLayer: aClass
	"Remove the layer from this repository"

	
	fromLayers remove: aClass.
	storageChanged := true