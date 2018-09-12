entities
isClassCategoryM1

"Is ?Category a class category
CASE 1: ?Category is not bound"

-?Category isClassCategory if 
	member(?Category,[MLI forSmalltalk allCategoryEntities]).
"Is ?Category a class category
CASE 2: ?Category is  bound"

+?Category isClassCategory if 
	[MLI forSmalltalk isCategory: ?Category]