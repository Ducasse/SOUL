classes
classInheritsFromXM2

"The class ?Sub belongs to the class hierarchy below ?Super, but excluding the class ?Super itself."

?Sub classInheritsFrom: ?Super if 
	?Sub isClassInHierarchyOf: ?Super,not(?Sub equals: ?Super)