method attributes
methodContainsSourceCommentXM2

"Is ?Comment a comment in the source code of method ?Method"

?Method methodContainsSourceComment: ?Comment if 
	?Method isMethod,[MLI forSmalltalk sourceCommentsForMethod: ?Method] contains: ?Comment