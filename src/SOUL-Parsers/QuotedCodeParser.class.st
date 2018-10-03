Class {
	#name : #QuotedCodeParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'builder'
	],
	#category : 'SOUL-Parsers'
}

{ #category : #'generated-accessing' }
QuotedCodeParser class >> cacheId [
	^'2018-06-09T09:35:56.097421+02:00'
]

{ #category : #generated }
QuotedCodeParser class >> definitionComment [
"#Definition extracted from old style definition comments
<char> : [^ \?\@\\\'];
<space> : \s;
<var> : \? ([A-Za-z0-9])+;
<type> : \\ ([A-Za-z0-9])+;
<quote> : \';
<compound> : \@;
	
	
%id <compound>;

QUOTEDCODE : 	QUOTEDCODEPART*;

QUOTEDCODEPART :	STRINGPART {#liftFirstValue:} |
						VARIABLE {#liftFirstValue:} |
						SPLICECOMPOUND {#liftFirstValue:} ;

STRINGPART : <char> 'char'	{builder buildQuotedCodeConstant: char value} |
				<space> 'space' {builder buildQuotedCodeConstant: space value}|
                        <quote> 'quote' {builder buildQuotedCodeConstant: '''',quote value};

VARIABLE :	NORMALVAR {#liftFirstValue:} | DECORATEDVAR {#liftFirstValue:};

NORMALVAR :  <var> 'var' 	{builder buildVariable: var value};
DECORATEDVAR : <var> 'var' TYPE+ 'types' {builder buildDecoratedVariable: var value with: types};

TYPE : <type> 'name' {builder buildConstant: (name value allButFirst: 1)};

SPLICECOMPOUND : <compound> 'compound' {builder buildSpliceCompound: compound value};"
]

{ #category : #'instance creation' }
QuotedCodeParser class >> new [
	
	^super new initialize
]

{ #category : #'generated-accessing' }
QuotedCodeParser class >> scannerClass [
	^QuotedCodeScanner
]

{ #category : #generated }
QuotedCodeParser class >> startingStateForQUOTEDCODE [
	^ 1
]

{ #category : #initialize }
QuotedCodeParser >> initialize [
	
	builder := SoulParseTreeBuilder forParser: self.
	^super initialize
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForDECORATEDVAR1: nodes [
	^ builder
		buildDecoratedVariable: (nodes at: 1) value
		with: (nodes at: 2)
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForNORMALVAR1: nodes [
	^ builder buildVariable: (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForQUOTEDCODEPART_1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForQUOTEDCODEPART_2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForSPLICECOMPOUND1: nodes [
	^ builder buildSpliceCompound: (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForSTRINGPART1: nodes [
	^ builder buildQuotedCodeConstant: (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForSTRINGPART3: nodes [
	^ builder buildQuotedCodeConstant: '''' , (nodes at: 1) value
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForTYPE1: nodes [
	^ builder buildConstant: ((nodes at: 1) value allButFirst: 1)
]

{ #category : #'generated-reduction actions' }
QuotedCodeParser >> reduceActionForTYPE_1: nodes [
	^ OrderedCollection with: (nodes at: 1)
]

{ #category : #generated }
QuotedCodeParser >> reduceTable [
^#(
	#(14 0 #reduceActionForQUOTEDCODEPART_1:) 
	#(11 1 #reduceFor:) 
	#(9 1 #reduceActionForSTRINGPART1:) 
	#(12 1 #reduceActionForNORMALVAR1:) 
	#(9 1 #reduceActionForSTRINGPART3:) 
	#(8 1 #reduceActionForSPLICECOMPOUND1:) 
	#(17 1 #liftFirstValue:) 
	#(7 1 #liftFirstValue:) 
	#(14 2 #reduceActionForQUOTEDCODEPART_2:) 
	#(15 1 #reduceActionForTYPE1:) 
	#(16 1 #reduceActionForTYPE_1:) 
	#(13 2 #reduceActionForDECORATEDVAR1:) 
	#(16 2 #reduceActionForQUOTEDCODEPART_2:)
	).
]

{ #category : #generated }
QuotedCodeParser >> symbolNames [
	^ #('<char>' '<space>' '<var>' '<type>' '<quote>' '<compound>' 'VARIABLE' 'SPLICECOMPOUND' 'STRINGPART' 'B e g i n' 'QUOTEDCODE' 'NORMALVAR' 'DECORATEDVAR' 'QUOTEDCODEPART*' 'TYPE' 'TYPE+' 'QUOTEDCODEPART' 'E O F' 'error')
]

{ #category : #generated }
QuotedCodeParser >> transitionTable [
^#(
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 5 0 6 0 6 0 9 0 11 0 13 0 14 0 6 0 18] 
#[0 0 0 0 18] 
#[1 0 17 0 1 0 21 0 2 0 25 0 3 0 29 0 5 0 33 0 6 0 57 0 7 0 57 0 8 0 57 0 9 0 57 0 12 0 57 0 13 0 57 0 17 0 10 0 18] 
#[0 0 14 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 14 0 1 0 2 0 3 0 5 0 6 0 18] 
#[1 0 18 0 1 0 18 0 2 0 18 0 3 0 61 0 4 0 18 0 5 0 18 0 6 0 65 0 15 0 69 0 16 0 18 0 18] 
#[0 0 22 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 26 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 30 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 30 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 30 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 34 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 34 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 38 0 1 0 2 0 3 0 5 0 6 0 18] 
#[0 0 42 0 1 0 2 0 3 0 4 0 5 0 6 0 18] 
#[0 0 46 0 1 0 2 0 3 0 4 0 5 0 6 0 18] 
#[1 0 50 0 1 0 50 0 2 0 50 0 3 0 61 0 4 0 50 0 5 0 50 0 6 0 73 0 15 0 50 0 18] 
#[0 0 54 0 1 0 2 0 3 0 4 0 5 0 6 0 18]
	).
]
