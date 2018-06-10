private
processWaitList
	
	WaitList do: [:block | block value].
	WaitList := OrderedCollection new