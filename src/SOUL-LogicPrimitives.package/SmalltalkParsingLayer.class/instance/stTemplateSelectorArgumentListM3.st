template parsing
stTemplateSelectorArgumentListM3

stTemplateSelectorArgumentList(<?arg>,?tokens1,?tokens2) if 
	stWordterminal(?arg,?tokens1,?tokens2).
stTemplateSelectorArgumentList(<?arg|?rest>,?tokens1,?tokens4) if 
	stWordterminal(?arg,?tokens1,?tokens2),equals(?tokens2,<binary([#,])|?tokens3>),stTemplateSelectorArgumentList(?rest,?tokens3,?tokens4).
stTemplateSelectorArgumentList(?arg,?tokens1,?tokens2) if 
	soulListvariable(?arg,?tokens1,?tokens2).
stTemplateSelectorArgumentList(<?arg>,?tokens1,?tokens2) if 
	stVariable(?arg,?tokens1,?tokens2).
stTemplateSelectorArgumentList(<?arg|?rest>,?tokens1,?tokens4) if 
	stVariable(?arg,?tokens1,?tokens2),equals(?tokens2,<binary([#,])|?tokens3>),stTemplateSelectorArgumentList(?rest,?tokens3,?tokens4)