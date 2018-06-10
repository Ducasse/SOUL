printing
prettyPrintOn: aStream scope: id
	"see comment in AbstractTerm"
	aStream withAttribute: (TextColor red) do: [aStream write: '-?' , name]
	