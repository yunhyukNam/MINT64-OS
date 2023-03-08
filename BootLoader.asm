[ORG 0x00]          ; 코드의 시작 어드레스를 0x00으로 설정
[BITS 16]           ; 이하의 코드는 16비트 코드로 설정

SECTION .text       ; text 섹션(세그먼트)을 정의

jmp 0x07C0:START    ; cs 레지스터에 0x07C0을 복사하면서 START Label로 이동

START:
    mov ax, 0x07C0  ; BootLoader의 시작 Addr(0x07C0)을 세그먼트 레지스터 값으로 변환
    mov ds, ax      ; ds 레지스터에 설정

mov ax, 0xB800      ; ax 레지스터에 0xB800 복사
mov ds, ax          ; ds 레지스터에 ax의 값 복사

mov byte [ 0x00 ], 'M'    ; ds segment:오프셋 0xB800:0x0000에 "M"을 복사
mov byte [ 0x01 ], 0x4A   ; ds segment:오프셋 0xB800:0x0001에 0x4A(빨간 배경에 녹색 글자)

jmp $               ; 현재 위치에서 무한 루프 수행

times 510 - ( $ - $$ )  db  0x00    ; $: 현재 라인의 어드레스
                                    ; $$: 현재 섹션(.text)의 시작 어드레스
                                    ; $ - $$: 현재 섹션을 기준으로 하는 오프셋
                                    ; 510 - ( $ - $$ ): 현재부터 어드레스 510까지
                                    ; db 0x00: 1바이트를 선언하고 값은 0x00
                                    ; time: 반복 수행
                                    ; 현재 위치에서 어드레스 510까지 0x00으로 채움

db 0x55             ; 1바이트를 선언하고 값은 0x55
db 0xAA             ; 1바이트를 선언하고 값은 0xAA
                    ; 어드레스 511, 512에 0x55, 0xAA를 써서 부트 섹터로 표기함