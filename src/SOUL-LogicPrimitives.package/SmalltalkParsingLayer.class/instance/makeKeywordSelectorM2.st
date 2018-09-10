template parsing
makeKeywordSelectorM2

makeKeywordSelector(+?list,?selector) if 
	not(equals(?list,<>)),equals(?selector,[| theSelector |
theSelector := ''.
?list listDo: [:el | theSelector := theSelector , el smalltalkValue].
theSelector asSymbol])