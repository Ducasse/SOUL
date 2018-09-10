soul auto saved
concatQuotedTermsM3

"concatQuotedTerms(?ListOfQuotedTerms,?Separator, ?QuotedTerm) turns a ?ListOfQuotedTerms 
	 into a ?QuotedTerm with all those ?QuotedTerms in the order in which they
	 appear in the list separated by a ?Separator. No extra ?Separator at the end is
	 produced.

Note: a variant of this predicate that works on strings instead of quoted code terms is listAsSeparatedString/3

Special case: needed for when the empty list is passed as argument."

concatQuotedTerms(<>,?,{}).
"Ordinary Cases"

concatQuotedTerms(<?QuotedTerm>,?Separator,{?QuotedTerm}).
concatQuotedTerms(<?QuotedTerm|?OtherQuotedTerms>,?Separator,{?QuotedTerm?Separator?Rest}) if 
	nonEmptyList(?OtherQuotedTerms),concatQuotedTerms(?OtherQuotedTerms,?Separator,?Rest)