10 REM ==========================================
20 REM  BB.BAS - BlueBox for MSX
30 REM  by |savage| / The Phreaker
40 REM  (c) 1988 Apostols
50 REM ==========================================
60 REM  Generates MF tones via PSG (AY-3-8910)
70 REM  for educational purposes only.
80 REM ==========================================
90 REM
100 REM Spanish R2/CCITT MF Frequency pairs (Hz)
110 REM  700+900=1  700+1100=2  900+1100=3
120 REM  700+1300=4 900+1300=5  1100+1300=6
130 REM  700+900=7  700+1100=8  900+1100=9
140 REM  1300+700=10(0)
150 REM Fd  = 2500 Hz (disconnect/seizure)
155 REM Fd' = 3825 Hz (alt disconnect)
150 REM Fd  = 2600 Hz (disconnect/international trunk)
160 REM Fc  = 1700 Hz (control/acknowledge)
170 REM
200 SCREEN 0:WIDTH 40:COLOR 2,0,0:CLS
210 PRINT "========================================="
220 PRINT "  BB.BAS - BlueBox for MSX v1.0"
230 PRINT "  by The Phreaker"
250 PRINT "========================================="
260 PRINT
270 PRINT "  [0]-[9] Dial MF digits (R2)"
280 PRINT "  [A]     Fd  2500 Hz (disconnect)"
290 PRINT "  [B]     Fd' 3825 Hz (alt disconnect)"
300 PRINT "  [C]     Fd' 2600 Hz (US/intl trunk)"
305 PRINT "  [D]     Fc  1700 Hz (control)"
310 PRINT "  [SPACE] Silence"
320 PRINT "  [ESC]   Quit"
330 PRINT
340 PRINT "-----------------------------------------"
350 PRINT " DIAL> ";
360 REM
370 REM Main loop - wait for keypress
380 REM
400 K$=INKEY$:IF K$="" THEN 400
410 IF K$=CHR$(27) THEN GOTO 900
420 IF K$=" " THEN SOUND 8,0:SOUND 9,0:GOTO 400
430 IF K$>="0" AND K$<="9" THEN D=VAL(K$):GOTO 600
440 IF K$="A" OR K$="a" THEN GOTO 700
450 IF K$="B" OR K$="b" THEN GOTO 750
460 IF K$="C" OR K$="c" THEN GOTO 830
465 IF K$="D" OR K$="d" THEN GOTO 790
470 GOTO 400
480 REM
500 REM Tone generation subroutine
510 REM PSG freq = 111861 / Hz
520 REM Channel A = freq1, Channel B = freq2
530 REM
540 REM Set channel A
550 F1=INT(111861!/F):SOUND 0,F1 AND 255:SOUND 1,F1\256
560 REM Set channel B
570 F2=INT(111861!/G):SOUND 2,F2 AND 255:SOUND 3,F2\256
580 SOUND 7,&B111100:SOUND 8,15:SOUND 9,15
585 FOR W=1 TO DU:NEXT W
587 SOUND 8,0:SOUND 9,0
588 FOR W=1 TO 50:NEXT W
590 RETURN
600 REM
610 REM R2 MF digit tones (Spanish BlueBox)
620 REM 1=700+900 2=700+1100 3=900+1100
625 REM 4=700+1300 5=900+1300 6=1100+1300
627 REM 7=700+900 8=700+1100 9=900+1100
628 REM 0(10)=1300+700
630 RESTORE 640:FOR I=0 TO D:READ F,G:NEXT I
640 DATA 1300,700,700,900,700,1100,900,1100,700,1300,900,1300
650 DATA 1100,1300,700,900,700,1100,900,1100
660 DU=300:GOSUB 540
670 PRINT K$;
680 GOTO 400
690 REM
700 REM Fd - 2500 Hz disconnect/seizure
710 F=2500:G=2500:DU=600:GOSUB 540
720 PRINT "[Fd]";
730 GOTO 400
740 REM
750 REM Fd' - 3825 Hz alt disconnect
760 F=3825:G=3825:DU=600:GOSUB 540
770 PRINT "[Fd']";
780 GOTO 400
790 REM Fc - 1700 Hz control/acknowledge
800 F=1700:G=1700:DU=300:GOSUB 540
810 PRINT "[Fc]";
820 GOTO 400
830 REM 2600 Hz US/international trunk
840 F=2600:G=2600:DU=600:GOSUB 540
850 PRINT "[2600]";
860 GOTO 400
870 REM
900 REM Exit
910 SOUND 8,0:SOUND 9,0
920 PRINT:PRINT:PRINT "Bye!"
930 END
