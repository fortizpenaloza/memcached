"
I hold setting related to the memcached client (unused for now)
"
Class {
	#name : #MDSettings,
	#superclass : #Object,
	#category : #'Memcached-Core'
}

{ #category : #'as yet unclassified' }
MDSettings >> noStringEncoding [
	^false
]

{ #category : #'as yet unclassified' }
MDSettings >> use32BitFlags [
	^false
]
