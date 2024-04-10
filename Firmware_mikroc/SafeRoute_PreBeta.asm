
_ResetVars:

;SafeRoute_PreBeta.c,134 :: 		void ResetVars(){
;SafeRoute_PreBeta.c,136 :: 		secondsHeat = 0;
	CLRF        _secondsHeat+0 
	CLRF        _secondsHeat+1 
;SafeRoute_PreBeta.c,137 :: 		secondsRest = 0;
	CLRF        _secondsRest+0 
	CLRF        _secondsRest+1 
;SafeRoute_PreBeta.c,138 :: 		secondsReading = 0;
	CLRF        _secondsReading+0 
	CLRF        _secondsReading+1 
;SafeRoute_PreBeta.c,139 :: 		auxSecRead =0;
	CLRF        _auxSecRead+0 
	CLRF        _auxSecRead+1 
;SafeRoute_PreBeta.c,140 :: 		secondsAux = 0;
	CLRF        _secondsAux+0 
	CLRF        _secondsAux+1 
;SafeRoute_PreBeta.c,141 :: 		secondsRestAux = 0;
	CLRF        _secondsRestAux+0 
	CLRF        _secondsRestAux+1 
;SafeRoute_PreBeta.c,142 :: 		isRest = 0;
	CLRF        _isRest+0 
;SafeRoute_PreBeta.c,143 :: 		tempAlc = 0;
	CLRF        _tempAlc+0 
	CLRF        _tempAlc+1 
;SafeRoute_PreBeta.c,144 :: 		mglALcohol = 0.00;
	CLRF        _mglALcohol+0 
	CLRF        _mglALcohol+1 
	CLRF        _mglALcohol+2 
	CLRF        _mglALcohol+3 
;SafeRoute_PreBeta.c,145 :: 		gradeAlc = 0;
	CLRF        _gradeAlc+0 
;SafeRoute_PreBeta.c,147 :: 		isPress = 0;
	CLRF        _isPress+0 
;SafeRoute_PreBeta.c,148 :: 		timePress = 0;
	CLRF        _timePress+0 
	CLRF        _timePress+1 
;SafeRoute_PreBeta.c,149 :: 		timesBateryReads = 0;
	CLRF        _timesBateryReads+0 
	CLRF        _timesBateryReads+1 
;SafeRoute_PreBeta.c,150 :: 		batteryPorc = 0.00;
	CLRF        _batteryPorc+0 
	CLRF        _batteryPorc+1 
	CLRF        _batteryPorc+2 
	CLRF        _batteryPorc+3 
;SafeRoute_PreBeta.c,152 :: 		millis = 0;
	CLRF        _millis+0 
	CLRF        _millis+1 
;SafeRoute_PreBeta.c,153 :: 		millisFiveMS =0;
	CLRF        _millisFiveMS+0 
	CLRF        _millisFiveMS+1 
;SafeRoute_PreBeta.c,155 :: 		timeToSend =0;
	CLRF        _timeToSend+0 
	CLRF        _timeToSend+1 
;SafeRoute_PreBeta.c,157 :: 		veces = 0;
	CLRF        _veces+0 
	CLRF        _veces+1 
;SafeRoute_PreBeta.c,158 :: 		v = 0;
	CLRF        _v+0 
	CLRF        _v+1 
;SafeRoute_PreBeta.c,159 :: 		magCol = 0.00;
	CLRF        _magCol+0 
	CLRF        _magCol+1 
	CLRF        _magCol+2 
	CLRF        _magCol+3 
;SafeRoute_PreBeta.c,160 :: 		tempMicro = 0;
	CLRF        _tempMicro+0 
	CLRF        _tempMicro+1 
;SafeRoute_PreBeta.c,181 :: 		}
L_end_ResetVars:
	RETURN      0
; end of _ResetVars

_UART_Send_String:

;SafeRoute_PreBeta.c,183 :: 		void UART_Send_String(char *dat) {
;SafeRoute_PreBeta.c,185 :: 		while (*dat != '#') {
L_UART_Send_String0:
	MOVFF       FARG_UART_Send_String_dat+0, FSR0L+0
	MOVFF       FARG_UART_Send_String_dat+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       35
	BTFSC       STATUS+0, 2 
	GOTO        L_UART_Send_String1
;SafeRoute_PreBeta.c,186 :: 		while(!UART1_Tx_Idle());
L_UART_Send_String2:
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_Send_String3
	GOTO        L_UART_Send_String2
L_UART_Send_String3:
;SafeRoute_PreBeta.c,187 :: 		UART1_Write(*dat);
	MOVFF       FARG_UART_Send_String_dat+0, FSR0L+0
	MOVFF       FARG_UART_Send_String_dat+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SafeRoute_PreBeta.c,188 :: 		dat++;
	INFSNZ      FARG_UART_Send_String_dat+0, 1 
	INCF        FARG_UART_Send_String_dat+1, 1 
;SafeRoute_PreBeta.c,189 :: 		}
	GOTO        L_UART_Send_String0
L_UART_Send_String1:
;SafeRoute_PreBeta.c,190 :: 		while(!UART1_Tx_Idle());
L_UART_Send_String4:
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_Send_String5
	GOTO        L_UART_Send_String4
L_UART_Send_String5:
;SafeRoute_PreBeta.c,191 :: 		UART1_Write(END);
	MOVLW       35
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SafeRoute_PreBeta.c,192 :: 		delay_ms(5);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_UART_Send_String6:
	DECFSZ      R13, 1, 1
	BRA         L_UART_Send_String6
	DECFSZ      R12, 1, 1
	BRA         L_UART_Send_String6
	NOP
;SafeRoute_PreBeta.c,193 :: 		}
L_end_UART_Send_String:
	RETURN      0
; end of _UART_Send_String

_SprintInt:

;SafeRoute_PreBeta.c,194 :: 		void SprintInt(int i){
;SafeRoute_PreBeta.c,196 :: 		IntToStr(i,text);
	MOVF        FARG_SprintInt_i+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        FARG_SprintInt_i+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       SprintInt_text_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(SprintInt_text_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SafeRoute_PreBeta.c,197 :: 		UART1_Write_text(text);
	MOVLW       SprintInt_text_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(SprintInt_text_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SafeRoute_PreBeta.c,198 :: 		UART1_Write_text(" ");
	MOVLW       ?lstr1_SafeRoute_PreBeta+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_SafeRoute_PreBeta+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SafeRoute_PreBeta.c,199 :: 		}
L_end_SprintInt:
	RETURN      0
; end of _SprintInt

_SprintFloat:

;SafeRoute_PreBeta.c,200 :: 		void SprintFloat(float f){
;SafeRoute_PreBeta.c,203 :: 		sprintf(text,"%.4f",f);
	MOVLW       SprintFloat_text_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(SprintFloat_text_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_2_SafeRoute_PreBeta+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_2_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_2_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        FARG_SprintFloat_f+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        FARG_SprintFloat_f+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        FARG_SprintFloat_f+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        FARG_SprintFloat_f+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;SafeRoute_PreBeta.c,204 :: 		UART1_Write_text(text);
	MOVLW       SprintFloat_text_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(SprintFloat_text_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SafeRoute_PreBeta.c,205 :: 		UART1_Write_text(" ");
	MOVLW       ?lstr3_SafeRoute_PreBeta+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_SafeRoute_PreBeta+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SafeRoute_PreBeta.c,206 :: 		}
L_end_SprintFloat:
	RETURN      0
; end of _SprintFloat

_SprintLn:

;SafeRoute_PreBeta.c,207 :: 		void SprintLn(){
;SafeRoute_PreBeta.c,208 :: 		UART1_Write('\n');
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SafeRoute_PreBeta.c,209 :: 		}
L_end_SprintLn:
	RETURN      0
; end of _SprintLn

_SprintMsg:

;SafeRoute_PreBeta.c,210 :: 		void SprintMsg(char *text){
;SafeRoute_PreBeta.c,211 :: 		UART1_Write_text(text);
	MOVF        FARG_SprintMsg_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_SprintMsg_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SafeRoute_PreBeta.c,212 :: 		}
L_end_SprintMsg:
	RETURN      0
; end of _SprintMsg

_SprintMsgLn:

;SafeRoute_PreBeta.c,213 :: 		void SprintMsgLn(char *text){
;SafeRoute_PreBeta.c,214 :: 		UART1_Write_text(text);
	MOVF        FARG_SprintMsgLn_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_SprintMsgLn_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SafeRoute_PreBeta.c,215 :: 		UART1_Write('\n');
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SafeRoute_PreBeta.c,216 :: 		}
L_end_SprintMsgLn:
	RETURN      0
; end of _SprintMsgLn

_ShowData:

;SafeRoute_PreBeta.c,217 :: 		void ShowData(char *title, float value){
;SafeRoute_PreBeta.c,218 :: 		SprintMsg(title);
	MOVF        FARG_ShowData_title+0, 0 
	MOVWF       FARG_SprintMsg_text+0 
	MOVF        FARG_ShowData_title+1, 0 
	MOVWF       FARG_SprintMsg_text+1 
	CALL        _SprintMsg+0, 0
;SafeRoute_PreBeta.c,219 :: 		SprintFloat(value);
	MOVF        FARG_ShowData_value+0, 0 
	MOVWF       FARG_SprintFloat_f+0 
	MOVF        FARG_ShowData_value+1, 0 
	MOVWF       FARG_SprintFloat_f+1 
	MOVF        FARG_ShowData_value+2, 0 
	MOVWF       FARG_SprintFloat_f+2 
	MOVF        FARG_ShowData_value+3, 0 
	MOVWF       FARG_SprintFloat_f+3 
	CALL        _SprintFloat+0, 0
;SafeRoute_PreBeta.c,220 :: 		SprintLn();
	CALL        _SprintLn+0, 0
;SafeRoute_PreBeta.c,221 :: 		}
L_end_ShowData:
	RETURN      0
; end of _ShowData

_StreamFixed:

;SafeRoute_PreBeta.c,222 :: 		void StreamFixed(char function, char sensor, char state){
;SafeRoute_PreBeta.c,223 :: 		char stream[12] = "";
	CLRF        StreamFixed_stream_L0+0 
	CLRF        StreamFixed_stream_L0+1 
	CLRF        StreamFixed_stream_L0+2 
	CLRF        StreamFixed_stream_L0+3 
	CLRF        StreamFixed_stream_L0+4 
	CLRF        StreamFixed_stream_L0+5 
	CLRF        StreamFixed_stream_L0+6 
	CLRF        StreamFixed_stream_L0+7 
	CLRF        StreamFixed_stream_L0+8 
	CLRF        StreamFixed_stream_L0+9 
	CLRF        StreamFixed_stream_L0+10 
	CLRF        StreamFixed_stream_L0+11 
;SafeRoute_PreBeta.c,224 :: 		stream[0] = INIT;
	MOVLW       36
	MOVWF       StreamFixed_stream_L0+0 
;SafeRoute_PreBeta.c,225 :: 		stream[1] = function;
	MOVF        FARG_StreamFixed_function+0, 0 
	MOVWF       StreamFixed_stream_L0+1 
;SafeRoute_PreBeta.c,226 :: 		stream[2] =  sensor;
	MOVF        FARG_StreamFixed_sensor+0, 0 
	MOVWF       StreamFixed_stream_L0+2 
;SafeRoute_PreBeta.c,227 :: 		stream[3] =  state;
	MOVF        FARG_StreamFixed_state+0, 0 
	MOVWF       StreamFixed_stream_L0+3 
;SafeRoute_PreBeta.c,228 :: 		stream[4] = END;
	MOVLW       35
	MOVWF       StreamFixed_stream_L0+4 
;SafeRoute_PreBeta.c,229 :: 		UART_Send_String(stream);
	MOVLW       StreamFixed_stream_L0+0
	MOVWF       FARG_UART_Send_String_dat+0 
	MOVLW       hi_addr(StreamFixed_stream_L0+0)
	MOVWF       FARG_UART_Send_String_dat+1 
	CALL        _UART_Send_String+0, 0
;SafeRoute_PreBeta.c,231 :: 		}
L_end_StreamFixed:
	RETURN      0
; end of _StreamFixed

_StreamFunction:

;SafeRoute_PreBeta.c,232 :: 		void StreamFunction(char function, char sensor, float value){
;SafeRoute_PreBeta.c,234 :: 		char stream[20] = "";
	CLRF        StreamFunction_stream_L0+0 
	CLRF        StreamFunction_stream_L0+1 
	CLRF        StreamFunction_stream_L0+2 
	CLRF        StreamFunction_stream_L0+3 
	CLRF        StreamFunction_stream_L0+4 
	CLRF        StreamFunction_stream_L0+5 
	CLRF        StreamFunction_stream_L0+6 
	CLRF        StreamFunction_stream_L0+7 
	CLRF        StreamFunction_stream_L0+8 
	CLRF        StreamFunction_stream_L0+9 
	CLRF        StreamFunction_stream_L0+10 
	CLRF        StreamFunction_stream_L0+11 
	CLRF        StreamFunction_stream_L0+12 
	CLRF        StreamFunction_stream_L0+13 
	CLRF        StreamFunction_stream_L0+14 
	CLRF        StreamFunction_stream_L0+15 
	CLRF        StreamFunction_stream_L0+16 
	CLRF        StreamFunction_stream_L0+17 
	CLRF        StreamFunction_stream_L0+18 
	CLRF        StreamFunction_stream_L0+19 
	CLRF        StreamFunction_caracter_L0+0 
	CLRF        StreamFunction_caracter_L0+1 
	MOVLW       3
	MOVWF       StreamFunction_charac_L0+0 
	MOVLW       0
	MOVWF       StreamFunction_charac_L0+1 
;SafeRoute_PreBeta.c,237 :: 		stream[0] = INIT;
	MOVLW       36
	MOVWF       StreamFunction_stream_L0+0 
;SafeRoute_PreBeta.c,238 :: 		stream[1] = function;
	MOVF        FARG_StreamFunction_function+0, 0 
	MOVWF       StreamFunction_stream_L0+1 
;SafeRoute_PreBeta.c,239 :: 		stream[2] =  sensor;
	MOVF        FARG_StreamFunction_sensor+0, 0 
	MOVWF       StreamFunction_stream_L0+2 
;SafeRoute_PreBeta.c,240 :: 		sprintf(text,"%.1f",value);
	MOVLW       StreamFunction_text_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(StreamFunction_text_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_4_SafeRoute_PreBeta+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_4_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_4_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        FARG_StreamFunction_value+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        FARG_StreamFunction_value+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        FARG_StreamFunction_value+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        FARG_StreamFunction_value+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;SafeRoute_PreBeta.c,241 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	CLRF        StreamFunction_caracter_L0+0 
	CLRF        StreamFunction_caracter_L0+1 
L_StreamFunction7:
	MOVLW       StreamFunction_text_L0+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(StreamFunction_text_L0+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	XORWF       StreamFunction_caracter_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StreamFunction183
	MOVF        R0, 0 
	SUBWF       StreamFunction_caracter_L0+0, 0 
L__StreamFunction183:
	BTFSC       STATUS+0, 0 
	GOTO        L_StreamFunction8
;SafeRoute_PreBeta.c,242 :: 		if(text[caracter]!= '.') {
	MOVLW       StreamFunction_text_L0+0
	ADDWF       StreamFunction_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamFunction_text_L0+0)
	ADDWFC      StreamFunction_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       46
	BTFSC       STATUS+0, 2 
	GOTO        L_StreamFunction10
;SafeRoute_PreBeta.c,243 :: 		stream[charac] = text[caracter];
	MOVLW       StreamFunction_stream_L0+0
	ADDWF       StreamFunction_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamFunction_stream_L0+0)
	ADDWFC      StreamFunction_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       StreamFunction_text_L0+0
	ADDWF       StreamFunction_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamFunction_text_L0+0)
	ADDWFC      StreamFunction_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,244 :: 		charac++;
	INFSNZ      StreamFunction_charac_L0+0, 1 
	INCF        StreamFunction_charac_L0+1, 1 
;SafeRoute_PreBeta.c,245 :: 		}
L_StreamFunction10:
;SafeRoute_PreBeta.c,241 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	INFSNZ      StreamFunction_caracter_L0+0, 1 
	INCF        StreamFunction_caracter_L0+1, 1 
;SafeRoute_PreBeta.c,246 :: 		}
	GOTO        L_StreamFunction7
L_StreamFunction8:
;SafeRoute_PreBeta.c,247 :: 		stream[charac] = END;
	MOVLW       StreamFunction_stream_L0+0
	ADDWF       StreamFunction_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamFunction_stream_L0+0)
	ADDWFC      StreamFunction_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       35
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,248 :: 		UART_Send_String(stream);
	MOVLW       StreamFunction_stream_L0+0
	MOVWF       FARG_UART_Send_String_dat+0 
	MOVLW       hi_addr(StreamFunction_stream_L0+0)
	MOVWF       FARG_UART_Send_String_dat+1 
	CALL        _UART_Send_String+0, 0
;SafeRoute_PreBeta.c,250 :: 		}
L_end_StreamFunction:
	RETURN      0
; end of _StreamFunction

_StreamAccel:

;SafeRoute_PreBeta.c,251 :: 		void StreamAccel(char function, char event, float magnitude, float vecAxis[3]){
;SafeRoute_PreBeta.c,252 :: 		char text[20] = "";
	MOVLW       ?ICSStreamAccel_text_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSStreamAccel_text_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSStreamAccel_text_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       StreamAccel_text_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       126
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;SafeRoute_PreBeta.c,257 :: 		stream[charac] = INIT;
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       36
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,258 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,259 :: 		stream[charac] = INIT;
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       36
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,260 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,261 :: 		stream[charac] = function;
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_StreamAccel_function+0, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,262 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,263 :: 		stream[charac] =  event;
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_StreamAccel_event+0, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,264 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,265 :: 		for(ind = 0; ind < 3 ; ind++){
	CLRF        StreamAccel_ind_L0+0 
	CLRF        StreamAccel_ind_L0+1 
L_StreamAccel11:
	MOVLW       128
	XORWF       StreamAccel_ind_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StreamAccel185
	MOVLW       3
	SUBWF       StreamAccel_ind_L0+0, 0 
L__StreamAccel185:
	BTFSC       STATUS+0, 0 
	GOTO        L_StreamAccel12
;SafeRoute_PreBeta.c,266 :: 		text[20] = "";
	MOVLW       ?lstr_5_SafeRoute_PreBeta+0
	MOVWF       StreamAccel_text_L0+20 
;SafeRoute_PreBeta.c,267 :: 		sprintf(text,"%.1f",vecAxis[ind]);
	MOVLW       StreamAccel_text_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_6_SafeRoute_PreBeta+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_6_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_6_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        StreamAccel_ind_L0+0, 0 
	MOVWF       R0 
	MOVF        StreamAccel_ind_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_StreamAccel_vecAxis+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_StreamAccel_vecAxis+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;SafeRoute_PreBeta.c,268 :: 		delay_ms(5);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_StreamAccel14:
	DECFSZ      R13, 1, 1
	BRA         L_StreamAccel14
	DECFSZ      R12, 1, 1
	BRA         L_StreamAccel14
	NOP
;SafeRoute_PreBeta.c,269 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	CLRF        StreamAccel_caracter_L0+0 
	CLRF        StreamAccel_caracter_L0+1 
L_StreamAccel15:
	MOVLW       StreamAccel_text_L0+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	XORWF       StreamAccel_caracter_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StreamAccel186
	MOVF        R0, 0 
	SUBWF       StreamAccel_caracter_L0+0, 0 
L__StreamAccel186:
	BTFSC       STATUS+0, 0 
	GOTO        L_StreamAccel16
;SafeRoute_PreBeta.c,270 :: 		if(text[caracter]!= '.') {
	MOVLW       StreamAccel_text_L0+0
	ADDWF       StreamAccel_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	ADDWFC      StreamAccel_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       46
	BTFSC       STATUS+0, 2 
	GOTO        L_StreamAccel18
;SafeRoute_PreBeta.c,272 :: 		stream[charac] = text[caracter];
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       StreamAccel_text_L0+0
	ADDWF       StreamAccel_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	ADDWFC      StreamAccel_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,273 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,274 :: 		}
L_StreamAccel18:
;SafeRoute_PreBeta.c,269 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	INFSNZ      StreamAccel_caracter_L0+0, 1 
	INCF        StreamAccel_caracter_L0+1, 1 
;SafeRoute_PreBeta.c,275 :: 		}
	GOTO        L_StreamAccel15
L_StreamAccel16:
;SafeRoute_PreBeta.c,276 :: 		stream[charac] = ';';
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       59
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,277 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,265 :: 		for(ind = 0; ind < 3 ; ind++){
	INFSNZ      StreamAccel_ind_L0+0, 1 
	INCF        StreamAccel_ind_L0+1, 1 
;SafeRoute_PreBeta.c,278 :: 		}
	GOTO        L_StreamAccel11
L_StreamAccel12:
;SafeRoute_PreBeta.c,279 :: 		sprintf(text,"%.1f",magnitude);
	MOVLW       StreamAccel_text_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_7_SafeRoute_PreBeta+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_7_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_7_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        FARG_StreamAccel_magnitude+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        FARG_StreamAccel_magnitude+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        FARG_StreamAccel_magnitude+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        FARG_StreamAccel_magnitude+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;SafeRoute_PreBeta.c,280 :: 		delay_ms(5);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_StreamAccel19:
	DECFSZ      R13, 1, 1
	BRA         L_StreamAccel19
	DECFSZ      R12, 1, 1
	BRA         L_StreamAccel19
	NOP
;SafeRoute_PreBeta.c,281 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	CLRF        StreamAccel_caracter_L0+0 
	CLRF        StreamAccel_caracter_L0+1 
L_StreamAccel20:
	MOVLW       StreamAccel_text_L0+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	XORWF       StreamAccel_caracter_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StreamAccel187
	MOVF        R0, 0 
	SUBWF       StreamAccel_caracter_L0+0, 0 
L__StreamAccel187:
	BTFSC       STATUS+0, 0 
	GOTO        L_StreamAccel21
;SafeRoute_PreBeta.c,282 :: 		if(text[caracter]!= '.') {
	MOVLW       StreamAccel_text_L0+0
	ADDWF       StreamAccel_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	ADDWFC      StreamAccel_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       46
	BTFSC       STATUS+0, 2 
	GOTO        L_StreamAccel23
;SafeRoute_PreBeta.c,283 :: 		stream[charac] = text[caracter];
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       StreamAccel_text_L0+0
	ADDWF       StreamAccel_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamAccel_text_L0+0)
	ADDWFC      StreamAccel_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,284 :: 		charac++;
	INFSNZ      StreamAccel_charac_L0+0, 1 
	INCF        StreamAccel_charac_L0+1, 1 
;SafeRoute_PreBeta.c,285 :: 		}
L_StreamAccel23:
;SafeRoute_PreBeta.c,281 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	INFSNZ      StreamAccel_caracter_L0+0, 1 
	INCF        StreamAccel_caracter_L0+1, 1 
;SafeRoute_PreBeta.c,286 :: 		}
	GOTO        L_StreamAccel20
