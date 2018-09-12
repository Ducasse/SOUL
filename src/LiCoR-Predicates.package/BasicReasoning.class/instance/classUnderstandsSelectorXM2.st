classes
classUnderstandsSelectorXM2

"Class ?Class understands a message with selector ?Selector.
So the class implements the selector itself, or it is implemented by one of its superclasses.

Case 1: ?Selector is bound"

?Class classUnderstandsSelector: +?Selector if 
	?Class isClass,[MLI forSmalltalk class: ?Class understands: ?Selector].
"Class ?Class understands a message with selector ?Selector.
So the class implements the selector itself, or it is implemented by one of its superclasses.

Case 2: ?Selector is not bound"

?Class classUnderstandsSelector: -?Selector if 
	?Class isClass,[MLI forSmalltalk allSelectorsUnderstoodByClass: ?Class] contains: ?Selector