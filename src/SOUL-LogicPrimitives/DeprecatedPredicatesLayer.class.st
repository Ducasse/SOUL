Class {
	#name : #DeprecatedPredicatesLayer,
	#superclass : #LogicStorage,
	#category : 'SOUL-LogicPrimitives'
}

{ #category : #'soul auto saved' }
DeprecatedPredicatesLayer >> fooXbarXselXM3 [

foo: bla bar: test sel: goo
]

{ #category : #'soul auto saved' }
DeprecatedPredicatesLayer >> linksToXM2 [

(?fromFeature ?edge: ?toFeatures) linksTo: ?feature if 
	(?fromFeature ?edge: ?toFeatures) isFeatureEdgeSetFrom: ?fromFeature,?toFeatures contains: ?feature
]
