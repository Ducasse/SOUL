private
parseVariables
	
	| visitor |
	visitor := RBSoulVariableExtractorVisitor new.
	content acceptVisitor: visitor.
	variables := visitor variables.
	variables addFirst: nil.
	variables addFirst: nil.
	variables := variables asArray