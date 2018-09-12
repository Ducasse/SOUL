reification - entities
allMetaClassEntities
	"Returns a collection containing all the Smalltalk meta classes."

	
	^self allBaseClassEntities collect: [:aClass | aClass class]