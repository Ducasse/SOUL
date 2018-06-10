accessing
addVariables: aCollection
	
	aCollection
		do:
			[:aVar | 
			dictionary
				at: aVar name
				put: aVar address]