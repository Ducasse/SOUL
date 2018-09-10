visiting
acceptMessageNode: msg
	
	| queryString query newQuery |
	super acceptMessageNode: msg.
	('processQuery:*' match: msg selector)
		ifTrue:
			[queryString := msg arguments first value.
			query := SoulFactory current makeParser parse: queryString.
			compoundTermRenamingVisitor resetDidRenaming.
			newQuery := query accept: compoundTermRenamingVisitor.
			compoundTermRenamingVisitor didRenaming
				ifTrue:
					[msg arguments first replaceWith: (RBLiteralNode value: newQuery asString).
					didRenaming := true]]