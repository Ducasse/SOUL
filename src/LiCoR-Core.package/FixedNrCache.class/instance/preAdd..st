private
preAdd: anElement
	"perform the necessary changes in the structure knowing that anElement is 
	going to be added. Do not add this element yet !"

	
	(self isRemovalNecessaryFor: anElement)
		ifTrue:
			["remove an element to make room for the one that is going to be added"

			self removeFor: anElement]