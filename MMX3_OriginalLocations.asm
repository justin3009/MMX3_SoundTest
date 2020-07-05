;==================================================================================
; Mega Man X3 (Base Mod Project)
; By xJustin3009x (Shishisenkou) (Justin3009)
;==================================================================================
; This file is used to import the code changes that separate all characters from one
; another so they can have individual stats instead of group stats.
;==================================================================================
; NOTE: The ROM MUST be expanded to 4MB first WITHOUT a header!
;==================================================================================
;*********************************************************************************
;Blank data
;*********************************************************************************
;B9:C1BC - $B9:FFFF
;***************************
;***************************
; ROM Addresses
;***************************
;***************************
header : lorom

;***************************
;***************************
; Incorporates Sound Test into the menu
;***************************
;Everything in here will involve the Options Menu and adding in the Sound Test.
{
	org $80EA2C ;Original code location that finishes drawing the menu.
	{
	JSR OptionsMenu_Text_DrawNumbers ;Loads new location to draw the Sound Test numbers upon Options Menu load.
	}
	org $80FD44 ;New code that draws the Sound Test numbers upon Options Menu load.
	{
	OptionsMenu_Text_DrawNumbers:
	JSR OptionsMenu_BGMTest_Numbers
	JSR OptionsMenu_SoundTest_Numbers
	JSR $861F
	RTS
	}

	org $80EA73 ;Original code location that sets how many commands there are.
	{
		CMP #$0A
	}
	org $80EA6B ;Original code location that sets last command to load when on "Shot" and press UP
	{
		LDA #$09 ;Sets to load exit
	}
	org $80EAD1 ;Original code location that sets pointers to each Options Menu command
	{
		JMP ($FD30,x)
		
	org $80FD30 ;New offset location that holds pointers to the menus commands.
		dw $EAE4 ;Shot
		dw $EAE4 ;Jump
		dw $EAE4 ;Dash
		dw $EAE4 ;Select_L
		dw $EAE4 ;Select_R
		dw $EAE4 ;Menu
		dw $EB77 ;Stereo/Mono
		dw OptionsMenu_BGMTest
		dw OptionsMenu_SoundTest
		dw $EBBF ;Exit
	}
	
	org $80EA87 ;Original code location that determines whether "Key Config" or "Sound Mode" box will be highlighted.
	{
		JSR OptionsMenu_BoxHighlighting
	}
	org $868DD4 ;Original offset location that has pointers to the "Sound Mode" box when not selected and selected.
	{
		dw OptionsMenu_SoundMode_NoSelect_Top
		dw OptionsMenu_SoundMode_NoSelect_Middle
		dw OptionsMenu_SoundMode_NoSelect_Bottom
		
		dw OptionsMenu_SoundMode_Select_Top
		dw OptionsMenu_SoundMode_Select_Middle
		dw OptionsMenu_SoundMode_Select_Bottom
		
		
		org $8692C3 ;This will blank out the entirety of the original "Sound Mode" box
			padbyte $FF
			pad $869384


		org $8692C3 ;Original offset location to draw the non selected "Sound Mode" box.
		{
			;This section draws the "Sound Mode" box when it's not highlighted
			{
				OptionsMenu_SoundMode_NoSelect_Top:
				db $06,$24,$45,$0A,$AB,$AC,$AC,$AC,$AC,$AA,$0A,$38,$4B,$0A,$53,$4F
				db $55,$4E,$44,$20,$4D,$4F,$44,$45,$06,$64,$55,$0A,$AA,$AC,$AC,$AC
				db $AC,$AB
				db $00


				OptionsMenu_SoundMode_NoSelect_Middle:
				db $01,$24,$65,$0A,$AD
				db $01,$64,$7A,$0A,$AD
				db $01,$24,$85,$0A,$AD
				db $01,$64,$9A,$0A,$AD
				db $01,$24,$A5,$0A,$AD
				db $01,$64,$BA,$0A,$AD
				db $01,$24,$C5,$0A,$AD
				db $01,$64,$DA,$0A,$AD
				db $01,$24,$E5,$0A,$AD
				db $01,$64,$FA,$0A,$AD
				db $00
				
				
				OptionsMenu_SoundMode_NoSelect_Bottom:
				db $15 ;How many pieces to draw
				db $A4 ;Palette
				dw $0B05 ;X/Y coordinates
				db $AB,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC
				db $AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC
				
				db $01 ;How many pieces to draw
				db $E4 ;Palette
				dw $0B1A ;X/Y coordinates
				db $AB ;Bottom right corner tile
				db $00 ;End
			}
			org $86FE00 ;This section draws the "Sound Mode" box when it's highlighted
			{
				OptionsMenu_SoundMode_Select_Top:
				db $06,$2C,$45,$0A,$AB,$AC,$AC,$AC,$AC,$AA,$0A,$34,$4B,$0A,$53,$4F
				db $55,$4E,$44,$20,$4D,$4F,$44,$45,$06,$6C,$55,$0A,$AA,$AC,$AC,$AC
				db $AC,$AB
				db $00


				OptionsMenu_SoundMode_Select_Middle:
				db $01,$2C,$65,$0A,$AD
				db $01,$6C,$7A,$0A,$AD
				db $01,$2C,$85,$0A,$AD
				db $01,$6C,$9A,$0A,$AD
				db $01,$2C,$A5,$0A,$AD
				db $01,$6C,$BA,$0A,$AD
				db $01,$2C,$C5,$0A,$AD
				db $01,$6C,$DA,$0A,$AD
				db $01,$2C,$E5,$0A,$AD
				db $01,$6C,$FA,$0A,$AD
				db $00
				
				
				OptionsMenu_SoundMode_Select_Bottom:
				db $15 ;How many pieces to draw
				db $AC ;Palette
				dw $0B05 ;X/Y coordinates
				db $AB,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC
				db $AC,$AC,$AC,$AC,$AC,$AC,$AC,$AC
				
				db $01 ;How many pieces to draw
				db $EC ;Palette
				dw $0B1A ;X/Y coordinates
				db $AB ;Bottom right corner tile
				db $00 ;End
			}
		}
	}
	org $869413 ;Original offset location that draws "Stereo" "Monaural" "Stereo" "Monaural" depending if they're selected or not.
	{
	db $08 ;How many letters to draw
	db $20 ;Palette
	dw $0A8C ;X/Y coordinates
	db $20,$53,$54,$45,$52,$45,$4F,$20 ;Stereo text
	db $00 ;End byte
	
	db $08 ;How many letters to draw
	db $28 ;Palette
	dw $0A8C ;X/Y coordinates
	db $20,$53,$54,$45,$52,$45,$4F,$20 ;Stereo text
	db $00 ;End byte
	
	db $08 ;How many letters to draw
	db $20 ;Palette
	dw $0A8C ;X/Y coordinates
	db $4D,$4F,$4E,$41,$55,$52,$41,$4C ;Monaural text
	db $00 ;End byte
	
	db $08 ;How many letters to draw
	db $28 ;Palette
	dw $0A8C ;X/Y coordinates
	db $4D,$4F,$4E,$41,$55,$52,$41,$4C ;Monaural text
	db $00 ;End byte
	}
	org $868DC0 ;Original offset location that draws unused Object Debug text. [Now points to "S.E." text]
	{
	dw OptionsMenu_SEText_Select
	
	org $868EBA ;Original offset location that draws the unused "COMING SOON" text. [Now draws S.E. text non-selected and selected]
	db $04 ;How many letters to draw
	db $20 ;Palette
	dw $0ACC ;X/Y coordinates
	db $53,$2E,$45,$2E ;S.E. text
	db $00 ;End byte
	
	OptionsMenu_SEText_Select:
	db $04 ;How many letters to draw ;
	db $28 ;Palette
	dw $0ACC ;X/Y coordinates
	db $53,$2E,$45,$2E ;S.E. text
	db $00 ;End byte
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FF,$FF
	}
	org $868DA8 ;Original offset location for pointers to unused numbers for 01234567 (Pointers #$07 and #$08)
	{
	dw OptionsMenu_BGMText_Noselect
	dw OptionsMenu_BGMText_Select
	
	org $869343 ;New offset location for drawing BGM text highlighted and non highlighted
	{
		OptionsMenu_BGMText_Noselect:
		db $03 ;How many letters to draw
		db $20 ;Palette
		dw $0AAC ;X/Y coordinates
		db $42,$47,$4D ;BGM text
		db $00 ;End byte
		
		OptionsMenu_BGMText_Select:
		db $03 ;How many letters to draw
		db $28 ;Palette
		dw $0AAC ;X/Y coordinates
		db $42,$47,$4D ;BGM text
		db $00 ;End byte
	}
	}
	
	org $80E9D7 ;Original code location that draws commands to screen when first entering the Options Menu.
	{
		LDX #$09
		PHX
		LDA.w OptionsMenu_NoHighlightOptions,x
	}
	org $80EA8F ;Original code location that dehighlights commands when moving from one to another on the Options Menu.
	{
		LDA.w OptionsMenu_NoHighlightOptions,x
	}
	org $80EAAC ;Original code location that highlights commands as you're selecting them on the Options Menu.
	{
		LDA.w OptionsMenu_HighlightOptions,x
		;INC
		NOP
		CPX #$06 ;Checks if you're highlighting "Stereo". If so, alter the highlighting of it manually instead of using a table.
	}

	org $86FFD0 ;Original offset location that was blank. [Now used for non-hightlighted commands]
	{
		OptionsMenu_NoHighlightOptions:
		db $23 ;Shot
		db $25 ;Jump
		db $27 ;Dash
		db $29 ;Select_L
		db $2B ;Select_R
		db $2D ;Menu
		db $2F ;Stereo/Mono (Uses "Exit" instead since this is dynamically done)
		db $07 ;BGM
		db $03 ;S.E.
		db $2F ;Exit

		OptionsMenu_HighlightOptions:
		db $24 ;Shot
		db $26 ;Jump
		db $28 ;Dash
		db $2A ;Select_L
		db $2C ;Select_R
		db $2E ;Menu
		db $30 ;Stereo/Mono (Uses "Exit" instead since this is dynamically done)
		db $08 ;BGM
		db $13 ;S.E.
		db $30 ;Exit
	}
	
	org $80FD50 ;New code location for code in bank $80
	{
		OptionsMenu_SoundTest: ;This section houses the entire "S.E." command
		{
		LDA $AD ;Loads $7E:00AD (Arrow button presses)
		BIT #$03 ;Checks for Left/Right being pressed
		BEQ OptionsMenu_SoundTest_NoIncrease ;If neither, don't increase SFX value.
		
			BIT #$02 ;Checks for "Left" arrow
			BEQ OptionsMenu_SoundTest_IncreaseSFX ;If not being pressed, increase SFX.
			
				LDA $7EFFC9 ;Loads $7E:FFC9 (SFX counter)
				DEC A ;Decrease
				CMP #$FF ;Checks if it rolled back to #$FF
				BNE OptionsMenu_SoundTest_StoreSFX ;If not, store SFX value
				
				LDA #$5C ;If so, set this to last SFX available
				BRA OptionsMenu_SoundTest_StoreSFX

			OptionsMenu_SoundTest_IncreaseSFX:
			LDA $7EFFC9 ;Loads $7E:FFC9 (SFX counter)
			INC A ;Increase
			CMP #$5D ;Checks for #$5D (Above last SFX value)
			BCC OptionsMenu_SoundTest_StoreSFX ;If >= #$5D, set new value below
			
				LDA #$00 ;First SFX to start with
			
			OptionsMenu_SoundTest_StoreSFX:
			STA $7EFFC9 ;Store to $7E:FFC9 (SFX counter)
			
		OptionsMenu_SoundTest_NoIncrease:
		LDA $7EFF86 ;Loads $7E:FF86 (Delay before new SFX can be played)
		BNE OptionsMenu_SoundTest_DrawNumbers
		
			LDA $AD ;Loads $7E:00AD (Button press)
			AND #$40 ;Checks for "Y" button
			BNE OptionsMenu_SoundTest_BlankSound
			
			LDA $AC ;Loads $7E:00AC (Button press)
			AND #$80 ;Checks for "A" button
			BEQ OptionsMenu_SoundTest_DrawNumbers
			
			OptionsMenu_SoundTest_BlankSound:
			LDA #$F1
			JSL $81802B
			JSR $8162
			
			LDA $7EFFC9 ;Loads $7E:FFC9 (SFX counter)
			BEQ OptionsMenu_SoundTest_PlayFirstSound
			BRA OptionsMenu_SoundTest_PlaySound

				OptionsMenu_SoundTest_PlayFirstSound:
				LDA #$01 ;Plays 'Lemon' buster sound
			
			OptionsMenu_SoundTest_PlaySound:
			JSL $81802B
			
			LDA #$02 ;Delay before you can play another sound
			STA $7EFF86
		
		OptionsMenu_SoundTest_DrawNumbers:
		JSR OptionsMenu_SoundTest_Numbers ;Loads function to draw S.E. "xx" values
		JSR $8162
		JMP $EA2F
		}
		OptionsMenu_BGMTest: ;This section houses the entire "BGM" command
		{
			LDA $AD ;Loads $7E:00AD (Arrow button presses)
			BIT #$03 ;Checks for Left/Right being pressed
			BEQ OptionsMenu_BGMTest_NoIncrease
			
				BIT #$02
				BEQ OptionsMenu_BGMTest_IncreaseBGM
				
					LDA $7EFFC8
					DEC A
					CMP #$FF
					BNE OptionsMenu_BGMTest_StoreBGM
					
					LDA #$21 ;Last BGM track to play
					BRA OptionsMenu_BGMTest_StoreBGM
					
				OptionsMenu_BGMTest_IncreaseBGM:
				LDA $7EFFC8
				INC A
				CMP #$22
				BCC OptionsMenu_BGMTest_StoreBGM
				
					LDA #$00 ;First BGM track to play
				
				OptionsMenu_BGMTest_StoreBGM:
				STA $7EFFC8
			
			OptionsMenu_BGMTest_NoIncrease:
			LDA $AD ;Loads $7E:00AD (Button press
			AND #$40 ;Checks for "Y" button
			BNE OptionsMenu_BGMTest_PlayBGM
			
			LDA $AC ;Loads $7E:00AC (Button pres
			AND #$80 ;Checks for "A" button
			BEQ OptionsMenu_BGMTest_UpdateNumbers
			
				OptionsMenu_BGMTest_PlayBGM:
				LDA $7EFFC8
				BEQ OptionsMenu_BGMTest_PlayFirstTrack
				BRA OptionsMenu_BGMTest_PlayTrack
				
					OptionsMenu_BGMTest_PlayFirstTrack:
					LDA #$01
				
				OptionsMenu_BGMTest_PlayTrack:
				CLC
				ADC #$10
				JSL $8084BC
			
			OptionsMenu_BGMTest_UpdateNumbers:
			JSR OptionsMenu_BGMTest_Numbers
			JSR $8162
			JMP $EA2F
		}
		;This section determines whether the "Key Config" or "Sound Mode" box will be highlighted.
		{
		OptionsMenu_BoxHighlighting:
			LDA $7EFF80
			CMP #$00             
			BEQ OptionsMenu_KeyConfig_Select
			CMP #$05             
			BEQ OptionsMenu_KeyConfig_Select
			CMP #$06             
			BEQ OptionsMenu_SoundMode_Select
			CMP #$07             
			BEQ OptionsMenu_SoundMode_Select
			CMP #$08             
			BEQ OptionsMenu_SoundMode_Select
			CMP #$09             
			BEQ OptionsMenu_Exit_Select
			RTS            
			
			OptionsMenu_KeyConfig_Select:
			LDA #$1A
			JSR $ED2F
			LDA #$1D
			JMP $ED2F
			
			OptionsMenu_SoundMode_Select:
			LDA #$17
			JSR $ED2F
			LDA #$20
			JMP $ED2F
			
			OptionsMenu_Exit_Select:
			LDA #$17
			JSR $ED2F
			LDA #$1D
			JMP $ED2F
		}	

		;This section draws the number display for BGM "xx"
		{
		OptionsMenu_BGMTest_Numbers:
		LDX $A5
		LDA #$80 ;???
		STA $0600,x
		LDA #$04 ;???
		STA $0603,x
		
		REP #$20
		LDA #$0AB2 ;X/Y coordinates
		STA $0601,x
		
		SEP #$20
		LDA $7EFFC8
		LSR A
		LSR A
		LSR A
		LSR A
		TAY
		
		LDA $FFF0,y ;Tile graphic to write (1st tile)
		STA $0604,x
		
		LDA $7EFFC8
		AND #$0F
		TAY
		LDA $FFF0,y ;Tile graphic to write (2nd tile)
		STA $0606,x
		
		LDA #$20 ;Palette
		STA $0605,x
		STA $0607,x
		
		LDA $A5
		CLC
		ADC #$08
		STA $A5
		RTS

		}
		;This section draws the number display for S.E. "xx"
		{
		OptionsMenu_SoundTest_Numbers:
		LDX $A5
		LDA #$80 ;???
		STA $0600,x
		LDA #$04 ;???
		STA $0603,x
		
		REP #$20
		LDA #$0AD2 ;X/Y coordinates
		STA $0601,x
		
		SEP #$20
		LDA $7EFFC9
		LSR A
		LSR A
		LSR A
		LSR A
		TAY
		
		LDA $FFF0,y ;Tile graphic to write (1st tile)
		STA $0604,x
		
		LDA $7EFFC9
		AND #$0F
		TAY
		LDA $FFF0,y ;Tile graphic to write (2nd tile)
		STA $0606,x
		
		LDA #$20 ;Palette
		STA $0605,x
		STA $0607,x
		
		LDA $A5
		CLC
		ADC #$08
		STA $A5
		RTS
		
	org $86FFF0 ;Tiles for numbers
	{
		db $30 ;0
		db $31 ;1
		db $32 ;2
		db $33 ;3
		db $34 ;4
		db $35 ;5
		db $36 ;6
		db $37 ;7
		db $38 ;8
		db $39 ;9
		
		db $41 ;A
		db $42 ;B
		db $43 ;C
		db $44 ;D
		db $45 ;E
		db $46 ;F
	}
		}
	
	}

}
