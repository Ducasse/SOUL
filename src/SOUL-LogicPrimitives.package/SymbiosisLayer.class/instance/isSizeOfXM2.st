soul auto saved
isSizeOfXM2

"todo: should eventually end up as alternative for length/2, but unification of an uppedobject with a pair term (in head of lenght) currently raises an error"

?size isSizeOf: +?collection if 
	[?collection isKindOf: Collection],!,?size equals: [?collection size].
?size isSizeOf: +?collection if 
	length(?collection,?size)