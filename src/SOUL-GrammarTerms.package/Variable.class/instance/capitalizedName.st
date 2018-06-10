private
capitalizedName
	
	^(name copy)
		at: 1
			put: name first asUppercase;
		yourself