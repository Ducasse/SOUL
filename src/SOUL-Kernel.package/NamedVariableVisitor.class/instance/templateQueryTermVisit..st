visiting terms
templateQueryTermVisit: aTemplateQueryTerm
	
	aTemplateQueryTerm content do: [:subterm | subterm accept: self].
	aTemplateQueryTerm variables do: [:subterm | subterm accept: self].
	aTemplateQueryTerm parsetrees do: [:tree | tree accept: self].
	aTemplateQueryTerm queries do: [:query | (query at: 1) accept: self].
	aTemplateQueryTerm type accept: self