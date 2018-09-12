information extraction
allSourceComments
	"TODO: Is this the best place to deal with non-regular methods such as the methods on LogicStorage? Furthermore, is the best way to deal with them just catching any exceptions in the parsing of the method source?"

	
	^[(CommentCollectorVisitor new)
		visitNode: (RBParser parseMethod: self sourceCode);
		allCollectedComments]
		on: Exception
		do: [:exception | OrderedCollection new]