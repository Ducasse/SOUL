template parsing
stTemplateSelectorM3

stTemplateSelector(methodHeader(?selector,?args),?tokens1,?tokens5) if 
	stWordterminal(?selector,?tokens1,?tokens2),equals(?tokens2,<leftParenthesis(?)|?tokens3>),stTemplateSelectorArgumentList(?args,?tokens3,?tokens4),equals(?tokens4,<rightParenthesis(?)|?tokens5>)