.device ATmega328P
.org 0
rjmp Main 

; V e c t o r de INT0 ( p i n PD2)
.org INT0addr
rjmp IntV0

;Inicializa stack
Main : 
ldi R16 , low (RAMEND)
out SPL , R16
ldi R16 , high (RAMEND)
out SPH, R16
call INIT IRQ INT0
clr R16
sbi DDRB, 0 ; PORTB pin 8 como salida
sbi DDRB, 1 ; PORTB pin 9 como salida
cbi DDRD, 2 ; PORTD pin 4 como entrada
sbi PORTD, 2 ; PORTD RESISTENCIA PULLUP
sei ; Hab . global de interrupciones
sbi PORTB, 0 ; Enciendo el LED DEL pin8

loop :
rjmp loop ;GENERO UN LOOP PARA ESPERAR LA INTERRUPCION

IntV0 :
CALL DELAY
sbis PORTD, 2
call INTERVALO
reti

INTERVALO:
cbi PORTB, 0
call ENCEDER LED INT
sbi PORTB, 0
ret

ENCEDER LED INT :
LDI R22 , 5
LOP 1 :
sbi PORTB, 1
CALL DELAY
cbi PORTB, 1
CALL DELAY
DEC R22
BRNE LOP 1
RET

DELAY:
ldi r18 , 41
ldi r19 , 150
ldi r20 , 128

L1 : 
dec r20
brne L1
dec r 1 9
brne L1
dec r 1 8
brne L1
ret


;Configur a INT0 con el flanco ascendente
INIT IRQ INT0 :
ldi R16 , (1<<ISC01 )|(1 < < ISC00 ) ; flanco ascendente
sts EICRA, R16
ldi R16 , (1<<INT0 )
out EIMSK, R16
RET