L_StreamAccel21:
;SafeRoute_PreBeta.c,287 :: 		stream[charac] = END;
	MOVLW       StreamAccel_stream_L0+0
	ADDWF       StreamAccel_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	ADDWFC      StreamAccel_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       35
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,288 :: 		UART_Send_String(stream);
	MOVLW       StreamAccel_stream_L0+0
	MOVWF       FARG_UART_Send_String_dat+0 
	MOVLW       hi_addr(StreamAccel_stream_L0+0)
	MOVWF       FARG_UART_Send_String_dat+1 
	CALL        _UART_Send_String+0, 0
;SafeRoute_PreBeta.c,290 :: 		}
L_end_StreamAccel:
	RETURN      0
; end of _StreamAccel

_StreamAlcohol:

;SafeRoute_PreBeta.c,291 :: 		void StreamAlcohol(char function, int grade, float cienMgsMl){
;SafeRoute_PreBeta.c,294 :: 		char stream[100] = "";
	MOVLW       ?ICSStreamAlcohol_stream_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSStreamAlcohol_stream_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSStreamAlcohol_stream_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       StreamAlcohol_stream_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAlcohol_stream_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       104
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;SafeRoute_PreBeta.c,297 :: 		stream[0] = INIT;
	MOVLW       36
	MOVWF       StreamAlcohol_stream_L0+0 
;SafeRoute_PreBeta.c,298 :: 		stream[1] = function;
	MOVF        FARG_StreamAlcohol_function+0, 0 
	MOVWF       StreamAlcohol_stream_L0+1 
;SafeRoute_PreBeta.c,299 :: 		stream[2] =  ALC;
	MOVLW       65
	MOVWF       StreamAlcohol_stream_L0+2 
;SafeRoute_PreBeta.c,300 :: 		sprintf(grad,"%d",grade);
	MOVLW       StreamAlcohol_grad_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(StreamAlcohol_grad_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_8_SafeRoute_PreBeta+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_8_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_8_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        FARG_StreamAlcohol_grade+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        FARG_StreamAlcohol_grade+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;SafeRoute_PreBeta.c,301 :: 		stream[3] = grad[0];
	MOVF        StreamAlcohol_grad_L0+0, 0 
	MOVWF       StreamAlcohol_stream_L0+3 
;SafeRoute_PreBeta.c,302 :: 		stream[4] = ',';
	MOVLW       44
	MOVWF       StreamAlcohol_stream_L0+4 
;SafeRoute_PreBeta.c,303 :: 		sprintf(text,"%.1f",cienMgsMl);
	MOVLW       StreamAlcohol_text_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(StreamAlcohol_text_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_9_SafeRoute_PreBeta+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_9_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_9_SafeRoute_PreBeta+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        FARG_StreamAlcohol_cienMgsMl+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        FARG_StreamAlcohol_cienMgsMl+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        FARG_StreamAlcohol_cienMgsMl+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        FARG_StreamAlcohol_cienMgsMl+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;SafeRoute_PreBeta.c,304 :: 		delay_ms(5);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_StreamAlcohol24:
	DECFSZ      R13, 1, 1
	BRA         L_StreamAlcohol24
	DECFSZ      R12, 1, 1
	BRA         L_StreamAlcohol24
	NOP
;SafeRoute_PreBeta.c,305 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	CLRF        StreamAlcohol_caracter_L0+0 
	CLRF        StreamAlcohol_caracter_L0+1 
L_StreamAlcohol25:
	MOVLW       StreamAlcohol_text_L0+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(StreamAlcohol_text_L0+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	XORWF       StreamAlcohol_caracter_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StreamAlcohol189
	MOVF        R0, 0 
	SUBWF       StreamAlcohol_caracter_L0+0, 0 
L__StreamAlcohol189:
	BTFSC       STATUS+0, 0 
	GOTO        L_StreamAlcohol26
;SafeRoute_PreBeta.c,306 :: 		if(text[caracter]!= '.') {
	MOVLW       StreamAlcohol_text_L0+0
	ADDWF       StreamAlcohol_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamAlcohol_text_L0+0)
	ADDWFC      StreamAlcohol_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       46
	BTFSC       STATUS+0, 2 
	GOTO        L_StreamAlcohol28
;SafeRoute_PreBeta.c,307 :: 		stream[charac] = text[caracter];
	MOVLW       StreamAlcohol_stream_L0+0
	ADDWF       StreamAlcohol_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAlcohol_stream_L0+0)
	ADDWFC      StreamAlcohol_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       StreamAlcohol_text_L0+0
	ADDWF       StreamAlcohol_caracter_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(StreamAlcohol_text_L0+0)
	ADDWFC      StreamAlcohol_caracter_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,308 :: 		charac++;
	INFSNZ      StreamAlcohol_charac_L0+0, 1 
	INCF        StreamAlcohol_charac_L0+1, 1 
;SafeRoute_PreBeta.c,309 :: 		}
L_StreamAlcohol28:
;SafeRoute_PreBeta.c,305 :: 		for(caracter = 0; caracter < strlen(text); caracter++){
	INFSNZ      StreamAlcohol_caracter_L0+0, 1 
	INCF        StreamAlcohol_caracter_L0+1, 1 
;SafeRoute_PreBeta.c,310 :: 		}
	GOTO        L_StreamAlcohol25
L_StreamAlcohol26:
;SafeRoute_PreBeta.c,311 :: 		stream[charac] = END;
	MOVLW       StreamAlcohol_stream_L0+0
	ADDWF       StreamAlcohol_charac_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(StreamAlcohol_stream_L0+0)
	ADDWFC      StreamAlcohol_charac_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       35
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,312 :: 		UART_Send_String(stream);
	MOVLW       StreamAlcohol_stream_L0+0
	MOVWF       FARG_UART_Send_String_dat+0 
	MOVLW       hi_addr(StreamAlcohol_stream_L0+0)
	MOVWF       FARG_UART_Send_String_dat+1 
	CALL        _UART_Send_String+0, 0
;SafeRoute_PreBeta.c,314 :: 		}
L_end_StreamAlcohol:
	RETURN      0
; end of _StreamAlcohol

_GetTemp:

;SafeRoute_PreBeta.c,316 :: 		int GetTemp(){
;SafeRoute_PreBeta.c,317 :: 		int tempe = 0;
	CLRF        GetTemp_tempe_L0+0 
	CLRF        GetTemp_tempe_L0+1 
;SafeRoute_PreBeta.c,319 :: 		Ow_Reset(&PORTB, 1);                        // Onewire reset signal
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Reset_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Reset_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
;SafeRoute_PreBeta.c,320 :: 		Ow_Write(&PORTB, 1, 0xCC);                   // Issue command SKIP_ROM
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;SafeRoute_PreBeta.c,321 :: 		Ow_Write(&PORTB, 1, 0x44);                   // Issue command CONVERT_T
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       68
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;SafeRoute_PreBeta.c,322 :: 		delay_ms(20);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_GetTemp29:
	DECFSZ      R13, 1, 1
	BRA         L_GetTemp29
	DECFSZ      R12, 1, 1
	BRA         L_GetTemp29
	NOP
;SafeRoute_PreBeta.c,325 :: 		Ow_Reset(&PORTB, 1);
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Reset_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Reset_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
;SafeRoute_PreBeta.c,326 :: 		Ow_Write(&PORTB, 1, 0xCC);                   // Issue command SKIP_ROM
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;SafeRoute_PreBeta.c,327 :: 		Ow_Write(&PORTB, 1, 0xBE);                   // Issue command READ_SCRATCHPAD
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Write_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Write_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       190
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;SafeRoute_PreBeta.c,329 :: 		tempe =  Ow_Read(&PORTB, 1);
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Read_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Read_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetTemp_tempe_L0+0 
	MOVLW       0
	MOVWF       GetTemp_tempe_L0+1 
;SafeRoute_PreBeta.c,330 :: 		tempe &= TEMP_RESOLUTION;
	MOVLW       254
	ANDWF       GetTemp_tempe_L0+0, 1 
	MOVLW       0
	ANDWF       GetTemp_tempe_L0+1, 1 
;SafeRoute_PreBeta.c,331 :: 		tempe = (Ow_Read(&PORTB, 1) << 8) + tempe;
	MOVLW       PORTB+0
	MOVWF       FARG_Ow_Read_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Ow_Read_port+1 
	MOVLW       1
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        GetTemp_tempe_L0+0, 0 
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVF        GetTemp_tempe_L0+1, 0 
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       GetTemp_tempe_L0+0 
	MOVF        R1, 0 
	MOVWF       GetTemp_tempe_L0+1 
;SafeRoute_PreBeta.c,332 :: 		tempe = tempe/16;
	MOVLW       16
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       GetTemp_tempe_L0+0 
	MOVF        R1, 0 
	MOVWF       GetTemp_tempe_L0+1 
;SafeRoute_PreBeta.c,334 :: 		return tempe;
;SafeRoute_PreBeta.c,335 :: 		}
L_end_GetTemp:
	RETURN      0
; end of _GetTemp

_ReadADC:

;SafeRoute_PreBeta.c,337 :: 		float ReadADC(int channel){
;SafeRoute_PreBeta.c,338 :: 		float reference = 0.00;
;SafeRoute_PreBeta.c,339 :: 		float avarage = 0;
	CLRF        ReadADC_avarage_L0+0 
	CLRF        ReadADC_avarage_L0+1 
	CLRF        ReadADC_avarage_L0+2 
	CLRF        ReadADC_avarage_L0+3 
	MOVLW       133
	MOVWF       ReadADC_batReference_L0+0 
	MOVLW       235
	MOVWF       ReadADC_batReference_L0+1 
	MOVLW       81
	MOVWF       ReadADC_batReference_L0+2 
	MOVLW       128
	MOVWF       ReadADC_batReference_L0+3 
	MOVLW       0
	MOVWF       ReadADC_bitsReadADC_L0+0 
	MOVLW       4
	MOVWF       ReadADC_bitsReadADC_L0+1 
;SafeRoute_PreBeta.c,344 :: 		for(timesBateryReads = 0; timesBateryReads < 10 ; timesBateryReads++)
	CLRF        _timesBateryReads+0 
	CLRF        _timesBateryReads+1 
L_ReadADC30:
	MOVLW       128
	XORWF       _timesBateryReads+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ReadADC192
	MOVLW       10
	SUBWF       _timesBateryReads+0, 0 
L__ReadADC192:
	BTFSC       STATUS+0, 0 
	GOTO        L_ReadADC31
;SafeRoute_PreBeta.c,346 :: 		avarage += ((ADC_READ(channel) * batReference) / bitsReadADC);
	MOVF        FARG_ReadADC_channel+0, 0 
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        ReadADC_batReference_L0+0, 0 
	MOVWF       R4 
	MOVF        ReadADC_batReference_L0+1, 0 
	MOVWF       R5 
	MOVF        ReadADC_batReference_L0+2, 0 
	MOVWF       R6 
	MOVF        ReadADC_batReference_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ReadADC+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ReadADC+1 
	MOVF        R2, 0 
	MOVWF       FLOC__ReadADC+2 
	MOVF        R3, 0 
	MOVWF       FLOC__ReadADC+3 
	MOVF        ReadADC_bitsReadADC_L0+0, 0 
	MOVWF       R0 
	MOVF        ReadADC_bitsReadADC_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__ReadADC+0, 0 
	MOVWF       R0 
	MOVF        FLOC__ReadADC+1, 0 
	MOVWF       R1 
	MOVF        FLOC__ReadADC+2, 0 
	MOVWF       R2 
	MOVF        FLOC__ReadADC+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        ReadADC_avarage_L0+0, 0 
	MOVWF       R4 
	MOVF        ReadADC_avarage_L0+1, 0 
	MOVWF       R5 
	MOVF        ReadADC_avarage_L0+2, 0 
	MOVWF       R6 
	MOVF        ReadADC_avarage_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_avarage_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_avarage_L0+1 
	MOVF        R2, 0 
	MOVWF       ReadADC_avarage_L0+2 
	MOVF        R3, 0 
	MOVWF       ReadADC_avarage_L0+3 
;SafeRoute_PreBeta.c,344 :: 		for(timesBateryReads = 0; timesBateryReads < 10 ; timesBateryReads++)
	INFSNZ      _timesBateryReads+0, 1 
	INCF        _timesBateryReads+1, 1 
;SafeRoute_PreBeta.c,347 :: 		}
	GOTO        L_ReadADC30
L_ReadADC31:
;SafeRoute_PreBeta.c,348 :: 		return avarage/10;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        ReadADC_avarage_L0+0, 0 
	MOVWF       R0 
	MOVF        ReadADC_avarage_L0+1, 0 
	MOVWF       R1 
	MOVF        ReadADC_avarage_L0+2, 0 
	MOVWF       R2 
	MOVF        ReadADC_avarage_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
;SafeRoute_PreBeta.c,349 :: 		}
L_end_ReadADC:
	RETURN      0
