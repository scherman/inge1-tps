!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'J.S 4/13/2019 12:43:16'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:46:24'!
addEntero: anAdder

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:46:33'!
addFraccion: anAdder

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:44:43'!
divideToEntero: aDividend

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:45:04'!
divideToFraccion: aDividend

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:48:12'!
multiplyToEntero: aMultiplicand

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:48:21'!
multiplyToFraccion: aMultiplicand

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:45:57'!
substractToEntero: aMinuhend

	^ self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:46:11'!
substractToFraccion: aMinuhend

	^ self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'comparing' stamp: 'J.S 4/13/2019 18:16:26'!
= anObject

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:08'!
* aMultiplier 

	^aMultiplier multiplyToEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:12'!
+ anAdder 

	^anAdder addEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:14'!
- aSubtrahend 

	^(aSubtrahend substractToEntero: self) ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:44:43'!
/ aDivisor 
	
	^ aDivisor divideToEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/13/2019 12:42:37'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:25'!
addEntero: anAdder

	^ self class superclass with: (value + anAdder integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:30'!
addFraccion: anAdder

	^Fraccion with: (self + (anAdder denominator)) over: anAdder denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 18:18:07'!
asDenominatorOf: aNumerator

	self subclassResponsibility.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:33'!
divideToEntero: aDividend

	^ self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:38'!
divideToFraccion: aDividend

	^ (Fraccion with: (aDividend numerator) over: (aDividend denominator * self))
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/13/2019 01:14:56'!
fibonacci

	^ self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/13/2019 12:57:54'!
greatestCommonDivisorWith: anEntero 
	
	^self class superclass with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:50'!
multiplyToEntero: aMultiplicand

	^ self class superclass with: (value * (aMultiplicand integerValue))! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:54:55'!
multiplyToFraccion: aMultiplicand

	^ Fraccion with: (aMultiplicand numerator * self) over: aMultiplicand denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:00'!
substractToEntero: aMinuhend

	^ self class superclass with: (aMinuhend integerValue - value)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:05'!
substractToFraccion: aMinuhend

	^  (aMinuhend numerator - (self * aMinuhend denominator)) / aMinuhend denominator! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'J.S 4/13/2019 11:56:43'!
isGreaterThanOne
^ (value > 1)! !

!Entero methodsFor: 'testing' stamp: 'J.S 4/13/2019 17:10:31'!
isNegative
	
	^ self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:10:20'!
isOne
	
	^ self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:10:08'!
isZero
	
	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'J.S 4/13/2019 12:05:30'!
with: aValue 

	| numeroClass |
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	

	numeroClass := self subclasses detect: [ :unNumeroClass | unNumeroClass representaA: aValue ].
	^numeroClass new initalizeWith: aValue! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'J.S 4/13/2019 13:51:53'!
/ aDivisor
^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 18:18:07'!
asDenominatorOf: aNumerator

	^ self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:51:42'!
divideToEntero: aDividend

	^ self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:45:04'!
divideToFraccion: aDividend

	^ self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:51:49'!
fibonacci

	^ self class superclass with: 1! !


!Cero methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:10:31'!
isOne
^false! !

!Cero methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:09:25'!
isZero
^ true! !

!Cero methodsFor: 'testing' stamp: 'J.S 4/13/2019 17:11:02'!
îsNegative
^false! !


!Cero methodsFor: 'value' stamp: 'J.S 4/13/2019 01:12:35'!
integerValue
^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'J.S 4/13/2019 12:04:24'!
representaA: aValue
^ (aValue = 0)! !


!classDefinition: #EnteroMayorAUno category: #'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 18:18:07'!
asDenominatorOf: aNumerator
	
	^ Fraccion new initializeWith: aNumerator over: self! !

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 18:18:07'!
divideToEntero: aDividend

	| denominator greatestCommonDivisor numerator |
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: self. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.
	
	^denominator asDenominatorOf: numerator.
	"(denominator integerValue = 1) ifTrue: [^numerator].
	^ Fraccion with: numerator over: denominator"! !

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:51:27'!
fibonacci

	|uno dos|
	uno := self class superclass with: 1.
	dos := self class superclass with: 2.

	^ (self - uno) fibonacci + (self - dos) fibonacci! !


!EnteroMayorAUno methodsFor: 'testing' stamp: 'J.S 4/13/2019 17:10:41'!
isNegative
^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:10:41'!
isOne
^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:09:56'!
isZero
^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: #'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'J.S 4/13/2019 12:05:00'!
representaA: aValue
^ (aValue > 1)! !


!classDefinition: #EnteroNegativo category: #'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'testing' stamp: 'J.S 4/13/2019 17:10:50'!
isNegative
^true! !

!EnteroNegativo methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:10:49'!
isOne
^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'J.S 4/13/2019 12:09:47'!
isZero 
^ false! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:52:08'!
divideToEntero: aDividend

	^ aDividend negated / self negated! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:52:06'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: #'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'J.S 4/13/2019 12:05:15'!
representaA: aValue
^ (aValue < 0)! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'testing' stamp: 'J.S 4/14/2019 17:53:27'!
isNegative

	^false! !

!Uno methodsFor: 'testing' stamp: 'J.S 4/14/2019 17:53:38'!
isOne

	^true! !

!Uno methodsFor: 'testing' stamp: 'J.S 4/14/2019 17:53:47'!
isZero

	^ false! !


!Uno methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 18:18:07'!
asDenominatorOf: aNumerator

	^ aNumerator! !

!Uno methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:52:17'!
divideToEntero: aDividend

	^aDividend! !

!Uno methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:52:26'!
fibonacci

	^ self! !


!Uno methodsFor: 'value' stamp: 'J.S 4/14/2019 17:53:13'!
integerValue

	^ 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'J.S 4/13/2019 12:04:44'!
representaA: aValue
^ (aValue = 1)! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:13'!
* aMultiplier 

	^aMultiplier multiplyToFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:46:33'!
+ anAdder 
	
	^anAdder addFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:46:11'!
- aSubtrahend 
	
	^ aSubtrahend substractToFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:25'!
/ aDivisor
 
	^aDivisor divideToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:30'!
addEntero: anAdder

	^ self class with: (numerator + (anAdder * denominator)) over: denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:46:33'!
addFraccion: anAdder 
	
	| newNumerator newDenominator |
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:42'!
divideToEntero: aDividend

	^ self class with: aDividend * denominator over: numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:44'!
divideToFraccion: aDividend

	^(aDividend numerator * denominator) / (aDividend denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:49'!
multiplyToEntero: aMultiplicand

	^ (numerator * aMultiplicand) / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:52'!
multiplyToFraccion: aMultiplicand

	^ (numerator * (aMultiplicand numerator)) / (denominator * (aMultiplicand denominator))
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:55:56'!
substractToEntero: aMinuhend

	^ self class with:  (aMinuhend * denominator) -numerator over: denominator  ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'J.S 4/14/2019 17:56:01'!
substractToFraccion: aMinuhend

	| newNumerator newDenominator |
	newNumerator := (aMinuhend numerator * denominator) - (aMinuhend denominator * numerator).
	newDenominator := aMinuhend denominator * denominator.
	
	^newNumerator / newDenominator
! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'J.S 4/14/2019 17:26:31'!
with: aDividend over: aDivisor
	^aDividend / aDivisor
	! !
