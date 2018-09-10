template conversion
template2queryM2

template2query(?template,?query) if 
	parse(stmethod,?template,?tree),tree2query(?tree,?query)