; end of _ReadADC

_GetBatteryPorcent:

;SafeRoute_PreBeta.c,350 :: 		float GetBatteryPorcent(){
;SafeRoute_PreBeta.c,351 :: 		float porcBattery = 0.00;
;SafeRoute_PreBeta.c,356 :: 		float rawBattery = ReadADC(0);
	CLRF        FARG_ReadADC_channel+0 
	CLRF        FARG_ReadADC_channel+1 
	CALL        _ReadADC+0, 0
	MOVF        R0, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+0 
	MOVF        R1, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+1 
	MOVF        R2, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+2 
	MOVF        R3, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+3 
;SafeRoute_PreBeta.c,358 :: 		if(rawBattery*2 > 4.2){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       6
	MOVWF       R2 
	MOVLW       129
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetBatteryPorcent33
;SafeRoute_PreBeta.c,359 :: 		rawBattery -= rawBattery*0.16;
	MOVF        GetBatteryPorcent_rawBattery_L0+0, 0 
	MOVWF       R0 
	MOVF        GetBatteryPorcent_rawBattery_L0+1, 0 
	MOVWF       R1 
	MOVF        GetBatteryPorcent_rawBattery_L0+2, 0 
	MOVWF       R2 
	MOVF        GetBatteryPorcent_rawBattery_L0+3, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        GetBatteryPorcent_rawBattery_L0+0, 0 
	MOVWF       R0 
	MOVF        GetBatteryPorcent_rawBattery_L0+1, 0 
	MOVWF       R1 
	MOVF        GetBatteryPorcent_rawBattery_L0+2, 0 
	MOVWF       R2 
	MOVF        GetBatteryPorcent_rawBattery_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+0 
	MOVF        R1, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+1 
	MOVF        R2, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+2 
	MOVF        R3, 0 
	MOVWF       GetBatteryPorcent_rawBattery_L0+3 
;SafeRoute_PreBeta.c,360 :: 		}
L_GetBatteryPorcent33:
;SafeRoute_PreBeta.c,361 :: 		porcBattery = porcMin + (rawBattery-voltMin)*((porcMax - porcMin)/(voltMax - voltMin));
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        GetBatteryPorcent_rawBattery_L0+0, 0 
	MOVWF       R0 
	MOVF        GetBatteryPorcent_rawBattery_L0+1, 0 
	MOVWF       R1 
	MOVF        GetBatteryPorcent_rawBattery_L0+2, 0 
	MOVWF       R2 
	MOVF        GetBatteryPorcent_rawBattery_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       194
	MOVWF       R4 
	MOVLW       166
	MOVWF       R5 
	MOVLW       53
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;SafeRoute_PreBeta.c,362 :: 		return porcBattery;
;SafeRoute_PreBeta.c,363 :: 		}
L_end_GetBatteryPorcent:
	RETURN      0
; end of _GetBatteryPorcent

_SendBattery:

;SafeRoute_PreBeta.c,364 :: 		void SendBattery(){
;SafeRoute_PreBeta.c,366 :: 		batteryPorc = GetBatteryPorcent();
	CALL        _GetBatteryPorcent+0, 0
	MOVF        R0, 0 
	MOVWF       _batteryPorc+0 
	MOVF        R1, 0 
	MOVWF       _batteryPorc+1 
	MOVF        R2, 0 
	MOVWF       _batteryPorc+2 
	MOVF        R3, 0 
	MOVWF       _batteryPorc+3 
;SafeRoute_PreBeta.c,367 :: 		StreamFunction(STATE, BAT, batteryPorc);
	MOVLW       50
	MOVWF       FARG_StreamFunction_function+0 
	MOVLW       66
	MOVWF       FARG_StreamFunction_sensor+0 
	MOVF        R0, 0 
	MOVWF       FARG_StreamFunction_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_StreamFunction_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_StreamFunction_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_StreamFunction_value+3 
	CALL        _StreamFunction+0, 0
;SafeRoute_PreBeta.c,368 :: 		if(batteryPorc < 29)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       104
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _batteryPorc+0, 0 
	MOVWF       R0 
	MOVF        _batteryPorc+1, 0 
	MOVWF       R1 
	MOVF        _batteryPorc+2, 0 
	MOVWF       R2 
	MOVF        _batteryPorc+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SendBattery34
;SafeRoute_PreBeta.c,369 :: 		StreamFixed(SEG, LOW_BAT, ON);
	MOVLW       53
	MOVWF       FARG_StreamFixed_function+0 
	MOVLW       67
	MOVWF       FARG_StreamFixed_sensor+0 
	MOVLW       49
	MOVWF       FARG_StreamFixed_state+0 
	CALL        _StreamFixed+0, 0
L_SendBattery34:
;SafeRoute_PreBeta.c,370 :: 		}
L_end_SendBattery:
	RETURN      0
; end of _SendBattery

_ReadingAlcohol:

;SafeRoute_PreBeta.c,371 :: 		short int ReadingAlcohol(){
;SafeRoute_PreBeta.c,387 :: 		short int gradeAlcohol = 0;
	MOVLW       ?ICSReadingAlcohol_gradeAlcohol_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSReadingAlcohol_gradeAlcohol_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSReadingAlcohol_gradeAlcohol_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       ReadingAlcohol_gradeAlcohol_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(ReadingAlcohol_gradeAlcohol_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;SafeRoute_PreBeta.c,392 :: 		float rawAlcohol = ReadADC(1);
	MOVLW       1
	MOVWF       FARG_ReadADC_channel+0 
	MOVLW       0
	MOVWF       FARG_ReadADC_channel+1 
	CALL        _ReadADC+0, 0
;SafeRoute_PreBeta.c,394 :: 		mglAlcohol = minmG + (((rawAlcohol-minVolt)/(maxVolt-minVolt))*(maxmG-minmG));
	MOVF        ReadingAlcohol_minVolt_L0+0, 0 
	MOVWF       R4 
	MOVF        ReadingAlcohol_minVolt_L0+1, 0 
	MOVWF       R5 
	MOVF        ReadingAlcohol_minVolt_L0+2, 0 
	MOVWF       R6 
	MOVF        ReadingAlcohol_minVolt_L0+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ReadingAlcohol+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ReadingAlcohol+1 
	MOVF        R2, 0 
	MOVWF       FLOC__ReadingAlcohol+2 
	MOVF        R3, 0 
	MOVWF       FLOC__ReadingAlcohol+3 
	MOVF        ReadingAlcohol_minVolt_L0+0, 0 
	MOVWF       R4 
	MOVF        ReadingAlcohol_minVolt_L0+1, 0 
	MOVWF       R5 
	MOVF        ReadingAlcohol_minVolt_L0+2, 0 
	MOVWF       R6 
	MOVF        ReadingAlcohol_minVolt_L0+3, 0 
	MOVWF       R7 
	MOVF        ReadingAlcohol_maxVolt_L0+0, 0 
	MOVWF       R0 
	MOVF        ReadingAlcohol_maxVolt_L0+1, 0 
	MOVWF       R1 
	MOVF        ReadingAlcohol_maxVolt_L0+2, 0 
	MOVWF       R2 
	MOVF        ReadingAlcohol_maxVolt_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__ReadingAlcohol+0, 0 
	MOVWF       R0 
	MOVF        FLOC__ReadingAlcohol+1, 0 
	MOVWF       R1 
	MOVF        FLOC__ReadingAlcohol+2, 0 
	MOVWF       R2 
	MOVF        FLOC__ReadingAlcohol+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ReadingAlcohol+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ReadingAlcohol+1 
	MOVF        R2, 0 
	MOVWF       FLOC__ReadingAlcohol+2 
	MOVF        R3, 0 
	MOVWF       FLOC__ReadingAlcohol+3 
	MOVF        ReadingAlcohol_minmG_L0+0, 0 
	MOVWF       R4 
	MOVF        ReadingAlcohol_minmG_L0+1, 0 
	MOVWF       R5 
	MOVF        ReadingAlcohol_minmG_L0+2, 0 
	MOVWF       R6 
	MOVF        ReadingAlcohol_minmG_L0+3, 0 
	MOVWF       R7 
	MOVF        ReadingAlcohol_maxmG_L0+0, 0 
	MOVWF       R0 
	MOVF        ReadingAlcohol_maxmG_L0+1, 0 
	MOVWF       R1 
	MOVF        ReadingAlcohol_maxmG_L0+2, 0 
	MOVWF       R2 
	MOVF        ReadingAlcohol_maxmG_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        FLOC__ReadingAlcohol+0, 0 
	MOVWF       R4 
	MOVF        FLOC__ReadingAlcohol+1, 0 
	MOVWF       R5 
	MOVF        FLOC__ReadingAlcohol+2, 0 
	MOVWF       R6 
	MOVF        FLOC__ReadingAlcohol+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        ReadingAlcohol_minmG_L0+0, 0 
	MOVWF       R4 
	MOVF        ReadingAlcohol_minmG_L0+1, 0 
	MOVWF       R5 
	MOVF        ReadingAlcohol_minmG_L0+2, 0 
	MOVWF       R6 
	MOVF        ReadingAlcohol_minmG_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _mglALcohol+0 
	MOVF        R1, 0 
	MOVWF       _mglALcohol+1 
	MOVF        R2, 0 
	MOVWF       _mglALcohol+2 
	MOVF        R3, 0 
	MOVWF       _mglALcohol+3 
;SafeRoute_PreBeta.c,395 :: 		mglAlcohol -= 200.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _mglALcohol+0 
	MOVF        R1, 0 
	MOVWF       _mglALcohol+1 
	MOVF        R2, 0 
	MOVWF       _mglALcohol+2 
	MOVF        R3, 0 
	MOVWF       _mglALcohol+3 
;SafeRoute_PreBeta.c,398 :: 		if(mglAlcohol <=390.0 ) //400 ppm pasa al grado 1 de alcohol por lo que se envia la notificacion
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       67
	MOVWF       R2 
	MOVLW       135
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol35
;SafeRoute_PreBeta.c,400 :: 		if(mglAlcohol < 0) mglAlcohol = 0.00;
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        _mglALcohol+0, 0 
	MOVWF       R0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       R1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       R2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol36
	CLRF        _mglALcohol+0 
	CLRF        _mglALcohol+1 
	CLRF        _mglALcohol+2 
	CLRF        _mglALcohol+3 
L_ReadingAlcohol36:
;SafeRoute_PreBeta.c,401 :: 		gradeAlcohol = 0;
	CLRF        ReadingAlcohol_gradeAlcohol_L0+0 
;SafeRoute_PreBeta.c,402 :: 		}
	GOTO        L_ReadingAlcohol37
L_ReadingAlcohol35:
;SafeRoute_PreBeta.c,403 :: 		else if(mglAlcohol >= 400.0 && mglAlcohol<= 990.0) //40 mG/100mL pasa al grado 1 de alcohol por lo que se envia la notificacion
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	MOVF        _mglALcohol+0, 0 
	MOVWF       R0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       R1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       R2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol40
	MOVF        _mglALcohol+0, 0 
	MOVWF       R4 
	MOVF        _mglALcohol+1, 0 
	MOVWF       R5 
	MOVF        _mglALcohol+2, 0 
	MOVWF       R6 
	MOVF        _mglALcohol+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       128
	MOVWF       R1 
	MOVLW       119
	MOVWF       R2 
	MOVLW       136
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol40
L__ReadingAlcohol164:
;SafeRoute_PreBeta.c,405 :: 		gradeAlcohol = 1;
	MOVLW       1
	MOVWF       ReadingAlcohol_gradeAlcohol_L0+0 
;SafeRoute_PreBeta.c,406 :: 		}
	GOTO        L_ReadingAlcohol41
L_ReadingAlcohol40:
;SafeRoute_PreBeta.c,407 :: 		else if(mglAlcohol >= 1000.0 && mglAlcohol<= 1490.0) //400 ppm pasa al grado 1 de alcohol por lo que se envia la notificacion
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _mglALcohol+0, 0 
	MOVWF       R0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       R1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       R2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol44
	MOVF        _mglALcohol+0, 0 
	MOVWF       R4 
	MOVF        _mglALcohol+1, 0 
	MOVWF       R5 
	MOVF        _mglALcohol+2, 0 
	MOVWF       R6 
	MOVF        _mglALcohol+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       64
	MOVWF       R1 
	MOVLW       58
	MOVWF       R2 
	MOVLW       137
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol44
L__ReadingAlcohol163:
;SafeRoute_PreBeta.c,409 :: 		gradeAlcohol = 2;
	MOVLW       2
	MOVWF       ReadingAlcohol_gradeAlcohol_L0+0 
;SafeRoute_PreBeta.c,410 :: 		}
	GOTO        L_ReadingAlcohol45
L_ReadingAlcohol44:
;SafeRoute_PreBeta.c,411 :: 		else if(mglAlcohol >= 1500.0) //400 ppm pasa al grado 1 de alcohol por lo que se envia la notificacion
	MOVLW       0
	MOVWF       R4 
	MOVLW       128
	MOVWF       R5 
	MOVLW       59
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	MOVF        _mglALcohol+0, 0 
	MOVWF       R0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       R1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       R2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadingAlcohol46
;SafeRoute_PreBeta.c,413 :: 		gradeAlcohol = 3;
	MOVLW       3
	MOVWF       ReadingAlcohol_gradeAlcohol_L0+0 
;SafeRoute_PreBeta.c,414 :: 		}
L_ReadingAlcohol46:
L_ReadingAlcohol45:
L_ReadingAlcohol41:
L_ReadingAlcohol37:
;SafeRoute_PreBeta.c,416 :: 		return gradeAlcohol;
	MOVF        ReadingAlcohol_gradeAlcohol_L0+0, 0 
	MOVWF       R0 
;SafeRoute_PreBeta.c,417 :: 		}
L_end_ReadingAlcohol:
	RETURN      0
; end of _ReadingAlcohol

_MPU6050_Init:

;SafeRoute_PreBeta.c,419 :: 		void MPU6050_Init()
;SafeRoute_PreBeta.c,421 :: 		I2C1_Init(400000);
	MOVLW       10
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;SafeRoute_PreBeta.c,422 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_MPU6050_Init47:
	DECFSZ      R13, 1, 1
	BRA         L_MPU6050_Init47
	DECFSZ      R12, 1, 1
	BRA         L_MPU6050_Init47
	DECFSZ      R11, 1, 1
	BRA         L_MPU6050_Init47
