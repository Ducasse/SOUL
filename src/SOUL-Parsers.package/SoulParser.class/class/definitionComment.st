generated
definitionComment
"#Definition extracted from old style definition comments
<id> : [A-Za-z0-9] ([A-Za-z0-9])*;
<keyword> : [A-Za-z0-9] ([A-Za-z0-9])* \:;
<symbol> : \# [A-Za-z0-9\:]+;
<varid> : \? ([A-Za-z0-9])+;
<varkeyword> : \? ([A-Za-z0-9])+ \:;
<delayedvar> : \& ([A-Za-z0-9])+;
<posvar> : \+\? ([A-Za-z0-9])+;
<negvar> : \-\? ([A-Za-z0-9])+;
<underscorevar> : \?;
<stterm> : \[;
<quoted> : \{;
<dcgoperator> : \-\-\>;
<comment>	:	\"" [^\""]* \""	;
<whitespace> : [\s\t\r\n]+ ;

	
	
%id <stterm> <quoted>;
%left "":"" ;

SOUL : PROGRAM	{#liftFirstValue:} |
		QUERY		{#liftFirstValue:};

QUERY : ""if"" TERMSEQUENCE	'termsequence'		{builder buildQuery: termsequence};

PROGRAM :	FACT 'fact' ""."" PROGRAM 'program'	{builder addTerm: fact inFront: program}|
				RULE 'rule' ""."" PROGRAM 'program'	{builder addTerm: rule inFront: program} |
				DCGRULE 'dcgrule' ""."" PROGRAM 'program' {builder addTerm: dcgrule inFront: program} |
				TABLEDRULE 'tabledrule' ""."" PROGRAM 'program' {builder addTerm: tabledrule inFront: program} |
				FACT 'fact'							{builder buildProgramSequence: fact}	|
				RULE 'rule'							{builder buildProgramSequence: rule}|
				DCGRULE 'dcgrule'					{builder buildProgramSequence: dcgrule} |
				TABLEDRULE 'tabledrule'					{builder buildProgramSequence: tabledrule};


FACT : TERM 'term'											{builder buildFact: term};

RULE : TERM 'term' ""if"" TERMSEQUENCE 'termsequence'	{builder buildRuleConclusion: term condition: termsequence};

DCGRULE : TERM 'head' <dcgoperator> TERMSEQUENCE 'body'	{builder buildDCGRule: head body: body};

TABLEDRULE :     ""tabled"" RULE 'tabledrule'                           {builder buildTabledRule: tabledrule};

TERMSEQUENCE : TERM 'term' ("","" | ""&"") TERMSEQUENCE 'termsequence'	{builder addTerm: term inFront: termsequence}|
					TERM 'term'											{builder buildTermSequence: term};

TERM : TERM 'term'  "":"" CRISPTERM 'annotation' {builder buildAnnotatedTerm: term withAnnotation: annotation}
            | CRISPTERM {#liftFirstValue:};

CRISPTERM	:	CONSTANT				{#liftFirstValue:}|
			VARIABLE				{#liftFirstValue:}|
			LIST					{#liftFirstValue:}|
			SMALLTALKTERM		{#liftFirstValue:}|
			QUOTEDCODE			{#liftFirstValue:}|
			TEMPLATEQUERY		{#liftFirstValue:}|
			CUT					{#liftFirstValue:}|
			CALLTERM				{#liftFirstValue:}|
			VARARGSCOMPOUND 	{#liftFirstValue:}|
			FUNCTIONALCOMPOUND 	{#liftFirstValue:}|
			KEYWORDEDCOMPOUND	{#liftFirstValue:}|
			MESSAGE 					{#liftFirstValue:};

KEYWORDARG :  	CONSTANT 					{#liftFirstValue:}|
					VARIABLE 					{#liftFirstValue:}|
					LIST						{#liftFirstValue:}|
					SMALLTALKTERM 			{#liftFirstValue:}|
					QUOTEDCODE 				{#liftFirstValue:}|
					TEMPLATEQUERY			{#liftFirstValue:}|
					CUT 						{#liftFirstValue:}|
					VARARGSCOMPOUND		{#liftFirstValue:}|
					FUNCTIONALCOMPOUND 	{#liftFirstValue:}|
					""("" KEYWORDEDCOMPOUND "")"" 	{#liftSecondValue:}|
					""("" KEYWORDEDMESSAGE "")"" {#liftSecondValue:}|
					""("" UNARYMESSAGE "")"" {#liftSecondValue:}|
					UNARYMESSAGE {#liftFirstValue:};

CUT : ""!"" 	{builder buildCut};

CALLTERM : VARIABLE 'variable' ""->"" TERM 'term' {builder buildCallTerm: term variable: variable}; 

CONSTANT : <id>				{builder buildConstant: '1' value} |
			  <symbol>			{builder buildSymbol: '1' value}  ;

VARIABLE : <varid> {builder buildVariable: '1' value}|
			<posvar> {builder buildPosVariable:'1' value}|
			<negvar> {builder buildNegVariable:'1' value}|
			<delayedvar> {builder buildDelayedVariable:'1' value} |
			<underscorevar> {builder buildUnderscoreVariable:'1' value};

VARARGSCOMPOUND : FUNCTOR 'functor' ""@("" TERMSEQUENCE 'terms' "")""		{builder buildVarArgsCompound: functor withTerms: terms} ;

FUNCTIONALCOMPOUND : FUNCTOR 'functor' ""("" TERMSEQUENCE 'terms' "")""		{builder buildCompound: functor withTerms: terms} ;

KEYWORDEDCOMPOUND :  KEYWORD KEYWORDARG KEYWORDEDCOMPOUND {builder addKeyword:'1' term:'2' toKeywordedCompound:'3'} |
						      KEYWORD KEYWORDARG {builder buildKeywordedCompound:'1' firstTerm:'2'}  ;

KEYWORDEDMESSAGE : 	RECEIVER 'rec' MATCHESMESSAGEANDARGS 'mesgargs' { builder buildRegexMessageReceiver: rec message: mesgargs } |
						 	RECEIVER 'rec' KEYWORDEDMESSAGEANDARGS 'mesgargs' { builder buildKeywordedMessageReceiver: rec message: mesgargs} ;

MATCHESMESSAGEANDARGS: ""matches:"" KEYWORDARG 'arg' {builder buildKeywordedMessageFirstKey: (builder buildKeyword: #matches: ) andArgument: arg };

KEYWORDEDMESSAGEANDARGS : KEYWORD 'keyword' KEYWORDARG 'arg' KEYWORDEDMESSAGEANDARGS 'mesgargs' {builder addKeyword: keyword andArg: arg to: mesgargs} |
								     KEYWORD 'keyword' KEYWORDARG 'arg' {builder buildKeywordedMessageFirstKey: keyword andArgument: arg} ;

UNARYMESSAGE : RECEIVER 'rec' UNARYSELECTOR 'sel' {builder buildUnaryMessageReceiver: rec message: sel} ;

UNARYSELECTOR : <id> 'id' {builder buildUnaryMessageFromId: id value} | VARIABLE 'var' {builder buildUnaryMessageFromVariable: var};

RECEIVER : KEYWORDARG {#liftFirstValue:};

KEYWORD : <keyword> 	{builder buildKeyword: '1' value} |
			 <varkeyword> 	{builder buildVarKeyword: '1' value} ;

SMALLTALKTERM : <stterm> 'stterm' {builder buildSmalltalkTerm: stterm value} ;

QUOTEDCODE :  <quoted> 'quoted'  {builder buildQuotedCodeTerm: quoted value};

TEMPLATEQUERY : FUNCTIONALCOMPOUND 'type' <quoted> 'quoted' {builder buildTemplateQuery: quoted value type: type};

LIST : 	""<"" TERMSEQUENCE 'terms' "">"" {builder buildList: terms} |
		""<>""	{builder buildEmptyList} |
		""<"" TERMSEQUENCE 'terms' ""|"" TERM 'term' "">""	{builder buildPair: terms cdr: term};

FUNCTOR : 	CONSTANT 		{#liftFirstValue:}|
			VARIABLE		{#liftFirstValue:};

MESSAGE :	NONRESULTMESSAGE {#liftFirstValue:}|
			RESULTMESSAGE {#liftFirstValue:};

NONRESULTMESSAGE :	KEYWORDEDMESSAGE	{#liftFirstValue:}|
						UNARYMESSAGE		{#liftFirstValue:};

RESULTMESSAGE :	NONRESULTMESSAGE 'msg' ""="" TERM 'result' {builder buildResultMessageTerm: msg resultTerm: result};"