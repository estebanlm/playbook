Class {
	#name : #SpPlaybookMillerPresenter,
	#superclass : #SpMillerColumnPresenter,
	#instVars : [
		'pageSize'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #accessing }
SpPlaybookMillerPresenter class >> defaultPageSize [

	^ 250
]

{ #category : #initialization }
SpPlaybookMillerPresenter >> addPresenter: newSubPresenter [

	newSubPresenter owner: self.
	layout 
		add: newSubPresenter
		withConstraints: [ :c |
			c 
				expand: false;
				height: self pageSize ]
]

{ #category : #initialization }
SpPlaybookMillerPresenter >> initializeWidgets [
	
	layout := SpBoxLayout newVertical
]

{ #category : #accessing }
SpPlaybookMillerPresenter >> pageSize [

	^ pageSize ifNil: [ pageSize := self class defaultPageSize ]
]

{ #category : #accessing }
SpPlaybookMillerPresenter >> pageSize: aNumber [

	pageSize := aNumber
]
