"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJumpsTests,
	#superclass : #PackageManifest,
	#category : #'Jumps-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestJumpsTests class >> ruleSentNotImplementedRuleV1FalsePositive [

	^ #( #( #( #RGMethodDefinition #( #JumpsTest #testInitializationIsOk
	              false ) )
	        #'2022-07-13T11:51:07.987001+03:00' )
	     #( #( #RGMethodDefinition #( #JumpsTest #testComputeSlow
	              false ) )
	        #'2022-07-13T15:45:19.554244+03:00' ) )
]
