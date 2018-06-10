building SmalltalkTerm/QuotedCode
buildTemplateQuery: source type: aType
	^ SoulFactory current makeTemplateQuery source: (source copyFrom: 2 to: source size - 1) type: aType