;SafeRoute_PreBeta.c,424 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,425 :: 		I2C1_Wr(MPU6050_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,426 :: 		I2C1_Wr(MPU6050_RA_SMPLRT_DIV);
	MOVLW       25
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,427 :: 		I2C1_Wr(0x07);
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,428 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,430 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,431 :: 		I2C1_Wr(MPU6050_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,432 :: 		I2C1_Wr(MPU6050_RA_PWR_MGMT_1);
	MOVLW       107
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,433 :: 		I2C1_Wr(0x02);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,435 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,437 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,438 :: 		I2C1_Wr(MPU6050_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,439 :: 		I2C1_Wr(MPU6050_RA_CONFIG);
	MOVLW       26
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,440 :: 		I2C1_Wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,441 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,443 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,444 :: 		I2C1_Wr(MPU6050_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,445 :: 		I2C1_Wr(MPU6050_RA_ACCEL_CONFIG);
	MOVLW       28
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,446 :: 		I2C1_Wr(0x18); //accel_config +-16g
	MOVLW       24
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,447 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,449 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,450 :: 		I2C1_Wr(MPU6050_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,451 :: 		I2C1_Wr(MPU6050_RA_GYRO_CONFIG);
	MOVLW       27
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,453 :: 		I2C1_Wr(0x00); //gyro_config, +-250 ?/s
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,454 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,455 :: 		}
L_end_MPU6050_Init:
	RETURN      0
; end of _MPU6050_Init

_MPU6050_Read:

;SafeRoute_PreBeta.c,456 :: 		void MPU6050_Read(){
;SafeRoute_PreBeta.c,457 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,458 :: 		I2C1_Wr( MPU6050_ADDRESS );
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,459 :: 		I2C1_Wr( MPU6050_RA_ACCEL_XOUT_H );
	MOVLW       59
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,460 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,461 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SafeRoute_PreBeta.c,462 :: 		I2C1_Wr(MPU6050_ADDRESS | 1);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SafeRoute_PreBeta.c,463 :: 		rawAcc[0]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _rawAcc+0 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _rawAcc+1 
	MOVLW       0
	IORWF       _rawAcc+1, 1 
	MOVLW       0
	BTFSC       _rawAcc+1, 7 
	MOVLW       255
	MOVWF       _rawAcc+2 
	MOVWF       _rawAcc+3 
	MOVLW       0
	MOVWF       _rawAcc+2 
	MOVWF       _rawAcc+3 
;SafeRoute_PreBeta.c,464 :: 		rawAcc[1]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _rawAcc+4 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _rawAcc+5 
	MOVLW       0
	IORWF       _rawAcc+5, 1 
	MOVLW       0
	BTFSC       _rawAcc+5, 7 
	MOVLW       255
	MOVWF       _rawAcc+6 
	MOVWF       _rawAcc+7 
	MOVLW       0
	MOVWF       _rawAcc+6 
	MOVWF       _rawAcc+7 
;SafeRoute_PreBeta.c,465 :: 		rawAcc[2]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _rawAcc+8 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _rawAcc+9 
	MOVLW       0
	IORWF       _rawAcc+9, 1 
	MOVLW       0
	BTFSC       _rawAcc+9, 7 
	MOVLW       255
	MOVWF       _rawAcc+10 
	MOVWF       _rawAcc+11 
	MOVLW       0
	MOVWF       _rawAcc+10 
	MOVWF       _rawAcc+11 
;SafeRoute_PreBeta.c,466 :: 		tempMicro = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _tempMicro+0 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _tempMicro+1 
	MOVLW       0
	IORWF       _tempMicro+1, 1 
;SafeRoute_PreBeta.c,467 :: 		rawGyr[0]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _rawGyr+0 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _rawGyr+1 
	MOVLW       0
	IORWF       _rawGyr+1, 1 
	MOVLW       0
	BTFSC       _rawGyr+1, 7 
	MOVLW       255
	MOVWF       _rawGyr+2 
	MOVWF       _rawGyr+3 
	MOVLW       0
	MOVWF       _rawGyr+2 
	MOVWF       _rawGyr+3 
;SafeRoute_PreBeta.c,468 :: 		rawGyr[1]   = (I2C1_Rd(1) << 8) | I2C1_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _rawGyr+4 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _rawGyr+5 
	MOVLW       0
	IORWF       _rawGyr+5, 1 
	MOVLW       0
	BTFSC       _rawGyr+5, 7 
	MOVLW       255
	MOVWF       _rawGyr+6 
	MOVWF       _rawGyr+7 
	MOVLW       0
	MOVWF       _rawGyr+6 
	MOVWF       _rawGyr+7 
;SafeRoute_PreBeta.c,469 :: 		rawGyr[2]   = (I2C1_Rd(1) << 8) | I2C1_Rd(0);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_Read+1 
	CLRF        FLOC__MPU6050_Read+0 
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__MPU6050_Read+0, 0 
	MOVWF       _rawGyr+8 
	MOVF        FLOC__MPU6050_Read+1, 0 
	MOVWF       _rawGyr+9 
	MOVLW       0
	IORWF       _rawGyr+9, 1 
	MOVLW       0
	BTFSC       _rawGyr+9, 7 
	MOVLW       255
	MOVWF       _rawGyr+10 
	MOVWF       _rawGyr+11 
	MOVLW       0
	MOVWF       _rawGyr+10 
	MOVWF       _rawGyr+11 
;SafeRoute_PreBeta.c,470 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SafeRoute_PreBeta.c,471 :: 		tempMicro += 12421;
	MOVLW       133
	ADDWF       _tempMicro+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWFC      _tempMicro+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tempMicro+0 
	MOVF        R1, 0 
	MOVWF       _tempMicro+1 
;SafeRoute_PreBeta.c,472 :: 		tempMicro /= 340;
	MOVLW       84
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _tempMicro+0 
	MOVF        R1, 0 
	MOVWF       _tempMicro+1 
;SafeRoute_PreBeta.c,473 :: 		}
L_end_MPU6050_Read:
	RETURN      0
; end of _MPU6050_Read

_LowPassFilter:

;SafeRoute_PreBeta.c,475 :: 		void LowPassFilter(signed long int rawData[3], signed long int rawGyro[3]) {
;SafeRoute_PreBeta.c,476 :: 		short int axis = 0; //variable for recorre los ejes
	CLRF        LowPassFilter_axis_L0+0 
;SafeRoute_PreBeta.c,477 :: 		for (axis = 0; axis < 3; axis++) {
	CLRF        LowPassFilter_axis_L0+0 
L_LowPassFilter48:
	MOVLW       128
	XORWF       LowPassFilter_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LowPassFilter49
;SafeRoute_PreBeta.c,478 :: 		filteredData[axis] = ALPHA * rawData[axis] + (1 - ALPHA) * filteredData[axis];
	MOVF        LowPassFilter_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       LowPassFilter_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _filteredData+0
	ADDWF       R0, 0 
	MOVWF       FLOC__LowPassFilter+4 
	MOVLW       hi_addr(_filteredData+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__LowPassFilter+5 
	MOVF        FARG_LowPassFilter_rawData+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_LowPassFilter_rawData+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LowPassFilter+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LowPassFilter+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LowPassFilter+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LowPassFilter+3 
	MOVF        FLOC__LowPassFilter+4, 0 
	MOVWF       R0 
	MOVF        FLOC__LowPassFilter+5, 0 
	MOVWF       R1 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__LowPassFilter+0, 0 
	MOVWF       R4 
	MOVF        FLOC__LowPassFilter+1, 0 
	MOVWF       R5 
	MOVF        FLOC__LowPassFilter+2, 0 
	MOVWF       R6 
	MOVF        FLOC__LowPassFilter+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVFF       FLOC__LowPassFilter+4, FSR1L+0
	MOVFF       FLOC__LowPassFilter+5, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,479 :: 		filteredGyro[axis] = ALPHA * rawGyro[axis] + (1 - ALPHA) * filteredGyro[axis];
	MOVF        LowPassFilter_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       LowPassFilter_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _filteredGyro+0
	ADDWF       R0, 0 
	MOVWF       FLOC__LowPassFilter+4 
	MOVLW       hi_addr(_filteredGyro+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__LowPassFilter+5 
	MOVF        FARG_LowPassFilter_rawGyro+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_LowPassFilter_rawGyro+1, 0 
	ADDWFC      R1, 1 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LowPassFilter+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LowPassFilter+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LowPassFilter+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LowPassFilter+3 
	MOVF        FLOC__LowPassFilter+4, 0 
	MOVWF       R0 
	MOVF        FLOC__LowPassFilter+5, 0 
	MOVWF       R1 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__LowPassFilter+0, 0 
	MOVWF       R4 
	MOVF        FLOC__LowPassFilter+1, 0 
	MOVWF       R5 
	MOVF        FLOC__LowPassFilter+2, 0 
	MOVWF       R6 
	MOVF        FLOC__LowPassFilter+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVFF       FLOC__LowPassFilter+4, FSR1L+0
	MOVFF       FLOC__LowPassFilter+5, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,477 :: 		for (axis = 0; axis < 3; axis++) {
	INCF        LowPassFilter_axis_L0+0, 1 
;SafeRoute_PreBeta.c,480 :: 		}
	GOTO        L_LowPassFilter48
L_LowPassFilter49:
;SafeRoute_PreBeta.c,481 :: 		}
L_end_LowPassFilter:
	RETURN      0
; end of _LowPassFilter

_CalibrateMPU6050:

;SafeRoute_PreBeta.c,482 :: 		void CalibrateMPU6050(int samples) {
;SafeRoute_PreBeta.c,483 :: 		int sample = 0;
	CLRF        CalibrateMPU6050_sample_L0+0 
	CLRF        CalibrateMPU6050_sample_L0+1 
	CLRF        CalibrateMPU6050_axis_L0+0 
;SafeRoute_PreBeta.c,486 :: 		for (sample = 0; sample < samples; sample++) {
	CLRF        CalibrateMPU6050_sample_L0+0 
	CLRF        CalibrateMPU6050_sample_L0+1 
L_CalibrateMPU605051:
	MOVLW       128
	XORWF       CalibrateMPU6050_sample_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_CalibrateMPU6050_samples+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CalibrateMPU6050200
	MOVF        FARG_CalibrateMPU6050_samples+0, 0 
	SUBWF       CalibrateMPU6050_sample_L0+0, 0 
L__CalibrateMPU6050200:
	BTFSC       STATUS+0, 0 
	GOTO        L_CalibrateMPU605052
;SafeRoute_PreBeta.c,488 :: 		MPU6050_Read();
	CALL        _MPU6050_Read+0, 0
;SafeRoute_PreBeta.c,489 :: 		pinLedIndicator = 1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,493 :: 		LowPassFilter(rawAcc, rawGyr);
	MOVLW       _rawAcc+0
	MOVWF       FARG_LowPassFilter_rawData+0 
	MOVLW       hi_addr(_rawAcc+0)
	MOVWF       FARG_LowPassFilter_rawData+1 
	MOVLW       _rawGyr+0
	MOVWF       FARG_LowPassFilter_rawGyro+0 
	MOVLW       hi_addr(_rawGyr+0)
	MOVWF       FARG_LowPassFilter_rawGyro+1 
	CALL        _LowPassFilter+0, 0
;SafeRoute_PreBeta.c,494 :: 		delay_ms(10); // Puedes ajustar el retraso seg?n sea necesario
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_CalibrateMPU605054:
	DECFSZ      R13, 1, 1
	BRA         L_CalibrateMPU605054
	DECFSZ      R12, 1, 1
	BRA         L_CalibrateMPU605054
	NOP
	NOP
;SafeRoute_PreBeta.c,486 :: 		for (sample = 0; sample < samples; sample++) {
	INFSNZ      CalibrateMPU6050_sample_L0+0, 1 
	INCF        CalibrateMPU6050_sample_L0+1, 1 
;SafeRoute_PreBeta.c,495 :: 		}
	GOTO        L_CalibrateMPU605051
L_CalibrateMPU605052:
;SafeRoute_PreBeta.c,497 :: 		for (sample = 0; sample < samples; sample++) {
	CLRF        CalibrateMPU6050_sample_L0+0 
	CLRF        CalibrateMPU6050_sample_L0+1 
L_CalibrateMPU605055:
	MOVLW       128
	XORWF       CalibrateMPU6050_sample_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_CalibrateMPU6050_samples+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CalibrateMPU6050201
	MOVF        FARG_CalibrateMPU6050_samples+0, 0 
	SUBWF       CalibrateMPU6050_sample_L0+0, 0 
L__CalibrateMPU6050201:
	BTFSC       STATUS+0, 0 
	GOTO        L_CalibrateMPU605056
;SafeRoute_PreBeta.c,498 :: 		for (axis = 0; axis < 3; axis++) {
	CLRF        CalibrateMPU6050_axis_L0+0 
L_CalibrateMPU605058:
	MOVLW       128
	XORWF       CalibrateMPU6050_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CalibrateMPU605059
;SafeRoute_PreBeta.c,499 :: 		accelOffsets[axis] += filteredData[axis];
	MOVF        CalibrateMPU6050_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       CalibrateMPU6050_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _accelOffsets+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_accelOffsets+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       _filteredData+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_filteredData+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVFF       R4, FSR0L+0
	MOVFF       R5, FSR0H+0
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R3 
	MOVFF       R4, FSR1L+0
	MOVFF       R5, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,500 :: 		gyrOffsets[axis] += filteredGyro[axis];
	MOVF        CalibrateMPU6050_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       CalibrateMPU6050_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _gyrOffsets+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_gyrOffsets+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       _filteredGyro+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_filteredGyro+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVFF       R4, FSR0L+0
	MOVFF       R5, FSR0H+0
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R3 
	MOVFF       R4, FSR1L+0
	MOVFF       R5, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,498 :: 		for (axis = 0; axis < 3; axis++) {
	INCF        CalibrateMPU6050_axis_L0+0, 1 
;SafeRoute_PreBeta.c,501 :: 		}
	GOTO        L_CalibrateMPU605058
L_CalibrateMPU605059:
;SafeRoute_PreBeta.c,502 :: 		delay_ms(10); // Puedes ajustar el retraso seg?n sea necesario
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_CalibrateMPU605061:
	DECFSZ      R13, 1, 1
	BRA         L_CalibrateMPU605061
	DECFSZ      R12, 1, 1
	BRA         L_CalibrateMPU605061
	NOP
	NOP
;SafeRoute_PreBeta.c,497 :: 		for (sample = 0; sample < samples; sample++) {
	INFSNZ      CalibrateMPU6050_sample_L0+0, 1 
	INCF        CalibrateMPU6050_sample_L0+1, 1 
;SafeRoute_PreBeta.c,503 :: 		}
	GOTO        L_CalibrateMPU605055
L_CalibrateMPU605056:
;SafeRoute_PreBeta.c,504 :: 		for (axis = 0; axis < 3; axis++) {
	CLRF        CalibrateMPU6050_axis_L0+0 
L_CalibrateMPU605062:
	MOVLW       128
	XORWF       CalibrateMPU6050_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CalibrateMPU605063
;SafeRoute_PreBeta.c,505 :: 		accelOffsets[axis] /= samples;
	MOVF        CalibrateMPU6050_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       CalibrateMPU6050_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _accelOffsets+0
	ADDWF       R0, 0 
	MOVWF       FLOC__CalibrateMPU6050+0 
	MOVLW       hi_addr(_accelOffsets+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__CalibrateMPU6050+1 
	MOVFF       FLOC__CalibrateMPU6050+0, FSR0L+0
	MOVFF       FLOC__CalibrateMPU6050+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        FARG_CalibrateMPU6050_samples+0, 0 
	MOVWF       R4 
	MOVF        FARG_CalibrateMPU6050_samples+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       FARG_CalibrateMPU6050_samples+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVFF       FLOC__CalibrateMPU6050+0, FSR1L+0
	MOVFF       FLOC__CalibrateMPU6050+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,506 :: 		gyrOffsets[axis] /= samples;
	MOVF        CalibrateMPU6050_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       CalibrateMPU6050_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _gyrOffsets+0
	ADDWF       R0, 0 
	MOVWF       FLOC__CalibrateMPU6050+0 
	MOVLW       hi_addr(_gyrOffsets+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__CalibrateMPU6050+1 
	MOVFF       FLOC__CalibrateMPU6050+0, FSR0L+0
	MOVFF       FLOC__CalibrateMPU6050+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        FARG_CalibrateMPU6050_samples+0, 0 
	MOVWF       R4 
	MOVF        FARG_CalibrateMPU6050_samples+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       FARG_CalibrateMPU6050_samples+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVFF       FLOC__CalibrateMPU6050+0, FSR1L+0
	MOVFF       FLOC__CalibrateMPU6050+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,504 :: 		for (axis = 0; axis < 3; axis++) {
	INCF        CalibrateMPU6050_axis_L0+0, 1 
;SafeRoute_PreBeta.c,507 :: 		}
	GOTO        L_CalibrateMPU605062
L_CalibrateMPU605063:
;SafeRoute_PreBeta.c,508 :: 		SprintMsgLn("Sensor Calibrado!");
	MOVLW       ?lstr10_SafeRoute_PreBeta+0
	MOVWF       FARG_SprintMsgLn_text+0 
	MOVLW       hi_addr(?lstr10_SafeRoute_PreBeta+0)
	MOVWF       FARG_SprintMsgLn_text+1 
	CALL        _SprintMsgLn+0, 0
;SafeRoute_PreBeta.c,509 :: 		SprintMsgLn("Offsets:");
	MOVLW       ?lstr11_SafeRoute_PreBeta+0
	MOVWF       FARG_SprintMsgLn_text+0 
	MOVLW       hi_addr(?lstr11_SafeRoute_PreBeta+0)
	MOVWF       FARG_SprintMsgLn_text+1 
	CALL        _SprintMsgLn+0, 0
;SafeRoute_PreBeta.c,510 :: 		SprintMsg("Offset X: "); SprintInt(accelOffsets[0]);  SprintLn();
	MOVLW       ?lstr12_SafeRoute_PreBeta+0
	MOVWF       FARG_SprintMsg_text+0 
	MOVLW       hi_addr(?lstr12_SafeRoute_PreBeta+0)
	MOVWF       FARG_SprintMsg_text+1 
	CALL        _SprintMsg+0, 0
	MOVF        _accelOffsets+0, 0 
	MOVWF       FARG_SprintInt_i+0 
	MOVF        _accelOffsets+1, 0 
	MOVWF       FARG_SprintInt_i+1 
	CALL        _SprintInt+0, 0
	CALL        _SprintLn+0, 0
;SafeRoute_PreBeta.c,511 :: 		SprintMsg("Offset Y: "); SprintInt(accelOffsets[1]); SprintLn();
	MOVLW       ?lstr13_SafeRoute_PreBeta+0
	MOVWF       FARG_SprintMsg_text+0 
	MOVLW       hi_addr(?lstr13_SafeRoute_PreBeta+0)
	MOVWF       FARG_SprintMsg_text+1 
	CALL        _SprintMsg+0, 0
	MOVF        _accelOffsets+4, 0 
	MOVWF       FARG_SprintInt_i+0 
	MOVF        _accelOffsets+5, 0 
	MOVWF       FARG_SprintInt_i+1 
	CALL        _SprintInt+0, 0
	CALL        _SprintLn+0, 0
;SafeRoute_PreBeta.c,512 :: 		SprintMsg("Offset Z: "); SprintInt(accelOffsets[2]); SprintLn();
	MOVLW       ?lstr14_SafeRoute_PreBeta+0
	MOVWF       FARG_SprintMsg_text+0 
	MOVLW       hi_addr(?lstr14_SafeRoute_PreBeta+0)
	MOVWF       FARG_SprintMsg_text+1 
	CALL        _SprintMsg+0, 0
	MOVF        _accelOffsets+8, 0 
	MOVWF       FARG_SprintInt_i+0 
	MOVF        _accelOffsets+9, 0 
	MOVWF       FARG_SprintInt_i+1 
	CALL        _SprintInt+0, 0
	CALL        _SprintLn+0, 0
;SafeRoute_PreBeta.c,513 :: 		ShowData("Temperatura Micro: ", tempMicro);
	MOVLW       ?lstr15_SafeRoute_PreBeta+0
	MOVWF       FARG_ShowData_title+0 
	MOVLW       hi_addr(?lstr15_SafeRoute_PreBeta+0)
	MOVWF       FARG_ShowData_title+1 
	MOVF        _tempMicro+0, 0 
	MOVWF       R0 
	MOVF        _tempMicro+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ShowData_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_ShowData_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_ShowData_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_ShowData_value+3 
	CALL        _ShowData+0, 0
;SafeRoute_PreBeta.c,515 :: 		}
L_end_CalibrateMPU6050:
	RETURN      0
; end of _CalibrateMPU6050

_MPU6050_ReadFilter:

;SafeRoute_PreBeta.c,516 :: 		void MPU6050_ReadFilter(unsigned int samples){
;SafeRoute_PreBeta.c,517 :: 		int sample =0;
	CLRF        MPU6050_ReadFilter_sample_L0+0 
	CLRF        MPU6050_ReadFilter_sample_L0+1 
	CLRF        MPU6050_ReadFilter_axis_L0+0 
	CLRF        MPU6050_ReadFilter_ax_L0+0 
;SafeRoute_PreBeta.c,521 :: 		for(sample = 0; sample < samples; sample++){
	CLRF        MPU6050_ReadFilter_sample_L0+0 
	CLRF        MPU6050_ReadFilter_sample_L0+1 
L_MPU6050_ReadFilter65:
	MOVF        FARG_MPU6050_ReadFilter_samples+1, 0 
	SUBWF       MPU6050_ReadFilter_sample_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MPU6050_ReadFilter203
	MOVF        FARG_MPU6050_ReadFilter_samples+0, 0 
	SUBWF       MPU6050_ReadFilter_sample_L0+0, 0 
L__MPU6050_ReadFilter203:
	BTFSC       STATUS+0, 0 
	GOTO        L_MPU6050_ReadFilter66
;SafeRoute_PreBeta.c,522 :: 		MPU6050_Read();
	CALL        _MPU6050_Read+0, 0
;SafeRoute_PreBeta.c,523 :: 		LowPassFilter(rawAcc, rawGyr);
	MOVLW       _rawAcc+0
	MOVWF       FARG_LowPassFilter_rawData+0 
	MOVLW       hi_addr(_rawAcc+0)
	MOVWF       FARG_LowPassFilter_rawData+1 
	MOVLW       _rawGyr+0
	MOVWF       FARG_LowPassFilter_rawGyro+0 
	MOVLW       hi_addr(_rawGyr+0)
	MOVWF       FARG_LowPassFilter_rawGyro+1 
	CALL        _LowPassFilter+0, 0
;SafeRoute_PreBeta.c,521 :: 		for(sample = 0; sample < samples; sample++){
	INFSNZ      MPU6050_ReadFilter_sample_L0+0, 1 
	INCF        MPU6050_ReadFilter_sample_L0+1, 1 
;SafeRoute_PreBeta.c,524 :: 		}
	GOTO        L_MPU6050_ReadFilter65
L_MPU6050_ReadFilter66:
;SafeRoute_PreBeta.c,526 :: 		for(ax =0; ax < 3; ax++){
	CLRF        MPU6050_ReadFilter_ax_L0+0 
L_MPU6050_ReadFilter68:
	MOVLW       128
	XORWF       MPU6050_ReadFilter_ax_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MPU6050_ReadFilter69
;SafeRoute_PreBeta.c,527 :: 		calibrateAcc[ax] = filteredData[ax] - accelOffsets[ax];
	MOVF        MPU6050_ReadFilter_ax_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       MPU6050_ReadFilter_ax_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _calibrateAcc+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_calibrateAcc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _filteredData+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_filteredData+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       _accelOffsets+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_accelOffsets+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	SUBWF       R0, 1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      R1, 1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      R2, 1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,528 :: 		calibrateGyro[ax] = filteredGyro[ax] - gyrOffsets[ax];
	MOVF        MPU6050_ReadFilter_ax_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       MPU6050_ReadFilter_ax_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _calibrateGyro+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_calibrateGyro+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVLW       _filteredGyro+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_filteredGyro+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       _gyrOffsets+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_gyrOffsets+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	SUBWF       R0, 1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      R1, 1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      R2, 1 
	MOVF        POSTINC2+0, 0 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,526 :: 		for(ax =0; ax < 3; ax++){
	INCF        MPU6050_ReadFilter_ax_L0+0, 1 
;SafeRoute_PreBeta.c,529 :: 		}
	GOTO        L_MPU6050_ReadFilter68
L_MPU6050_ReadFilter69:
;SafeRoute_PreBeta.c,530 :: 		for(ax =0; ax <3; ax++){
	CLRF        MPU6050_ReadFilter_ax_L0+0 
L_MPU6050_ReadFilter71:
	MOVLW       128
	XORWF       MPU6050_ReadFilter_ax_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MPU6050_ReadFilter72
;SafeRoute_PreBeta.c,531 :: 		gyroDegS[ax] = calibrateGyro[ax] / DEGREE;
	MOVF        MPU6050_ReadFilter_ax_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       MPU6050_ReadFilter_ax_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _gyroDegS+0
	ADDWF       R0, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+0 
	MOVLW       hi_addr(_gyroDegS+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+1 
	MOVLW       _calibrateGyro+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_calibrateGyro+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVFF       FLOC__MPU6050_ReadFilter+0, FSR1L+0
	MOVFF       FLOC__MPU6050_ReadFilter+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,532 :: 		accelMS2[ax] = (calibrateAcc[ax] / RESOLUTION)* GRAVITY;
	MOVF        MPU6050_ReadFilter_ax_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       MPU6050_ReadFilter_ax_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _accelMS2+0
	ADDWF       R0, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+0 
	MOVLW       hi_addr(_accelMS2+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+1 
	MOVLW       _calibrateAcc+0
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_calibrateAcc+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       141
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       195
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVFF       FLOC__MPU6050_ReadFilter+0, FSR1L+0
	MOVFF       FLOC__MPU6050_ReadFilter+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,530 :: 		for(ax =0; ax <3; ax++){
	INCF        MPU6050_ReadFilter_ax_L0+0, 1 
;SafeRoute_PreBeta.c,533 :: 		}
	GOTO        L_MPU6050_ReadFilter71
L_MPU6050_ReadFilter72:
;SafeRoute_PreBeta.c,539 :: 		for(axis = 0; axis < 3; axis++){
	CLRF        MPU6050_ReadFilter_axis_L0+0 
L_MPU6050_ReadFilter74:
	MOVLW       128
	XORWF       MPU6050_ReadFilter_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MPU6050_ReadFilter75
;SafeRoute_PreBeta.c,540 :: 		gravityDirection[axis] = 0.98 * gravityDirection[axis] + 0.02 * accelMS2[axis];
	MOVF        MPU6050_ReadFilter_axis_L0+0, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+6 
	MOVLW       0
	BTFSC       MPU6050_ReadFilter_axis_L0+0, 7 
	MOVLW       255
	MOVWF       FLOC__MPU6050_ReadFilter+7 
	RLCF        FLOC__MPU6050_ReadFilter+6, 1 
	BCF         FLOC__MPU6050_ReadFilter+6, 0 
	RLCF        FLOC__MPU6050_ReadFilter+7, 1 
	RLCF        FLOC__MPU6050_ReadFilter+6, 1 
	BCF         FLOC__MPU6050_ReadFilter+6, 0 
	RLCF        FLOC__MPU6050_ReadFilter+7, 1 
	MOVLW       _gravityDirection+0
	ADDWF       FLOC__MPU6050_ReadFilter+6, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+4 
	MOVLW       hi_addr(_gravityDirection+0)
	ADDWFC      FLOC__MPU6050_ReadFilter+7, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+5 
	MOVFF       FLOC__MPU6050_ReadFilter+4, FSR0L+0
	MOVFF       FLOC__MPU6050_ReadFilter+5, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       72
	MOVWF       R4 
	MOVLW       225
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+0 
	MOVF        R1, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+1 
	MOVF        R2, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+2 
	MOVF        R3, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+3 
	MOVLW       _accelMS2+0
	ADDWF       FLOC__MPU6050_ReadFilter+6, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_accelMS2+0)
	ADDWFC      FLOC__MPU6050_ReadFilter+7, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       121
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__MPU6050_ReadFilter+0, 0 
	MOVWF       R4 
	MOVF        FLOC__MPU6050_ReadFilter+1, 0 
	MOVWF       R5 
	MOVF        FLOC__MPU6050_ReadFilter+2, 0 
	MOVWF       R6 
	MOVF        FLOC__MPU6050_ReadFilter+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVFF       FLOC__MPU6050_ReadFilter+4, FSR1L+0
	MOVFF       FLOC__MPU6050_ReadFilter+5, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,541 :: 		accelMS2[axis] -= gravityDirection[axis];
	MOVF        MPU6050_ReadFilter_axis_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       MPU6050_ReadFilter_axis_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _accelMS2+0
	ADDWF       R0, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+0 
	MOVLW       hi_addr(_accelMS2+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__MPU6050_ReadFilter+1 
	MOVLW       _gravityDirection+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_gravityDirection+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        POSTINC2+0, 0 
	MOVWF       R5 
	MOVF        POSTINC2+0, 0 
	MOVWF       R6 
	MOVF        POSTINC2+0, 0 
	MOVWF       R7 
	MOVFF       FLOC__MPU6050_ReadFilter+0, FSR0L+0
	MOVFF       FLOC__MPU6050_ReadFilter+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FLOC__MPU6050_ReadFilter+0, FSR1L+0
	MOVFF       FLOC__MPU6050_ReadFilter+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;SafeRoute_PreBeta.c,539 :: 		for(axis = 0; axis < 3; axis++){
	INCF        MPU6050_ReadFilter_axis_L0+0, 1 
;SafeRoute_PreBeta.c,542 :: 		}
	GOTO        L_MPU6050_ReadFilter74
L_MPU6050_ReadFilter75:
;SafeRoute_PreBeta.c,544 :: 		}
L_end_MPU6050_ReadFilter:
	RETURN      0
; end of _MPU6050_ReadFilter

_DetectCollision:

;SafeRoute_PreBeta.c,545 :: 		float DetectCollision(float accel[3]){
;SafeRoute_PreBeta.c,546 :: 		int v = 0;
;SafeRoute_PreBeta.c,548 :: 		float magnitude = sqrt(accel[0]*accel[0] + accel[1]*accel[1] + accel[2]*accel[2]);
	MOVFF       FARG_DetectCollision_accel+0, FSR0L+0
	MOVFF       FARG_DetectCollision_accel+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__DetectCollision+0 
	MOVF        R1, 0 
	MOVWF       FLOC__DetectCollision+1 
	MOVF        R2, 0 
	MOVWF       FLOC__DetectCollision+2 
	MOVF        R3, 0 
	MOVWF       FLOC__DetectCollision+3 
	MOVLW       4
	ADDWF       FARG_DetectCollision_accel+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_DetectCollision_accel+1, 0 
	MOVWF       R1 
	MOVLW       4
	ADDWF       FARG_DetectCollision_accel+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_DetectCollision_accel+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        POSTINC2+0, 0 
	MOVWF       R5 
	MOVF        POSTINC2+0, 0 
	MOVWF       R6 
	MOVF        POSTINC2+0, 0 
	MOVWF       R7 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__DetectCollision+0, 0 
	MOVWF       R4 
	MOVF        FLOC__DetectCollision+1, 0 
	MOVWF       R5 
	MOVF        FLOC__DetectCollision+2, 0 
	MOVWF       R6 
	MOVF        FLOC__DetectCollision+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__DetectCollision+0 
	MOVF        R1, 0 
	MOVWF       FLOC__DetectCollision+1 
	MOVF        R2, 0 
	MOVWF       FLOC__DetectCollision+2 
	MOVF        R3, 0 
	MOVWF       FLOC__DetectCollision+3 
	MOVLW       8
	ADDWF       FARG_DetectCollision_accel+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_DetectCollision_accel+1, 0 
	MOVWF       R1 
	MOVLW       8
	ADDWF       FARG_DetectCollision_accel+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_DetectCollision_accel+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        POSTINC2+0, 0 
	MOVWF       R5 
	MOVF        POSTINC2+0, 0 
	MOVWF       R6 
	MOVF        POSTINC2+0, 0 
	MOVWF       R7 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__DetectCollision+0, 0 
	MOVWF       R4 
	MOVF        FLOC__DetectCollision+1, 0 
	MOVWF       R5 
	MOVF        FLOC__DetectCollision+2, 0 
	MOVWF       R6 
	MOVF        FLOC__DetectCollision+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
;SafeRoute_PreBeta.c,558 :: 		return magnitude;
;SafeRoute_PreBeta.c,559 :: 		}
L_end_DetectCollision:
	RETURN      0
; end of _DetectCollision

_CalculateNewMagnitude:

;SafeRoute_PreBeta.c,560 :: 		float CalculateNewMagnitude(){
;SafeRoute_PreBeta.c,562 :: 		MPU6050_ReadFilter(1);
	MOVLW       1
	MOVWF       FARG_MPU6050_ReadFilter_samples+0 
	MOVLW       0
	MOVWF       FARG_MPU6050_ReadFilter_samples+1 
	CALL        _MPU6050_ReadFilter+0, 0
;SafeRoute_PreBeta.c,563 :: 		magnitude = sqrt(gyroDegS[0] * gyroDegS[0] + gyroDegS[1] * gyroDegS[1]);
	MOVF        _gyroDegS+0, 0 
	MOVWF       R0 
	MOVF        _gyroDegS+1, 0 
	MOVWF       R1 
	MOVF        _gyroDegS+2, 0 
	MOVWF       R2 
	MOVF        _gyroDegS+3, 0 
	MOVWF       R3 
	MOVF        _gyroDegS+0, 0 
	MOVWF       R4 
	MOVF        _gyroDegS+1, 0 
	MOVWF       R5 
	MOVF        _gyroDegS+2, 0 
	MOVWF       R6 
	MOVF        _gyroDegS+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__CalculateNewMagnitude+0 
	MOVF        R1, 0 
	MOVWF       FLOC__CalculateNewMagnitude+1 
	MOVF        R2, 0 
	MOVWF       FLOC__CalculateNewMagnitude+2 
	MOVF        R3, 0 
	MOVWF       FLOC__CalculateNewMagnitude+3 
	MOVF        _gyroDegS+4, 0 
	MOVWF       R0 
	MOVF        _gyroDegS+5, 0 
	MOVWF       R1 
	MOVF        _gyroDegS+6, 0 
	MOVWF       R2 
	MOVF        _gyroDegS+7, 0 
	MOVWF       R3 
	MOVF        _gyroDegS+4, 0 
	MOVWF       R4 
	MOVF        _gyroDegS+5, 0 
	MOVWF       R5 
	MOVF        _gyroDegS+6, 0 
	MOVWF       R6 
	MOVF        _gyroDegS+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__CalculateNewMagnitude+0, 0 
	MOVWF       R4 
	MOVF        FLOC__CalculateNewMagnitude+1, 0 
	MOVWF       R5 
	MOVF        FLOC__CalculateNewMagnitude+2, 0 
	MOVWF       R6 
	MOVF        FLOC__CalculateNewMagnitude+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
;SafeRoute_PreBeta.c,564 :: 		return magnitude;
;SafeRoute_PreBeta.c,565 :: 		}
L_end_CalculateNewMagnitude:
	RETURN      0
; end of _CalculateNewMagnitude

_DetectLateralFall:

;SafeRoute_PreBeta.c,566 :: 		short int DetectLateralFall(long timestamp) {
;SafeRoute_PreBeta.c,568 :: 		int v = 0;
;SafeRoute_PreBeta.c,569 :: 		magnitude = sqrt(gyroDegS[0]*gyroDegS[0] + gyroDegS[1]*gyroDegS[1]);
	MOVF        _gyroDegS+0, 0 
	MOVWF       R0 
	MOVF        _gyroDegS+1, 0 
	MOVWF       R1 
	MOVF        _gyroDegS+2, 0 
	MOVWF       R2 
	MOVF        _gyroDegS+3, 0 
	MOVWF       R3 
	MOVF        _gyroDegS+0, 0 
	MOVWF       R4 
	MOVF        _gyroDegS+1, 0 
	MOVWF       R5 
	MOVF        _gyroDegS+2, 0 
	MOVWF       R6 
	MOVF        _gyroDegS+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__DetectLateralFall+0 
	MOVF        R1, 0 
	MOVWF       FLOC__DetectLateralFall+1 
	MOVF        R2, 0 
	MOVWF       FLOC__DetectLateralFall+2 
	MOVF        R3, 0 
	MOVWF       FLOC__DetectLateralFall+3 
	MOVF        _gyroDegS+4, 0 
	MOVWF       R0 
	MOVF        _gyroDegS+5, 0 
	MOVWF       R1 
	MOVF        _gyroDegS+6, 0 
	MOVWF       R2 
	MOVF        _gyroDegS+7, 0 
	MOVWF       R3 
	MOVF        _gyroDegS+4, 0 
	MOVWF       R4 
	MOVF        _gyroDegS+5, 0 
	MOVWF       R5 
	MOVF        _gyroDegS+6, 0 
	MOVWF       R6 
	MOVF        _gyroDegS+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__DetectLateralFall+0, 0 
	MOVWF       R4 
	MOVF        FLOC__DetectLateralFall+1, 0 
	MOVWF       R5 
	MOVF        FLOC__DetectLateralFall+2, 0 
	MOVWF       R6 
	MOVF        FLOC__DetectLateralFall+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
	MOVF        R0, 0 
	MOVWF       DetectLateralFall_magnitude_L0+0 
	MOVF        R1, 0 
	MOVWF       DetectLateralFall_magnitude_L0+1 
	MOVF        R2, 0 
	MOVWF       DetectLateralFall_magnitude_L0+2 
	MOVF        R3, 0 
	MOVWF       DetectLateralFall_magnitude_L0+3 
;SafeRoute_PreBeta.c,570 :: 		if (magnitude > ANGULAR_VELOCITY_THRESHOLD) {
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       122
	MOVWF       R2 
	MOVLW       135
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DetectLateralFall77
;SafeRoute_PreBeta.c,572 :: 		float endTime = timestamp + ANGULAR_VELOCITY_DURATION_THRESHOLD;
	MOVLW       5
	ADDWF       FARG_DetectLateralFall_timestamp+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_DetectLateralFall_timestamp+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_DetectLateralFall_timestamp+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      FARG_DetectLateralFall_timestamp+3, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVF        R0, 0 
	MOVWF       DetectLateralFall_endTime_L1+0 
	MOVF        R1, 0 
	MOVWF       DetectLateralFall_endTime_L1+1 
	MOVF        R2, 0 
	MOVWF       DetectLateralFall_endTime_L1+2 
	MOVF        R3, 0 
	MOVWF       DetectLateralFall_endTime_L1+3 
;SafeRoute_PreBeta.c,573 :: 		while (timeStamp < endTime) {
L_DetectLateralFall78:
	MOVF        FARG_DetectLateralFall_timestamp+0, 0 
	MOVWF       R0 
	MOVF        FARG_DetectLateralFall_timestamp+1, 0 
	MOVWF       R1 
	MOVF        FARG_DetectLateralFall_timestamp+2, 0 
	MOVWF       R2 
	MOVF        FARG_DetectLateralFall_timestamp+3, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVF        DetectLateralFall_endTime_L1+0, 0 
	MOVWF       R4 
	MOVF        DetectLateralFall_endTime_L1+1, 0 
	MOVWF       R5 
	MOVF        DetectLateralFall_endTime_L1+2, 0 
	MOVWF       R6 
	MOVF        DetectLateralFall_endTime_L1+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DetectLateralFall79
;SafeRoute_PreBeta.c,574 :: 		float newMagnitude = CalculateNewMagnitude();  // Calculate magnitude at the current time step
	CALL        _CalculateNewMagnitude+0, 0
;SafeRoute_PreBeta.c,575 :: 		if (newMagnitude > ANGULAR_VELOCITY_THRESHOLD) {
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       122
	MOVWF       R2 
	MOVLW       135
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DetectLateralFall80
;SafeRoute_PreBeta.c,578 :: 		StreamAccel(VALUE, FALL, magnitude, gyroDegS);
	MOVLW       51
	MOVWF       FARG_StreamAccel_function+0 
	MOVLW       66
	MOVWF       FARG_StreamAccel_event+0 
	MOVF        DetectLateralFall_magnitude_L0+0, 0 
	MOVWF       FARG_StreamAccel_magnitude+0 
	MOVF        DetectLateralFall_magnitude_L0+1, 0 
	MOVWF       FARG_StreamAccel_magnitude+1 
	MOVF        DetectLateralFall_magnitude_L0+2, 0 
	MOVWF       FARG_StreamAccel_magnitude+2 
	MOVF        DetectLateralFall_magnitude_L0+3, 0 
	MOVWF       FARG_StreamAccel_magnitude+3 
	MOVLW       _gyroDegS+0
	MOVWF       FARG_StreamAccel_vecAxis+0 
	MOVLW       hi_addr(_gyroDegS+0)
	MOVWF       FARG_StreamAccel_vecAxis+1 
	CALL        _StreamAccel+0, 0
;SafeRoute_PreBeta.c,581 :: 		return 1;  // Fall event did not persist for the required duration
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_DetectLateralFall
;SafeRoute_PreBeta.c,582 :: 		}
L_DetectLateralFall80:
;SafeRoute_PreBeta.c,583 :: 		}
	GOTO        L_DetectLateralFall78
L_DetectLateralFall79:
;SafeRoute_PreBeta.c,585 :: 		if (gyroDegS[1] > ANGULAR_VELOCITY_THRESHOLD) {
	MOVF        _gyroDegS+4, 0 
	MOVWF       R4 
	MOVF        _gyroDegS+5, 0 
	MOVWF       R5 
	MOVF        _gyroDegS+6, 0 
	MOVWF       R6 
	MOVF        _gyroDegS+7, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       122
	MOVWF       R2 
	MOVLW       135
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DetectLateralFall81
;SafeRoute_PreBeta.c,588 :: 		StreamAccel(VALUE, FALL, magnitude, gyroDegS);
	MOVLW       51
	MOVWF       FARG_StreamAccel_function+0 
	MOVLW       66
	MOVWF       FARG_StreamAccel_event+0 
	MOVF        DetectLateralFall_magnitude_L0+0, 0 
	MOVWF       FARG_StreamAccel_magnitude+0 
	MOVF        DetectLateralFall_magnitude_L0+1, 0 
	MOVWF       FARG_StreamAccel_magnitude+1 
	MOVF        DetectLateralFall_magnitude_L0+2, 0 
	MOVWF       FARG_StreamAccel_magnitude+2 
	MOVF        DetectLateralFall_magnitude_L0+3, 0 
	MOVWF       FARG_StreamAccel_magnitude+3 
	MOVLW       _gyroDegS+0
	MOVWF       FARG_StreamAccel_vecAxis+0 
	MOVLW       hi_addr(_gyroDegS+0)
	MOVWF       FARG_StreamAccel_vecAxis+1 
	CALL        _StreamAccel+0, 0
;SafeRoute_PreBeta.c,590 :: 		return 1;  // Lateral fall detected
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_DetectLateralFall
;SafeRoute_PreBeta.c,591 :: 		}
L_DetectLateralFall81:
;SafeRoute_PreBeta.c,592 :: 		}
L_DetectLateralFall77:
;SafeRoute_PreBeta.c,593 :: 		return 0;  // No fall detected
	CLRF        R0 
;SafeRoute_PreBeta.c,594 :: 		}
L_end_DetectLateralFall:
	RETURN      0
; end of _DetectLateralFall

_TurnOn:

;SafeRoute_PreBeta.c,596 :: 		void TurnOn(){
;SafeRoute_PreBeta.c,597 :: 		delay_us(15);
	MOVLW       19
	MOVWF       R13, 0
L_TurnOn82:
	DECFSZ      R13, 1, 1
	BRA         L_TurnOn82
	NOP
	NOP
;SafeRoute_PreBeta.c,598 :: 		asm CLRWDT;
	CLRWDT
;SafeRoute_PreBeta.c,600 :: 		isOn = 0;
	CLRF        _isOn+0 
;SafeRoute_PreBeta.c,601 :: 		firstTime = 1;
	MOVLW       1
	MOVWF       _firstTime+0 
;SafeRoute_PreBeta.c,602 :: 		pinShutdown = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SafeRoute_PreBeta.c,603 :: 		delay_ms(5);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_TurnOn83:
	DECFSZ      R13, 1, 1
	BRA         L_TurnOn83
	DECFSZ      R12, 1, 1
	BRA         L_TurnOn83
	NOP
;SafeRoute_PreBeta.c,604 :: 		pinBTRst = 1;
	BSF         RB4_bit+0, BitPos(RB4_bit+0) 
;SafeRoute_PreBeta.c,607 :: 		}
L_end_TurnOn:
	RETURN      0
; end of _TurnOn

_TurnOff:

;SafeRoute_PreBeta.c,608 :: 		void TurnOff(){
;SafeRoute_PreBeta.c,610 :: 		pinLedIndicator = 1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,611 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_TurnOff84:
	DECFSZ      R13, 1, 1
	BRA         L_TurnOff84
	DECFSZ      R12, 1, 1
	BRA         L_TurnOff84
	DECFSZ      R11, 1, 1
	BRA         L_TurnOff84
	NOP
	NOP
;SafeRoute_PreBeta.c,612 :: 		pinLedIndicator = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,613 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_TurnOff85:
	DECFSZ      R13, 1, 1
	BRA         L_TurnOff85
	DECFSZ      R12, 1, 1
	BRA         L_TurnOff85
	DECFSZ      R11, 1, 1
	BRA         L_TurnOff85
	NOP
	NOP
;SafeRoute_PreBeta.c,614 :: 		pinLedIndicator = 1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,615 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_TurnOff86:
	DECFSZ      R13, 1, 1
	BRA         L_TurnOff86
	DECFSZ      R12, 1, 1
	BRA         L_TurnOff86
	DECFSZ      R11, 1, 1
	BRA         L_TurnOff86
	NOP
	NOP
;SafeRoute_PreBeta.c,616 :: 		pinLedIndicator = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,617 :: 		pinShutdown = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SafeRoute_PreBeta.c,618 :: 		firstTime = 0;
	CLRF        _firstTime+0 
;SafeRoute_PreBeta.c,619 :: 		pinBTRst = 0;
	BCF         RB4_bit+0, BitPos(RB4_bit+0) 
;SafeRoute_PreBeta.c,620 :: 		isPress = 0;
	CLRF        _isPress+0 
;SafeRoute_PreBeta.c,621 :: 		timePress = 0;
	CLRF        _timePress+0 
	CLRF        _timePress+1 
;SafeRoute_PreBeta.c,622 :: 		isOn = 0;
	CLRF        _isOn+0 
;SafeRoute_PreBeta.c,623 :: 		asm sleep;
	SLEEP
;SafeRoute_PreBeta.c,624 :: 		}
L_end_TurnOff:
	RETURN      0
; end of _TurnOff

_InitMicro:

;SafeRoute_PreBeta.c,626 :: 		void InitMicro(){
;SafeRoute_PreBeta.c,628 :: 		OSCCON = 0x70; //16MHz osc interno
	MOVLW       112
	MOVWF       OSCCON+0 
;SafeRoute_PreBeta.c,629 :: 		OSCCON2 = 0x00;
	CLRF        OSCCON2+0 
;SafeRoute_PreBeta.c,630 :: 		OSCTUNE = 0xAF;
	MOVLW       175
	MOVWF       OSCTUNE+0 
;SafeRoute_PreBeta.c,632 :: 		ANSELA = 0x03; //Habilita AN0 y AN1 para ADC bat y alc
	MOVLW       3
	MOVWF       ANSELA+0 
;SafeRoute_PreBeta.c,633 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;SafeRoute_PreBeta.c,634 :: 		ANSELC = 0x00;
	CLRF        ANSELC+0 
;SafeRoute_PreBeta.c,636 :: 		CM1CON0 = 0;
	CLRF        CM1CON0+0 
;SafeRoute_PreBeta.c,637 :: 		CM2CON0 = 0;
	CLRF        CM2CON0+0 
;SafeRoute_PreBeta.c,638 :: 		CM2CON1 = 0;
	CLRF        CM2CON1+0 
;SafeRoute_PreBeta.c,640 :: 		ADCON0 = 0x00;
	CLRF        ADCON0+0 
;SafeRoute_PreBeta.c,641 :: 		ADCON1 = 0x08;
	MOVLW       8
	MOVWF       ADCON1+0 
;SafeRoute_PreBeta.c,643 :: 		TRISA =  0x27;
	MOVLW       39
	MOVWF       TRISA+0 
;SafeRoute_PreBeta.c,654 :: 		TRISB = 0x03;
	MOVLW       3
	MOVWF       TRISB+0 
;SafeRoute_PreBeta.c,663 :: 		TRISC = 0xA0;
	MOVLW       160
	MOVWF       TRISC+0 
;SafeRoute_PreBeta.c,674 :: 		LATA = 0x00;
	CLRF        LATA+0 
;SafeRoute_PreBeta.c,675 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;SafeRoute_PreBeta.c,676 :: 		INTCON2.RBPU = 1;
	BSF         INTCON2+0, 7 
;SafeRoute_PreBeta.c,678 :: 		}
L_end_InitMicro:
	RETURN      0
; end of _InitMicro

_InitInterrupt:

;SafeRoute_PreBeta.c,679 :: 		void InitInterrupt(){
;SafeRoute_PreBeta.c,682 :: 		T1CON = 0x01;
	MOVLW       1
	MOVWF       T1CON+0 
;SafeRoute_PreBeta.c,683 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;SafeRoute_PreBeta.c,684 :: 		TMR1H = 0x63;
	MOVLW       99
	MOVWF       TMR1H+0 
;SafeRoute_PreBeta.c,685 :: 		TMR1L  = 0xC0;
	MOVLW       192
	MOVWF       TMR1L+0 
;SafeRoute_PreBeta.c,686 :: 		TMR1IP_bit = 0;
	BCF         TMR1IP_bit+0, BitPos(TMR1IP_bit+0) 
;SafeRoute_PreBeta.c,687 :: 		TMR1IE_bit = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;SafeRoute_PreBeta.c,688 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;SafeRoute_PreBeta.c,690 :: 		INT0IE_bit = 1;
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;SafeRoute_PreBeta.c,691 :: 		INTEDG0_bit = 1;
	BSF         INTEDG0_bit+0, BitPos(INTEDG0_bit+0) 
;SafeRoute_PreBeta.c,692 :: 		GIE_bit = 1;  //Habilitamos interupciones globales
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SafeRoute_PreBeta.c,693 :: 		IPEN_bit = 1; //Habilitamos niveles de interrupción
	BSF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;SafeRoute_PreBeta.c,694 :: 		PEIE_bit = 1; //Habilitamos interrupciones perifericas
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;SafeRoute_PreBeta.c,695 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_main:

;SafeRoute_PreBeta.c,696 :: 		void main() {
;SafeRoute_PreBeta.c,698 :: 		InitMicro();
	CALL        _InitMicro+0, 0
;SafeRoute_PreBeta.c,700 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;SafeRoute_PreBeta.c,704 :: 		TurnOn();
	CALL        _TurnOn+0, 0
;SafeRoute_PreBeta.c,706 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SafeRoute_PreBeta.c,707 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main87:
	DECFSZ      R13, 1, 1
	BRA         L_main87
	DECFSZ      R12, 1, 1
	BRA         L_main87
	DECFSZ      R11, 1, 1
	BRA         L_main87
;SafeRoute_PreBeta.c,709 :: 		MPU6050_Init();
	CALL        _MPU6050_Init+0, 0
;SafeRoute_PreBeta.c,710 :: 		while(1){
L_main88:
;SafeRoute_PreBeta.c,711 :: 		if(isOn){
	MOVF        _isOn+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main90
;SafeRoute_PreBeta.c,714 :: 		if(timeToSend > 1){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _timeToSend+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main212
	MOVF        _timeToSend+0, 0 
	SUBLW       1
L__main212:
	BTFSC       STATUS+0, 0 
	GOTO        L_main91
;SafeRoute_PreBeta.c,715 :: 		pinLedIndicator = !pinLedIndicator;
	BTG         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,716 :: 		StreamFixed(ERROR, CONSOLA, ON);
	MOVLW       55
	MOVWF       FARG_StreamFixed_function+0 
	MOVLW       67
	MOVWF       FARG_StreamFixed_sensor+0 
	MOVLW       49
	MOVWF       FARG_StreamFixed_state+0 
	CALL        _StreamFixed+0, 0
;SafeRoute_PreBeta.c,717 :: 		tempAlc = GetTemp();
	CALL        _GetTemp+0, 0
	MOVF        R0, 0 
	MOVWF       _tempAlc+0 
	MOVF        R1, 0 
	MOVWF       _tempAlc+1 
;SafeRoute_PreBeta.c,718 :: 		if(tempAlc == 0){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main213
	MOVLW       0
	XORWF       R0, 0 
L__main213:
	BTFSS       STATUS+0, 2 
	GOTO        L_main92
;SafeRoute_PreBeta.c,719 :: 		StreamFixed(ERROR, TEMPTALC, ON);
	MOVLW       55
	MOVWF       FARG_StreamFixed_function+0 
	MOVLW       66
	MOVWF       FARG_StreamFixed_sensor+0 
	MOVLW       49
	MOVWF       FARG_StreamFixed_state+0 
	CALL        _StreamFixed+0, 0
;SafeRoute_PreBeta.c,720 :: 		}
L_main92:
;SafeRoute_PreBeta.c,721 :: 		StreamFunction(TEMP, ALC, tempAlc);
	MOVLW       49
	MOVWF       FARG_StreamFunction_function+0 
	MOVLW       65
	MOVWF       FARG_StreamFunction_sensor+0 
	MOVF        _tempAlc+0, 0 
	MOVWF       R0 
	MOVF        _tempAlc+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_StreamFunction_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_StreamFunction_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_StreamFunction_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_StreamFunction_value+3 
	CALL        _StreamFunction+0, 0
;SafeRoute_PreBeta.c,722 :: 		StreamFunction(TEMP, ACCEL, tempMicro);
	MOVLW       49
	MOVWF       FARG_StreamFunction_function+0 
	MOVLW       66
	MOVWF       FARG_StreamFunction_sensor+0 
	MOVF        _tempMicro+0, 0 
	MOVWF       R0 
	MOVF        _tempMicro+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_StreamFunction_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_StreamFunction_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_StreamFunction_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_StreamFunction_value+3 
	CALL        _StreamFunction+0, 0
;SafeRoute_PreBeta.c,723 :: 		SendBattery();
	CALL        _SendBattery+0, 0
;SafeRoute_PreBeta.c,724 :: 		timeToSend = 0;
	CLRF        _timeToSend+0 
	CLRF        _timeToSend+1 
;SafeRoute_PreBeta.c,725 :: 		}
L_main91:
;SafeRoute_PreBeta.c,727 :: 		if(tempMicro > 65){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _tempMicro+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main214
	MOVF        _tempMicro+0, 0 
	SUBLW       65
L__main214:
	BTFSC       STATUS+0, 0 
	GOTO        L_main93
;SafeRoute_PreBeta.c,728 :: 		StreamFunction(SEG, ACCEL, tempMicro);
	MOVLW       53
	MOVWF       FARG_StreamFunction_function+0 
	MOVLW       66
	MOVWF       FARG_StreamFunction_sensor+0 
	MOVF        _tempMicro+0, 0 
	MOVWF       R0 
	MOVF        _tempMicro+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_StreamFunction_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_StreamFunction_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_StreamFunction_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_StreamFunction_value+3 
	CALL        _StreamFunction+0, 0
;SafeRoute_PreBeta.c,729 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main94:
	DECFSZ      R13, 1, 1
	BRA         L_main94
	DECFSZ      R12, 1, 1
	BRA         L_main94
	DECFSZ      R11, 1, 1
	BRA         L_main94
;SafeRoute_PreBeta.c,730 :: 		TurnOff();
	CALL        _TurnOff+0, 0
;SafeRoute_PreBeta.c,731 :: 		}
L_main93:
;SafeRoute_PreBeta.c,734 :: 		MPU6050_ReadFilter(1);
	MOVLW       1
	MOVWF       FARG_MPU6050_ReadFilter_samples+0 
	MOVLW       0
	MOVWF       FARG_MPU6050_ReadFilter_samples+1 
	CALL        _MPU6050_ReadFilter+0, 0
;SafeRoute_PreBeta.c,736 :: 		magCol = DetectCollision(accelMS2);
	MOVLW       _accelMS2+0
	MOVWF       FARG_DetectCollision_accel+0 
	MOVLW       hi_addr(_accelMS2+0)
	MOVWF       FARG_DetectCollision_accel+1 
	CALL        _DetectCollision+0, 0
	MOVF        R0, 0 
	MOVWF       _magCol+0 
	MOVF        R1, 0 
	MOVWF       _magCol+1 
	MOVF        R2, 0 
	MOVWF       _magCol+2 
	MOVF        R3, 0 
	MOVWF       _magCol+3 
;SafeRoute_PreBeta.c,737 :: 		if(magCol > THRESHOLD){
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main95
;SafeRoute_PreBeta.c,739 :: 		StreamAccel(VALUE, COL, magCol, accelMS2);
	MOVLW       51
	MOVWF       FARG_StreamAccel_function+0 
	MOVLW       67
	MOVWF       FARG_StreamAccel_event+0 
	MOVF        _magCol+0, 0 
	MOVWF       FARG_StreamAccel_magnitude+0 
	MOVF        _magCol+1, 0 
	MOVWF       FARG_StreamAccel_magnitude+1 
	MOVF        _magCol+2, 0 
	MOVWF       FARG_StreamAccel_magnitude+2 
	MOVF        _magCol+3, 0 
	MOVWF       FARG_StreamAccel_magnitude+3 
	MOVLW       _accelMS2+0
	MOVWF       FARG_StreamAccel_vecAxis+0 
	MOVLW       hi_addr(_accelMS2+0)
	MOVWF       FARG_StreamAccel_vecAxis+1 
	CALL        _StreamAccel+0, 0
;SafeRoute_PreBeta.c,762 :: 		}
L_main95:
;SafeRoute_PreBeta.c,763 :: 		if(DetectLateralFall(timeStamp)){
	MOVF        _timeStamp+0, 0 
	MOVWF       FARG_DetectLateralFall_timestamp+0 
	MOVF        _timeStamp+1, 0 
	MOVWF       FARG_DetectLateralFall_timestamp+1 
	MOVF        _timeStamp+2, 0 
	MOVWF       FARG_DetectLateralFall_timestamp+2 
	MOVF        _timeStamp+3, 0 
	MOVWF       FARG_DetectLateralFall_timestamp+3 
	CALL        _DetectLateralFall+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main96
;SafeRoute_PreBeta.c,767 :: 		}
L_main96:
;SafeRoute_PreBeta.c,769 :: 		tempAlc = GetTemp();
	CALL        _GetTemp+0, 0
	MOVF        R0, 0 
	MOVWF       _tempAlc+0 
	MOVF        R1, 0 
	MOVWF       _tempAlc+1 
;SafeRoute_PreBeta.c,770 :: 		if(tempAlc < MAX_ALC_TEMP && tempAlc!= 0){
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main215
	MOVLW       70
	SUBWF       R0, 0 
L__main215:
	BTFSC       STATUS+0, 0 
	GOTO        L_main99
	MOVLW       0
	XORWF       _tempAlc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main216
	MOVLW       0
	XORWF       _tempAlc+0, 0 
L__main216:
	BTFSC       STATUS+0, 2 
	GOTO        L_main99
L__main172:
;SafeRoute_PreBeta.c,771 :: 		if(tempAlc > 22 && secondsHeat > 19){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _tempAlc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main217
	MOVF        _tempAlc+0, 0 
	SUBLW       22
L__main217:
	BTFSC       STATUS+0, 0 
	GOTO        L_main102
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _secondsHeat+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main218
	MOVF        _secondsHeat+0, 0 
	SUBLW       19
L__main218:
	BTFSC       STATUS+0, 0 
	GOTO        L_main102
L__main171:
;SafeRoute_PreBeta.c,772 :: 		if(!isRest){
	MOVF        _isRest+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main103
;SafeRoute_PreBeta.c,773 :: 		if(secondsReading < 60){
	MOVLW       128
	XORWF       _secondsReading+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main219
	MOVLW       60
	SUBWF       _secondsReading+0, 0 
L__main219:
	BTFSC       STATUS+0, 0 
	GOTO        L_main104
;SafeRoute_PreBeta.c,774 :: 		gradeAlc = ReadingAlcohol();
	CALL        _ReadingAlcohol+0, 0
	MOVF        R0, 0 
	MOVWF       _gradeAlc+0 
;SafeRoute_PreBeta.c,775 :: 		if(secondsReading != auxSecRead){
	MOVF        _secondsReading+1, 0 
	XORWF       _auxSecRead+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main220
	MOVF        _auxSecRead+0, 0 
	XORWF       _secondsReading+0, 0 
L__main220:
	BTFSC       STATUS+0, 2 
	GOTO        L_main105
;SafeRoute_PreBeta.c,776 :: 		StreamFixed(STATE, ALC, ON);
	MOVLW       50
	MOVWF       FARG_StreamFixed_function+0 
	MOVLW       65
	MOVWF       FARG_StreamFixed_sensor+0 
	MOVLW       49
	MOVWF       FARG_StreamFixed_state+0 
	CALL        _StreamFixed+0, 0
;SafeRoute_PreBeta.c,777 :: 		StreamFunction(TEMP, ALC, tempAlc);
	MOVLW       49
	MOVWF       FARG_StreamFunction_function+0 
	MOVLW       65
	MOVWF       FARG_StreamFunction_sensor+0 
	MOVF        _tempAlc+0, 0 
	MOVWF       R0 
	MOVF        _tempAlc+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_StreamFunction_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_StreamFunction_value+1 
	MOVF        R2, 0 
	MOVWF       FARG_StreamFunction_value+2 
	MOVF        R3, 0 
	MOVWF       FARG_StreamFunction_value+3 
	CALL        _StreamFunction+0, 0
;SafeRoute_PreBeta.c,778 :: 		if(gradeAlc > 0) {
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _gradeAlc+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main106
;SafeRoute_PreBeta.c,779 :: 		StreamAlcohol(FLAG, gradeAlc, mglAlcohol);
	MOVLW       52
	MOVWF       FARG_StreamAlcohol_function+0 
	MOVF        _gradeAlc+0, 0 
	MOVWF       FARG_StreamAlcohol_grade+0 
	MOVLW       0
	BTFSC       _gradeAlc+0, 7 
	MOVLW       255
	MOVWF       FARG_StreamAlcohol_grade+1 
	MOVF        _mglALcohol+0, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+3 
	CALL        _StreamAlcohol+0, 0
;SafeRoute_PreBeta.c,780 :: 		}
	GOTO        L_main107
L_main106:
;SafeRoute_PreBeta.c,782 :: 		StreamAlcohol(VALUE, gradeAlc, mglAlcohol);
	MOVLW       51
	MOVWF       FARG_StreamAlcohol_function+0 
	MOVF        _gradeAlc+0, 0 
	MOVWF       FARG_StreamAlcohol_grade+0 
	MOVLW       0
	BTFSC       _gradeAlc+0, 7 
	MOVLW       255
	MOVWF       FARG_StreamAlcohol_grade+1 
	MOVF        _mglALcohol+0, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+3 
	CALL        _StreamAlcohol+0, 0
;SafeRoute_PreBeta.c,783 :: 		}
L_main107:
;SafeRoute_PreBeta.c,784 :: 		auxSecRead = secondsReading;
	MOVF        _secondsReading+0, 0 
	MOVWF       _auxSecRead+0 
	MOVF        _secondsReading+1, 0 
	MOVWF       _auxSecRead+1 
;SafeRoute_PreBeta.c,785 :: 		}
L_main105:
;SafeRoute_PreBeta.c,786 :: 		}
	GOTO        L_main108
L_main104:
;SafeRoute_PreBeta.c,788 :: 		secondsRest =0;
	CLRF        _secondsRest+0 
	CLRF        _secondsRest+1 
;SafeRoute_PreBeta.c,789 :: 		secondsReading = 0;
	CLRF        _secondsReading+0 
	CLRF        _secondsReading+1 
;SafeRoute_PreBeta.c,790 :: 		isRest = 1;
	MOVLW       1
	MOVWF       _isRest+0 
;SafeRoute_PreBeta.c,791 :: 		pinAlcCtrl = 0;
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;SafeRoute_PreBeta.c,793 :: 		}
L_main108:
;SafeRoute_PreBeta.c,794 :: 		}
	GOTO        L_main109
L_main103:
;SafeRoute_PreBeta.c,796 :: 		if(secondsRest!=secondsRestAux){
	MOVF        _secondsRest+1, 0 
	XORWF       _secondsRestAux+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main221
	MOVF        _secondsRestAux+0, 0 
	XORWF       _secondsRest+0, 0 
L__main221:
	BTFSC       STATUS+0, 2 
	GOTO        L_main110
;SafeRoute_PreBeta.c,797 :: 		StreamFixed(STATE, ALC, OFF);
	MOVLW       50
	MOVWF       FARG_StreamFixed_function+0 
	MOVLW       65
	MOVWF       FARG_StreamFixed_sensor+0 
	MOVLW       48
	MOVWF       FARG_StreamFixed_state+0 
	CALL        _StreamFixed+0, 0
;SafeRoute_PreBeta.c,798 :: 		secondsRestAux = secondsRest;
	MOVF        _secondsRest+0, 0 
	MOVWF       _secondsRestAux+0 
	MOVF        _secondsRest+1, 0 
	MOVWF       _secondsRestAux+1 
;SafeRoute_PreBeta.c,799 :: 		}
L_main110:
;SafeRoute_PreBeta.c,800 :: 		if(secondsRest > 30){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _secondsRest+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main222
	MOVF        _secondsRest+0, 0 
	SUBLW       30
L__main222:
	BTFSC       STATUS+0, 0 
	GOTO        L_main111
;SafeRoute_PreBeta.c,801 :: 		millis = 0;
	CLRF        _millis+0 
	CLRF        _millis+1 
;SafeRoute_PreBeta.c,802 :: 		secondsAux = 99;
	MOVLW       99
	MOVWF       _secondsAux+0 
	MOVLW       0
	MOVWF       _secondsAux+1 
;SafeRoute_PreBeta.c,803 :: 		secondsHeat =0;
	CLRF        _secondsHeat+0 
	CLRF        _secondsHeat+1 
;SafeRoute_PreBeta.c,804 :: 		secondsRest =0;
	CLRF        _secondsRest+0 
	CLRF        _secondsRest+1 
;SafeRoute_PreBeta.c,805 :: 		isRest =0;
	CLRF        _isRest+0 
;SafeRoute_PreBeta.c,806 :: 		}
L_main111:
;SafeRoute_PreBeta.c,807 :: 		}
L_main109:
;SafeRoute_PreBeta.c,808 :: 		}
	GOTO        L_main112
L_main102:
;SafeRoute_PreBeta.c,809 :: 		else if(secondsHeat != secondsAux){  //calienta sensor envia datos alcoholimetro
	MOVF        _secondsHeat+1, 0 
	XORWF       _secondsAux+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main223
	MOVF        _secondsAux+0, 0 
	XORWF       _secondsHeat+0, 0 
L__main223:
	BTFSC       STATUS+0, 2 
	GOTO        L_main113
;SafeRoute_PreBeta.c,810 :: 		pinAlcCtrl = 1;
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
;SafeRoute_PreBeta.c,811 :: 		StreamFixed(STATE, ALC, ON);
	MOVLW       50
	MOVWF       FARG_StreamFixed_function+0 
	MOVLW       65
	MOVWF       FARG_StreamFixed_sensor+0 
	MOVLW       49
	MOVWF       FARG_StreamFixed_state+0 
	CALL        _StreamFixed+0, 0
;SafeRoute_PreBeta.c,812 :: 		if(gradeAlc > 0) {
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _gradeAlc+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main114
;SafeRoute_PreBeta.c,813 :: 		StreamAlcohol(FLAG, gradeAlc, mglAlcohol);
	MOVLW       52
	MOVWF       FARG_StreamAlcohol_function+0 
	MOVF        _gradeAlc+0, 0 
	MOVWF       FARG_StreamAlcohol_grade+0 
	MOVLW       0
	BTFSC       _gradeAlc+0, 7 
	MOVLW       255
	MOVWF       FARG_StreamAlcohol_grade+1 
	MOVF        _mglALcohol+0, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+3 
	CALL        _StreamAlcohol+0, 0
;SafeRoute_PreBeta.c,814 :: 		}
	GOTO        L_main115
L_main114:
;SafeRoute_PreBeta.c,816 :: 		StreamAlcohol(VALUE, gradeAlc, mglAlcohol);
	MOVLW       51
	MOVWF       FARG_StreamAlcohol_function+0 
	MOVF        _gradeAlc+0, 0 
	MOVWF       FARG_StreamAlcohol_grade+0 
	MOVLW       0
	BTFSC       _gradeAlc+0, 7 
	MOVLW       255
	MOVWF       FARG_StreamAlcohol_grade+1 
	MOVF        _mglALcohol+0, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+0 
	MOVF        _mglALcohol+1, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+1 
	MOVF        _mglALcohol+2, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+2 
	MOVF        _mglALcohol+3, 0 
	MOVWF       FARG_StreamAlcohol_cienMgsMl+3 
	CALL        _StreamAlcohol+0, 0
;SafeRoute_PreBeta.c,817 :: 		}
L_main115:
;SafeRoute_PreBeta.c,818 :: 		secondsAux = secondsHeat;
	MOVF        _secondsHeat+0, 0 
	MOVWF       _secondsAux+0 
	MOVF        _secondsHeat+1, 0 
	MOVWF       _secondsAux+1 
;SafeRoute_PreBeta.c,819 :: 		}
L_main113:
L_main112:
;SafeRoute_PreBeta.c,820 :: 		}
	GOTO        L_main116
L_main99:
;SafeRoute_PreBeta.c,822 :: 		secondsRest =0;
	CLRF        _secondsRest+0 
	CLRF        _secondsRest+1 
;SafeRoute_PreBeta.c,823 :: 		secondsReading = 0;
	CLRF        _secondsReading+0 
	CLRF        _secondsReading+1 
;SafeRoute_PreBeta.c,824 :: 		isRest = 1;
	MOVLW       1
	MOVWF       _isRest+0 
;SafeRoute_PreBeta.c,825 :: 		pinAlcCtrl = 0;
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;SafeRoute_PreBeta.c,826 :: 		}
L_main116:
;SafeRoute_PreBeta.c,828 :: 		if(!pinButton && isPress){
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main119
	MOVF        _isPress+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main119
L__main170:
;SafeRoute_PreBeta.c,830 :: 		if(timePress > 3 && timePress <= 6){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _timePress+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main224
	MOVF        _timePress+0, 0 
	SUBLW       3
L__main224:
	BTFSC       STATUS+0, 0 
	GOTO        L_main122
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _timePress+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main225
	MOVF        _timePress+0, 0 
	SUBLW       6
L__main225:
	BTFSS       STATUS+0, 0 
	GOTO        L_main122
L__main169:
;SafeRoute_PreBeta.c,832 :: 		pinBT1 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,833 :: 		pinLedIndicator =1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,834 :: 		delay_ms(2000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main123:
	DECFSZ      R13, 1, 1
	BRA         L_main123
	DECFSZ      R12, 1, 1
	BRA         L_main123
	DECFSZ      R11, 1, 1
	BRA         L_main123
;SafeRoute_PreBeta.c,835 :: 		CalibrateMPU6050(100); //calibración del acelerometro
	MOVLW       100
	MOVWF       FARG_CalibrateMPU6050_samples+0 
	MOVLW       0
	MOVWF       FARG_CalibrateMPU6050_samples+1 
	CALL        _CalibrateMPU6050+0, 0
;SafeRoute_PreBeta.c,836 :: 		pinBT1 = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,837 :: 		pinLedIndicator =0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,839 :: 		}
	GOTO        L_main124
L_main122:
;SafeRoute_PreBeta.c,840 :: 		else if(timePress >= 2 && timePress <= 3){
	MOVLW       128
	XORWF       _timePress+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main226
	MOVLW       2
	SUBWF       _timePress+0, 0 
L__main226:
	BTFSS       STATUS+0, 0 
	GOTO        L_main127
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _timePress+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main227
	MOVF        _timePress+0, 0 
	SUBLW       3
L__main227:
	BTFSS       STATUS+0, 0 
	GOTO        L_main127
L__main168:
;SafeRoute_PreBeta.c,841 :: 		if(!pinBT0){
	BTFSC       RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_main128
;SafeRoute_PreBeta.c,843 :: 		pinBT4 = 1;
	BSF         RA6_bit+0, BitPos(RA6_bit+0) 
;SafeRoute_PreBeta.c,844 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main129:
	DECFSZ      R13, 1, 1
	BRA         L_main129
	DECFSZ      R12, 1, 1
	BRA         L_main129
	DECFSZ      R11, 1, 1
	BRA         L_main129
	NOP
	NOP
;SafeRoute_PreBeta.c,845 :: 		pinBT4 = 0;
	BCF         RA6_bit+0, BitPos(RA6_bit+0) 
;SafeRoute_PreBeta.c,846 :: 		}
L_main128:
;SafeRoute_PreBeta.c,847 :: 		}
	GOTO        L_main130
L_main127:
;SafeRoute_PreBeta.c,848 :: 		else if(timePress <= 1){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _timePress+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main228
	MOVF        _timePress+0, 0 
	SUBLW       1
L__main228:
	BTFSS       STATUS+0, 0 
	GOTO        L_main131
;SafeRoute_PreBeta.c,849 :: 		if(!pinBT0){
	BTFSC       RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_main132
;SafeRoute_PreBeta.c,850 :: 		if(pinBT9 && !isPickUp){
	BTFSS       RC5_bit+0, BitPos(RC5_bit+0) 
	GOTO        L_main135
	MOVF        _isPickUp+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main135
L__main167:
;SafeRoute_PreBeta.c,854 :: 		pinBT1 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,855 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main136:
	DECFSZ      R13, 1, 1
	BRA         L_main136
	DECFSZ      R12, 1, 1
	BRA         L_main136
	DECFSZ      R11, 1, 1
	BRA         L_main136
	NOP
	NOP
;SafeRoute_PreBeta.c,856 :: 		pinBT1 = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,857 :: 		isPickUp = 1;
	MOVLW       1
	MOVWF       _isPickUp+0 
;SafeRoute_PreBeta.c,859 :: 		}
	GOTO        L_main137
L_main135:
;SafeRoute_PreBeta.c,860 :: 		else if(!pinBT9 && !isPickUp){
	BTFSC       RC5_bit+0, BitPos(RC5_bit+0) 
	GOTO        L_main140
	MOVF        _isPickUp+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main140
L__main166:
;SafeRoute_PreBeta.c,864 :: 		pinBT1 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,865 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main141:
	DECFSZ      R13, 1, 1
	BRA         L_main141
	DECFSZ      R12, 1, 1
	BRA         L_main141
	DECFSZ      R11, 1, 1
	BRA         L_main141
	NOP
	NOP
;SafeRoute_PreBeta.c,866 :: 		pinBT1 = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,867 :: 		isPickUp = 1;
	MOVLW       1
	MOVWF       _isPickUp+0 
;SafeRoute_PreBeta.c,869 :: 		}
	GOTO        L_main142
L_main140:
;SafeRoute_PreBeta.c,870 :: 		else if(pinBT9 && isPickUp){
	BTFSS       RC5_bit+0, BitPos(RC5_bit+0) 
	GOTO        L_main145
	MOVF        _isPickUp+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main145
L__main165:
;SafeRoute_PreBeta.c,872 :: 		pinBT1 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,873 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main146:
	DECFSZ      R13, 1, 1
	BRA         L_main146
	DECFSZ      R12, 1, 1
	BRA         L_main146
	DECFSZ      R11, 1, 1
	BRA         L_main146
	NOP
	NOP
;SafeRoute_PreBeta.c,874 :: 		pinBT1 = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,875 :: 		isPickUp =0;
	CLRF        _isPickUp+0 
;SafeRoute_PreBeta.c,876 :: 		}
L_main145:
L_main142:
L_main137:
;SafeRoute_PreBeta.c,877 :: 		}
L_main132:
;SafeRoute_PreBeta.c,878 :: 		}
	GOTO        L_main147
L_main131:
;SafeRoute_PreBeta.c,879 :: 		else if(timePress > 6){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _timePress+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main229
	MOVF        _timePress+0, 0 
	SUBLW       6
L__main229:
	BTFSC       STATUS+0, 0 
	GOTO        L_main148
;SafeRoute_PreBeta.c,880 :: 		TurnOff();
	CALL        _TurnOff+0, 0
;SafeRoute_PreBeta.c,881 :: 		}
L_main148:
L_main147:
L_main130:
L_main124:
;SafeRoute_PreBeta.c,882 :: 		isPress = 0;
	CLRF        _isPress+0 
;SafeRoute_PreBeta.c,883 :: 		timePress = 0;
	CLRF        _timePress+0 
	CLRF        _timePress+1 
;SafeRoute_PreBeta.c,884 :: 		}
L_main119:
;SafeRoute_PreBeta.c,885 :: 		} //END isOn
	GOTO        L_main149
L_main90:
;SafeRoute_PreBeta.c,888 :: 		if(firstTime){
	MOVF        _firstTime+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main150
;SafeRoute_PreBeta.c,889 :: 		MPU6050_Init();
	CALL        _MPU6050_Init+0, 0
;SafeRoute_PreBeta.c,891 :: 		CalibrateMPU6050(100); //calibración del acelerometro
	MOVLW       100
	MOVWF       FARG_CalibrateMPU6050_samples+0 
	MOVLW       0
	MOVWF       FARG_CalibrateMPU6050_samples+1 
	CALL        _CalibrateMPU6050+0, 0
;SafeRoute_PreBeta.c,892 :: 		pinLedIndicator = 1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,893 :: 		pinBT1 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,894 :: 		delay_ms(4000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_main151:
	DECFSZ      R13, 1, 1
	BRA         L_main151
	DECFSZ      R12, 1, 1
	BRA         L_main151
	DECFSZ      R11, 1, 1
	BRA         L_main151
	NOP
;SafeRoute_PreBeta.c,895 :: 		pinBT1 = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SafeRoute_PreBeta.c,896 :: 		pinLedIndicator = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,897 :: 		firstTime=0;
	CLRF        _firstTime+0 
;SafeRoute_PreBeta.c,898 :: 		isOn = 1;
	MOVLW       1
	MOVWF       _isOn+0 
;SafeRoute_PreBeta.c,899 :: 		}
L_main150:
;SafeRoute_PreBeta.c,900 :: 		} //END else isOn
L_main149:
;SafeRoute_PreBeta.c,902 :: 		} //END WHILE
	GOTO        L_main88
;SafeRoute_PreBeta.c,903 :: 		} //END MAIN
L_end_main:
	GOTO        $+0
; end of _main

_int_EXT:

;SafeRoute_PreBeta.c,904 :: 		void int_EXT() iv 0x0008 ics ICS_AUTO  {//HIGH PRIORITY
;SafeRoute_PreBeta.c,905 :: 		GIE_bit = 0;
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;SafeRoute_PreBeta.c,908 :: 		if(!isOn){
	MOVF        _isOn+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_int_EXT153
;SafeRoute_PreBeta.c,909 :: 		TurnOn();
	CALL        _TurnOn+0, 0
;SafeRoute_PreBeta.c,911 :: 		pinLedIndicator = 1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;SafeRoute_PreBeta.c,912 :: 		}
	GOTO        L_int_EXT154
L_int_EXT153:
;SafeRoute_PreBeta.c,914 :: 		isPress = 1;
	MOVLW       1
	MOVWF       _isPress+0 
;SafeRoute_PreBeta.c,915 :: 		}
L_int_EXT154:
;SafeRoute_PreBeta.c,916 :: 		INT0IF_bit = 0;//Limpiamos la bandera
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;SafeRoute_PreBeta.c,918 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SafeRoute_PreBeta.c,919 :: 		}
L_end_int_EXT:
L__int_EXT231:
	RETFIE      1
; end of _int_EXT

_int_EXT2:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;SafeRoute_PreBeta.c,920 :: 		void int_EXT2() iv 0x0018 ics ICS_AUTO {//LOW  PRIORITY
;SafeRoute_PreBeta.c,922 :: 		if(millis > 100) //1 segundo
	MOVLW       0
	MOVWF       R0 
	MOVF        _millis+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int_EXT2234
	MOVF        _millis+0, 0 
	SUBLW       100
L__int_EXT2234:
	BTFSC       STATUS+0, 0 
	GOTO        L_int_EXT2155
;SafeRoute_PreBeta.c,925 :: 		secondsHeat++;
	INFSNZ      _secondsHeat+0, 1 
	INCF        _secondsHeat+1, 1 
;SafeRoute_PreBeta.c,926 :: 		if(isRest) secondsRest++;
	MOVF        _isRest+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int_EXT2156
	INFSNZ      _secondsRest+0, 1 
	INCF        _secondsRest+1, 1 
	GOTO        L_int_EXT2157
L_int_EXT2156:
;SafeRoute_PreBeta.c,927 :: 		else if(secondsHeat > 19) secondsReading++;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _secondsHeat+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int_EXT2235
	MOVF        _secondsHeat+0, 0 
	SUBLW       19
L__int_EXT2235:
	BTFSC       STATUS+0, 0 
	GOTO        L_int_EXT2158
	INFSNZ      _secondsReading+0, 1 
	INCF        _secondsReading+1, 1 
L_int_EXT2158:
L_int_EXT2157:
;SafeRoute_PreBeta.c,929 :: 		if(isPress) timePress++;
	MOVF        _isPress+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int_EXT2159
	INFSNZ      _timePress+0, 1 
	INCF        _timePress+1, 1 
L_int_EXT2159:
;SafeRoute_PreBeta.c,931 :: 		timeToSend++;
	INFSNZ      _timeToSend+0, 1 
	INCF        _timeToSend+1, 1 
;SafeRoute_PreBeta.c,932 :: 		millis = 0;
	CLRF        _millis+0 
	CLRF        _millis+1 
;SafeRoute_PreBeta.c,933 :: 		}
L_int_EXT2155:
;SafeRoute_PreBeta.c,934 :: 		if(millisFiveMS > 1){ //200ms
	MOVLW       0
	MOVWF       R0 
	MOVF        _millisFiveMS+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int_EXT2236
	MOVF        _millisFiveMS+0, 0 
	SUBLW       1
L__int_EXT2236:
	BTFSC       STATUS+0, 0 
	GOTO        L_int_EXT2160
;SafeRoute_PreBeta.c,935 :: 		if(!pinBT0){
	BTFSC       RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_int_EXT2161
;SafeRoute_PreBeta.c,936 :: 		isUntilZero++;
	INCF        _isUntilZero+0, 1 
;SafeRoute_PreBeta.c,937 :: 		}
	GOTO        L_int_EXT2162
L_int_EXT2161:
;SafeRoute_PreBeta.c,939 :: 		isUntilZero = 0;
	CLRF        _isUntilZero+0 
;SafeRoute_PreBeta.c,940 :: 		}
L_int_EXT2162:
;SafeRoute_PreBeta.c,941 :: 		millisFiveMS =0;
	CLRF        _millisFiveMS+0 
	CLRF        _millisFiveMS+1 
;SafeRoute_PreBeta.c,943 :: 		}
L_int_EXT2160:
;SafeRoute_PreBeta.c,944 :: 		millis++;// Interrupcion causa el incremento de millis
	INFSNZ      _millis+0, 1 
	INCF        _millis+1, 1 
;SafeRoute_PreBeta.c,945 :: 		millisFiveMS++;
	INFSNZ      _millisFiveMS+0, 1 
	INCF        _millisFiveMS+1, 1 
;SafeRoute_PreBeta.c,946 :: 		timeStamp++;//temporizador para calculo de caida lateral
	MOVLW       1
	ADDWF       _timeStamp+0, 1 
	MOVLW       0
	ADDWFC      _timeStamp+1, 1 
	ADDWFC      _timeStamp+2, 1 
	ADDWFC      _timeStamp+3, 1 
;SafeRoute_PreBeta.c,948 :: 		TMR1H         = 0x63;
	MOVLW       99
	MOVWF       TMR1H+0 
;SafeRoute_PreBeta.c,949 :: 		TMR1L         = 0xC0;
	MOVLW       192
	MOVWF       TMR1L+0 
;SafeRoute_PreBeta.c,950 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;SafeRoute_PreBeta.c,951 :: 		}
L_end_int_EXT2:
L__int_EXT2233:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _int_EXT2
