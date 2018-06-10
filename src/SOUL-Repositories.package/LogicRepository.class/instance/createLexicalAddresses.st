private
createLexicalAddresses
	"set lexicaladdresses on all clauses in the repository"

	
	| visitor multArray clauses |
	visitor := LexicalAddressVisitor on: self.
	(1 to: currentAddress)
		do:
			[:index | 
			multArray := clauseArray at: index.
			(1 to: multArray size)
				do:
					[:idx | 
					clauses := multArray at: idx.
					clauses do: [:clause | clause accept: visitor]]]