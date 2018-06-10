private - storage
reReadAllStorage
	
	self reReadFromStorage.
	self subclasses do: [:class | class reReadAllStorage]