soul auto saved
subStructureListM4

"Auxiliary predicate for constructing a compound term from an instantiated list."

subStructureList(?coll,<>,<>,?) if 
	equals(?coll,[OrderedCollection new]).
subStructureList(?coll,<?car|?cdr>,<?carPointer|?varRest>,?count) if 
	subStructureList(?collection,?cdr,?varRest,[?count + 1]),envLookup(?car,?carPointer),equals(?coll,[?collection
	addFirst: ((Variable name: 'temp') setAddress: ?count);
	yourself])