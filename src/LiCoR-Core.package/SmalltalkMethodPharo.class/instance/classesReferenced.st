information extraction
classesReferenced
	"The allButLast is necessary because AFAIK each method in Squeak has its class as the last literal, even if the source makes no reference to the class. I've also tested to see what happens when a method does refer to the class, in that case, the literal occurs twice, so it's still safe to remove the last occurance. (kgybels)"

	
	^(self compiledMethod literals allButLast
		select:
			[:literal | literal isVariableBinding and: [literal value isBehavior]])
		collect: [:literal | literal value]