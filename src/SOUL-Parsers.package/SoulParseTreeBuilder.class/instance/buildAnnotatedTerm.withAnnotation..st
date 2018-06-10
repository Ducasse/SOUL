building annotated SOUL
buildAnnotatedTerm: aTerm withAnnotation: anAnnotationTerm
	
	^SoulFactory current makeAnnotatedTerm term: aTerm annotation:
			anAnnotationTerm