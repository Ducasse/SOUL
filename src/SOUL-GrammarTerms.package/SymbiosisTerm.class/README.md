This abstract class is the superclass of all logic terms that deal with symbiosis with Smalltalk. It groups their common behaviour

Subclasses must implement the following messages:
	private
		constructBlock
		parse:
		parseVariables

Instance Variables:
	block	<BlockClosure | MessageChannel>	description of block
	content	<RBProgramNode>	description of content
	source	<AbstractItem | ByteFieldDescriptor | CCompoundType | (Collection of: Character) | MC_FileBTree | PostgreSQLQueryResultList | RBProgramNode | SmaCCRHS | SOULResults | Stream | TermSequence>	description of source
	variables	<(OrderedCollection of: Variable)>	description of variables

