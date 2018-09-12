method attributes
methodHasAnnotationXwithValuesXM3

"This predicate retrieves all ?Annotations of a ?Method, together with the list of ?Values of that annotation"

?Method methodHasAnnotation: ?Annotation withValues: ?Values if 
	?Method isMethod,[MLI forSmalltalk annotationsOfMethod: ?Method] contains: ?association,?Annotation equals: [?association key],?Values equals: [?association value]