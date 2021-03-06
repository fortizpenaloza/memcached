"
Unit tests for MDNullCodec
"
Class {
	#name : #MDNullCodecTest,
	#superclass : #TestCase,
	#instVars : [
		'codec'
	],
	#category : #'Memcached-Tests'
}

{ #category : #running }
MDNullCodecTest >> setUp [
	codec := MDNullCodec new
]

{ #category : #testing }
MDNullCodecTest >> testEncodeNegativeInteger [

	self assert: (codec encodeInteger: -1) equals: #(2r11111111) asByteArray.
	self assert: (codec encodeInteger: -2) equals: #(2r11111110) asByteArray.
	self assert: (codec encodeInteger: -128) equals: #(2r10000000) asByteArray.
	self assert: (codec encodeInteger: -129) equals: #(2r11111111 2r01111111) asByteArray.
	self assert: (codec encodeInteger: -130) equals: #(2r11111111 2r01111110) asByteArray
]

{ #category : #testing }
MDNullCodecTest >> testEncodePositiveInteger [

	self assert: (codec encodeInteger: 5) equals: #(5) asByteArray.
	self assert: (codec encodeInteger: 128) equals: #(1 0) asByteArray.
	self assert: (codec encodeInteger: 129) equals: #(1 1) asByteArray
]

{ #category : #testing }
MDNullCodecTest >> testFloat [

	#('abc') with: #((97 98 99)) do: [ :value :expected |
		| actual |
		actual := codec encodeString: value.
		self assert: actual equals: expected asByteArray.
		self assert: value equals: (codec decodeString: actual) ]
]

{ #category : #testing }
MDNullCodecTest >> testString [

	#('abc' 'Ã¤Ã¶Ã¼') with: #((97 98 99) (195 164 195 182 195 188)) do: [ :value :expected |
		| actual |
		actual := codec encodeString: value.
		self assert: actual equals: expected asByteArray.
		self assert: value equals: (codec decodeString: actual) ]
	
	"#(16rE4 16rF6 16rFC) collect: [ :each |
		(String with: (Character value: each)) convertToEncoding: #utf8 ]"
]
