add/del - from storage
loadLayer: aLayer
	
	(fromLayers includes: aLayer) ifFalse: [fromLayers add: aLayer].
	Transcript
		show: 'Loading Layer: ' , aLayer asString;
		cr.
	storageChanged := true