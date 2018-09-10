rewriting
rewrite: selector in: class
	
	| method |
	didRenaming := false.
	method := RBParser parseMethod: (class sourceCodeAt: selector).
	method acceptVisitor: self.
	didRenaming
		ifTrue:
			[Transcript
				show:
						'Recompiling test case: ' , class asString , '>>' , selector asString;
				cr.
			class compile: method formattedCode]