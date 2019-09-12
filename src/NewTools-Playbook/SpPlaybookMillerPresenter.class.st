Class {
	#name : #SpPlaybookMillerPresenter,
	#superclass : #SpMillerColumnPresenter,
	#category : #'NewTools-Playbook'
}

{ #category : #initialization }
SpPlaybookMillerPresenter >> addPresenter: newSubPresenter [

	newSubPresenter owner: self.
	layout add: newSubPresenter
]

{ #category : #initialization }
SpPlaybookMillerPresenter >> initializeWidgets [
	
	layout := SpBoxLayout newVertical
]
