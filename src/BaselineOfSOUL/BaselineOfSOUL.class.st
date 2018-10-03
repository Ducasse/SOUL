Class {
	#name : #BaselineOfSOUL,
	#superclass : #BaselineOf,
	#category : 'BaselineOfSOUL'
}

{ #category : #baselines }
BaselineOfSOUL >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec baseline: 'SmaCC' with: [
				spec
					repository: 'github://ThierryGoubier/SmaCC'
					].
				].
		spec
			package: 'SOUL-Kernel';
			package: 'SOUL-EvalPrintLoop';
			package: 'SOUL-Parsers' with: [ spec requires: #( 'SmaCC' ) ];
			package: 'SOUL-GrammarClauses';
			package: 'SOUL-GrammarTerms';
			package: 'SOUL-NativeClauses';
			package: 'SOUL-Repositories';
			package: 'SOUL-SmalltalkSymbiosis';
			package: 'SOUL-LogicPrimitives' with: [ spec requires: #('SOUL-Parsers') ];
			package: 'SOUL-Tests' with: [  spec requires: #('SOUL-Kernel' 'SOUL-LogicPrimitives') ].
			
		spec 
			package: 'LiCoR-Core' with: [ spec requires: #('SOUL-Kernel' 'SOUL-Parsers' 'SOUL-Repositories') ];
			package: 'LiCoR-Predicates' with: [ spec requires: #('LiCoR-Core') ];
			package: 'LiCoR-Tests' with: [ spec requires: #('LiCoR-Core' 'LiCoR-Predicates' 'SOUL-Tests') ].
			
		spec
			group: 'Core' 
			with: #('SOUL-Kernel' 'SOUL-EvalPrintLoop' 'SOUL-Parsers' 'SOUL-GrammarClauses' 'SOUL-GrammarTerms' 'SOUL-NativeClauses' 'SOUL-Repositories' 'SOUL-SmalltalkSymbiosis' 'SOUL-LogicPrimitives').
		
		spec 
			group: 'LiCoR'
			with: #('Core' 'LiCoR-Core' 'LiCoR-Predicates').
		
		spec 
			group: 'development'
			with: #('Core' 'LiCoR' 'SOUL-Tests' 'LiCoR-Tests')
			
]
