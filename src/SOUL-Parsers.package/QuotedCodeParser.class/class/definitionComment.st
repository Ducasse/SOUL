generated
definitionComment
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