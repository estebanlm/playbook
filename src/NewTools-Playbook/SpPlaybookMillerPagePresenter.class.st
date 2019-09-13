Class {
	#name : #SpPlaybookMillerPagePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'presenter',
		'expandButton',
		'expandAction'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #specs }
SpPlaybookMillerPagePresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #presenter;
		addLast: #expandButton expand: false fill: false padding: 0;
		yourself
]

{ #category : #'instance creation' }
SpPlaybookMillerPagePresenter class >> newModel: aModel presenter: aPresenter [

	^ self basicNew 
		setModelBeforeInitialization: aModel;
		setPresenterBeforeInitialization: aPresenter;
		initialize
]

{ #category : #actions }
SpPlaybookMillerPagePresenter >> doExpand [ 

	expandAction ifNil: [ ^ self ].
	expandAction cull: self
]

{ #category : #initialization }
SpPlaybookMillerPagePresenter >> initializeWidgets [

	expandButton := self newButton
		icon: (self application iconNamed: #glamorousDown);
		action: [ self doExpand ];
		yourself
]

{ #category : #accessing }
SpPlaybookMillerPagePresenter >> model [
	^ model
]

{ #category : #events }
SpPlaybookMillerPagePresenter >> onExpand: aBlock [

	expandAction := aBlock
]

{ #category : #accessing }
SpPlaybookMillerPagePresenter >> presenter [
	^ presenter
]

{ #category : #'accessing model' }
SpPlaybookMillerPagePresenter >> setModelBeforeInitialization: aModel [

	model := aModel
]

{ #category : #'accessing model' }
SpPlaybookMillerPagePresenter >> setPresenterBeforeInitialization: aPresenter [

	presenter := aPresenter.
	presenter owner: self
]
