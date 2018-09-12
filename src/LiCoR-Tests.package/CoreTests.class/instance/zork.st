test method
zork
	
	| temp |
	temp := SoulFactory current makeVariable.
	temp halt: 'Aaaarrgghhhhhh! I am not meant to be executed!'.
	^temp environment = Test