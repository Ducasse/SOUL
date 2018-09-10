Private
keepTime: took forClass: aClass
	"Something was tested in aClass that took a certain time. Keep the total execution time for that class in the dictionary."

	
	| key currentTotalTime |
	key := aClass name.
	currentTotalTime := self totalsForClasses
		at: key
		ifAbsent: [0].
	self totalsForClasses
		at: key
		put: currentTotalTime + took