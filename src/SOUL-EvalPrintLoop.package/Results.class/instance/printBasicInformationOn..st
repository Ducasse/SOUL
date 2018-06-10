printing
printBasicInformationOn: aStream
	
	results isEmpty
		ifTrue:
			[aStream write: '['.
			self success printOn: aStream.
			aStream write: ']']
		ifFalse:
			[| keys values |
			keys := OrderedCollection new.
			values := OrderedCollection new.
			results
				keysAndValuesDo:
					[:key :value | 
					keys add: key.
					values add: value].
			1
				to: self size
				do:
					[:resultIndex | 
					| keyIndex |
					aStream write: '['.
					keyIndex := 1.
					keys
						do:
							[:key | 
							(Binding
								var: key
								value: ((values at: keyIndex) at: resultIndex)) printOn: aStream.
							keyIndex := keyIndex + 1]
						separatedBy:
							[aStream
								write: ',';
								cr].
					aStream
						write: ']';
						cr;
						cr]]