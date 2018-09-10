rewriting
rewriteAllTestsWith: aCompoundTermRenamingVisitor
	
	^(self new)
		compoundTermRenamingVisitor: aCompoundTermRenamingVisitor;
		rewriteAllTests