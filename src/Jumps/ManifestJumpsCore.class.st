"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJumpsCore,
	#superclass : #PackageManifest,
	#category : #'Jumps-Manifest'
}

{ #category : #'code-critics' }
ManifestJumpsCore class >> ruleCollectSelectNotUsedRuleV1FalsePositive [

	^ #( #( #( #RGMethodDefinition #( #Jumps #computeJumpsFast:
	              false ) )
	        #'2022-07-14T18:25:32.700875+03:00' )
	     #( #( #RGClassDefinition #( #Jumps ) )
	        #'2022-07-14T18:25:39.747879+03:00' ) )
]

{ #category : #'code-critics' }
ManifestJumpsCore class >> ruleLongMethodsRuleV1FalsePositive [

	^ #( #( #( #RGMethodDefinition #( #Jumps #computeJumpsFast:
	              false ) )
	        #'2022-07-14T22:51:27.40674+03:00' )
	     #( #( #RGMethodDefinition #( #JumpsTest #testComputeFastFourElements
	              false ) )
	        #'2022-07-18T16:41:03.388757+03:00' ) )
]

{ #category : #'code-critics' }
ManifestJumpsCore class >> ruleReTemporaryNeitherReadNorWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JumpsTest #testComputeSlowVsFastWith100000Random #false)) #'2022-07-19T06:42:58.11019+03:00') )
]

{ #category : #'code-critics' }
ManifestJumpsCore class >> ruleSentNotImplementedRuleV1FalsePositive [

	^ #( #( #( #RGMethodDefinition #( #JumpsTest #testInitializationIsOk
	              false ) )
	        #'2022-07-18T23:07:50.305238+03:00' ) )
]

{ #category : #'code-critics' }
ManifestJumpsCore class >> ruleUtilityMethodsRuleV1FalsePositive [

	^ #( #( #( #RGMethodDefinition #( #Jumps #computeJumpsSlow:
	              false ) )
	        #'2022-07-18T14:37:21.709864+03:00' ) )
]
