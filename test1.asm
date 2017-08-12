;
;	initialize pic microchip
;
MAIN
	movlw	b'00000111'
	movwf	CMCON0

	bsf	STATUS,RP0
	
	movlw	B'00111000'
	movwf	TRISI0

	movlw	B'01110000'
	movwf	OSCCON

	movlw	B'00001000'
	movwf	WPU

	movlw	B'00000111'
	movwf	IOC

	movlw	B'01011000'
	movwf	ANSEL

	bcf	STATUS,RP0
	
	movlw	B'10001000'
	movwf	INTCON

	movlw	B'00001100'
	
	movwf	ADCON0

	clrf	GPIO
;
;	set pwm
;
;set frequency
	bsf STATUS,RP0
	movlw	0xFA
	movwf	PR2
	bcf	STATUS,RP0

;set duty
	movlw	0x60
	movwf	CCPR1L

	movlw	0x0C
	movwf	CCP1CON

	movlw	B'00000101'
	movwf	T2CON

;
;	tmr1 init
;

	clrf	T1CON

	movlw	B'00000111'
	movwf	T1CON


;
;	main loop
;

	movlw	0x0C
	movwf	ON_TIME2

MAIN_LOOP1
	movlw	0xFF
	movwf	ON_TIME1

MAIN_LOOP2
	movlw	D'60'
	movwf	LOOP1

	clrf	TMR1H
	clrf	TMR1L

LOOP_1
	call	SOUND_MONITOR
	call	BRIGHT_CONTROL

	bcf	GPIO,0
	bsf	GPIO,1
	call	WAIT5MS

	call	SOUND_MONITOR
	call	BRIGHT_CONTROL
	
	bsf	GPIO,0
	bcf	GPIO,1
	call	WAIT5MS

	decfsz	LOOP1,F
	goto	LOOP_1

	movfw	TMR1L
	movwf	TMR1_L

	call	FREQ_MONITOR

	decfsz	ON_TIME1,F
	goto	MAIN_LOOP2

	decfsz	ON_TIME2,F
	goto	MAIN_LOOP1
	
	call	FLASH_MODE7

	goto	MAIN_LOOP1





	



	




	