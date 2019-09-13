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
SpPlaybookMillerPresenter >> addPage: aPagePresenter [

	aPagePresenter owner: self.
	layout 
		add: aPagePresenter
		withConstraints: [ :c |
			c 
				expand: false;
				height: self pageSize ]
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
