methods
isOverriddenSelectorInClassXM2

"Is ?Selector an overridden selector in class ?Class?"

?Selector isOverriddenSelectorInClass: ?Class if 
	?Class classImplementsSelector: ?Selector,?Super isSuperclassOf: ?Class,?Super classUnderstandsSelector: ?Selector