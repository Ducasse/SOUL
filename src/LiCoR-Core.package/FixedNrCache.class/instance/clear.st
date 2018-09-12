adding-removing
clear
	"clear the contents of the receiver"

	
	self elements keys copy do: [:key | self basicRemoveKey: key].
	order := nil