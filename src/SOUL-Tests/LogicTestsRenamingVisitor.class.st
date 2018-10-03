Class {
	#name : #LogicTestsRenamingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'compoundTermRenamingVisitor',
		'didRenaming'
	],
	#category : 'SOUL-Tests'
}

{ #category : #rewriting }
LogicTestsRenamingVisitor class >> rewriteAllTestsWith: aCompoundTermRenamingVisitor [
	
	^(self new)
		compoundTermRenamingVisitor: aCompoundTermRenamingVisitor;
		rewriteAllTests
]

{ #category : #visiting }
LogicTestsRenamingVisitor >> acceptMessageNode: msg [
	
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
]

{ #category : #initialization }
LogicTestsRenamingVisitor >> compoundTermRenamingVisitor: aVisitor [
	
	compoundTermRenamingVisitor := aVisitor
]

{ #category : #rewriting }
LogicTestsRenamingVisitor >> rewrite: selector in: class [
	
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
]

{ #category : #rewriting }
LogicTestsRenamingVisitor >> rewriteAllTests [
	
	LogicTests allSubclasses
		do:
			[:testclass | 
			testclass selectors
				do:
					[:selector | 
					Transcript
						show: testclass name , '>>' , selector asString;
						cr.
					self rewrite: selector in: testclass]]
]
