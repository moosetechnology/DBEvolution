Class {
	#name : #DBEEvolutionDescriber,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sequenceOperatorPresenter',
		'impactedEntitiesPresenter',
		'recommandationsPresenter'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEEvolutionDescriber class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :mainRow |
			mainRow
				newRow: #sequenceOperatorPresenter;
				newRow: #impactedEntitiesPresenter;
				newRow: #recommandationsPresenter ];
		yourself
]

{ #category : #adapting }
DBEEvolutionDescriber >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	
	self sequenceOperatorPresenter
		whenSelectedItemChanged: [ :selectedOperator |
			self impactedEntitiesPresenter
				adaptToCollectionOfDBERecommandations: selectedOperator recommandations ]
		ifUnselected: [ self impactedEntitiesPresenter unselect ].
	
	self impactedEntitiesPresenter 
		whenSelectedItemChanged: [ :selectedDBERecommandation |
			self recommandationsPresenter
				adaptToCollectionOfDBEOperators: selectedDBERecommandation operators ]
		ifUnselected: [ self impactedEntitiesPresenter unselect ].
	
	self recommandationsPresenter
		whenSelectedItemChanged: [ :selectedDBEOperator |
			self halt: #TODO ]
		ifUnselected: [ self flag: #TODO ].
	
	self sequenceOperatorPresenter
		adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator
]

{ #category : #accessing }
DBEEvolutionDescriber >> impactedEntitiesPresenter [
	^ impactedEntitiesPresenter
]

{ #category : #initialization }
DBEEvolutionDescriber >> initializeWidgets [
	self title: 'DB Evolution' translated.
	
	sequenceOperatorPresenter := self instantiate: DBESequenceOperatorPresenter.
	
	impactedEntitiesPresenter := self instantiate: DBEImpactedEntitiesPresenter.
	
	recommandationsPresenter := self instantiate: DBERecommandationsPresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> recommandationsPresenter [
	^ recommandationsPresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> sequenceOperatorPresenter [
	^ sequenceOperatorPresenter
]