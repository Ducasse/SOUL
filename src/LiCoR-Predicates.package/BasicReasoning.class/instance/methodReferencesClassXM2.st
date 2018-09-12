method body
methodReferencesClassXM2

"Does method ?Method refer to class ?Class?"

?Method methodReferencesClass: ?Class if 
	?Method isMethod,[?Method classesReferenced] contains: ?Class