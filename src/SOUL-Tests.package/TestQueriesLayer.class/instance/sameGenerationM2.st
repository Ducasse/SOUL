slg performance
sameGenerationM2

sameGeneration(?X,?X) if 
	[true].
sameGeneration(?X,?Y) if 
	cyl(?X,?Z),sameGeneration(?Z,?Z),cyl(?Y,?Z)