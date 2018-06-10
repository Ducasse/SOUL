editing-all
inAllRename: originalName multiplicity: multiplicity to: newName argumentMapping: argumentMapping
	
	self rename: originalName multiplicity: multiplicity to: newName
		argumentMapping: argumentMapping.
	self allSubclasses
		do:
			[:layer | 
			layer rename: originalName multiplicity: multiplicity to: newName
				argumentMapping: argumentMapping]