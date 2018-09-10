soul auto saved
stringOrAtomToCharsM2

"tested

stringOrAtomToChars(+-?StringOrAtom, +-?CharList) transforms a ?StringOrAtom to a ?CharList."

stringOrAtomToChars(?StringOrAtom,?CharList) if 
	stringOrAtom(?StringOrAtom),equals(?collection,[| collection newCollection |
collection := ?StringOrAtom asOrderedCollection.
newCollection := collection copyEmpty.
collection do: [:each | newCollection add: each asSymbol].
newCollection]),listAsCollection(?CharList,?collection)