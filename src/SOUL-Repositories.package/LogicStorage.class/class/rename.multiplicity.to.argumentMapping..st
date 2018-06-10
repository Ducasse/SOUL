editing-local
rename: renamed multiplicity: multiplicity to: newName argumentMapping: argumentMapping
	
	| renameVisitor newClause |
	renameVisitor := CompoundTermRenamingVisitor rename: renamed multiplicity:
			multiplicity to: newName argumentMapping: argumentMapping.
	self gatherClauses
		do:
			[:clause | 
			newClause := clause accept: renameVisitor.
			renameVisitor didRenaming
				ifTrue: [self replaceClause: clause with: newClause].
			renameVisitor resetDidRenaming]