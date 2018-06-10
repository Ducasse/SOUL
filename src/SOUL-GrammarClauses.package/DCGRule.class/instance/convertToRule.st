private
convertToRule
	"Convert the DCG spec in this rule to a logic rule that is able to execute the parsing process:
		s(a,b) --> np(a),vp(b)   ==>>  s(a,b,L1,L3) if np(a,L1,L2),vp(b,L2,L3)"

	
	self convertConclusion.
	self convertCondition