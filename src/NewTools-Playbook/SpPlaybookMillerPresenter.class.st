Class {
	#name : #SpPlaybookMillerPresenter,
	#superclass : #SpMillerColumnPresenter,
	#instVars : [
		'pageSize',
		'shownPages'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #defaults }
SpPlaybookMillerPresenter class >> defaultPageSize [

	^ 300
]

{ #category : #defaults }
SpPlaybookMillerPresenter class >> defaultShowPages [

	^ 2
]

{ #category : #initialization }
SpPlaybookMillerPresenter >> addPresenter: aPagePresenter [

	aPagePresenter owner: self.
	layout 
		add: aPagePresenter
		withConstraints: [ :c |
			c 
				expand: false;
				height: self pageSize ].
		
	aPagePresenter takeKeyboardFocus
]

{ #category : #initialization }
SpPlaybookMillerPresenter >> initializeWidgets [
	
	layout := SpBoxLayout newVertical
]

{ #category : #initialization }
SpPlaybookMillerPresenter >> newPresenterFor: aModel [
	| pagePresenter contentPresenter |
	
	contentPresenter := super newPresenterFor: aModel.
	pagePresenter := SpPlaybookMillerPagePresenter 
		newModel: aModel
		presenter: contentPresenter.
		
	pagePresenter onExpand: [ 
		self changeSelection: aModel from: pagePresenter ].
		
	^ pagePresenter
]

{ #category : #accessing }
SpPlaybookMillerPresenter >> pageSize [

	^ pageSize ifNil: [ pageSize := self class defaultPageSize ]
]

{ #category : #accessing }
SpPlaybookMillerPresenter >> pageSize: aNumber [

	pageSize := aNumber
]

{ #category : #accessing }
SpPlaybookMillerPresenter >> shownPages [
	
	^ shownPages ifNil: [ shownPages := self class defaultShowPages ]
]
