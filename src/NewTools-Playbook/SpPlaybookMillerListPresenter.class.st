Class {
	#name : #SpPlaybookMillerListPresenter,
	#superclass : #SpMillerColumnPresenter,
	#instVars : [
		'paginator',
		'pageSize',
		'shownPages',
		'pages'
	],
	#category : #'NewTools-Playbook'
}

{ #category : #defaults }
SpPlaybookMillerListPresenter class >> defaultPageSize [

	^ 300
]

{ #category : #defaults }
SpPlaybookMillerListPresenter class >> defaultShowPages [

	^ 2
]

{ #category : #initialization }
SpPlaybookMillerListPresenter >> addPresenter: aPagePresenter [
	| newPageSize |

	newPageSize := self recalculateSizeForPages: pages size + 1.
	self updateForPages: pages size + 1.
	self basicAddPresenter: aPagePresenter size: newPageSize.
	pages add: aPagePresenter.

	aPagePresenter takeKeyboardFocus
]

{ #category : #private }
SpPlaybookMillerListPresenter >> basicAddPresenter: aPagePresenter size: aNumber [
	
	aPagePresenter owner: self.
	layout 
		add: aPagePresenter
		withConstraints: [ :constraint | 
			constraint 
				expand: false; 
				height: aNumber ]
]

{ #category : #initialization }
SpPlaybookMillerListPresenter >> initialize [ 

	pages := OrderedCollection new.
	super initialize
]

{ #category : #initialization }
SpPlaybookMillerListPresenter >> initializePresenters [
	
	layout := SpBoxLayout newVertical
]

{ #category : #initialization }
SpPlaybookMillerListPresenter >> newPresenterFor: aModel [
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
SpPlaybookMillerListPresenter >> pageSize [

	^ pageSize ifNil: [ pageSize := self class defaultPageSize ]
]

{ #category : #accessing }
SpPlaybookMillerListPresenter >> pageSize: aNumber [

	pageSize := aNumber.
	self reset
]

{ #category : #accessing }
SpPlaybookMillerListPresenter >> pages [

	^ pages
]

{ #category : #accessing }
SpPlaybookMillerListPresenter >> paginator: aPaginator [

	"To avoid cycles"
	paginator = aPaginator ifTrue: [ ^ self ].
	
	paginator := aPaginator.
	aPaginator millerList: self
]

{ #category : #private }
SpPlaybookMillerListPresenter >> recalculateSizeForPages: aNumber [
	
	^ aNumber > 1
		ifTrue: [ (self pageSize / (aNumber min: self shownPages)) asInteger ]
		ifFalse:[ self pageSize ]
]

{ #category : #private }
SpPlaybookMillerListPresenter >> reset [

	self updateForPages: pages size
]

{ #category : #private }
SpPlaybookMillerListPresenter >> resetTo: aNumber [

	super resetTo: aNumber.
	pages := pages first: aNumber	
]

{ #category : #accessing }
SpPlaybookMillerListPresenter >> shownPages [
	
	^ shownPages ifNil: [ shownPages := self class defaultShowPages ]
]

{ #category : #accessing }
SpPlaybookMillerListPresenter >> shownPages: aNumber [
	
	shownPages := aNumber.
	self reset
]

{ #category : #private }
SpPlaybookMillerListPresenter >> updateForPages: aNumber [
	| newPageSize |

	newPageSize := self recalculateSizeForPages: aNumber.
	newPageSize = self pageSize 
		ifFalse: [ self updatePageSizesTo: newPageSize ]
]

{ #category : #private }
SpPlaybookMillerListPresenter >> updatePageSizesTo: aNumber [

	layout removeAll.
	pages do: [ :each | 
		self basicAddPresenter: each size: aNumber ]
]
