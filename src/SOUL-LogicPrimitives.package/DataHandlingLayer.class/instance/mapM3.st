soul auto saved
mapM3

"sequential call of the predicate on the lists, with element of first list as first arg and element of second list as second arg"

map(<>,<>,?).
map(<?elfirst|?restfirst>,<?elsecond|?restsecond>,?predicate) if 
	?predicate(?elfirst,?elsecond),map(?restfirst,?restsecond,?predicate)