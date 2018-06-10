testing
dependsOnCallDeepBelow
	
	^self plink = self dfn
		and: [self dfn <= self nlink and: [self hasMaxNLink not]]