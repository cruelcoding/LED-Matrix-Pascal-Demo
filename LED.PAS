Program LED;

Uses CRT, DOS;

Var MATRIX : Array [0..5] of Byte;

Procedure AllOff; Forward;

Procedure Init;

Const PORT1_CONTROL_REGISTER = $01B3;
      PORT2_CONTROL_REGISTER = $01B7;

Begin
     Randomize;
     Port[PORT1_CONTROL_REGISTER]:=$80;
     Port[PORT2_CONTROL_REGISTER]:=$80;
     AllOff;
End;

Procedure Update;

Const PORT_1A = $01B0;
      PORT_1B = $01B1;
      PORT_1C = $01B2;
      PORT_2A = $01B4;
      PORT_2B = $01B5;
      PORT_2C = $01B6;

Begin
     asm
        LEA DI, MATRIX

        XOR BX, BX
        MOV DX, PORT_1A
        MOV AL, [DI+BX]
        OUT DX, AL

        INC BX
        MOV DX, PORT_1B
        MOV AL, [DI+BX]
        OUT DX, AL

        INC BX
        MOV DX, PORT_1C
        MOV AL, [DI+BX]
        OUT DX, AL

        INC BX
        MOV DX, PORT_2A
        MOV AL, [DI+BX]
        OUT DX, AL

        INC BX
        MOV DX, PORT_2B
        MOV AL, [DI+BX]
        OUT DX, AL

        INC BX
        MOV DX, PORT_2C
        MOV AL, [DI+BX]
        OUT DX, AL
     end;

  {  Port[PORT_1A] := MATRIX[0];
     Port[PORT_1B] := MATRIX[1];
     Port[PORT_1C] := MATRIX[2];
     Port[PORT_2A] := MATRIX[3];
     Port[PORT_2B] := MATRIX[4];
     Port[PORT_2C] := MATRIX[5]; }
End;

Function BinaryStringToByte(Value : String) : Byte;

Var I : Integer;
    Result : Byte;

Begin
     Result:=0;
     For I:=Length(Value) DownTo 1
         Do
           If Value[I]='1'
              Then
                  Result:=Result+(1 shl (Length(Value)-I));
     BinaryStringToByte:=Result;
End;

Function GetCharByte(C : Char) : String;

Var Result : String;

Function Reverse(b : Byte) : Byte;

Var Result : Byte;

Begin
     Result:=((b and $F0) shr 4) or ((b and $0f) shl 4);
     Result:=((Result and $CC) shr 2) or ((Result and $33) shl 2);
     Result:=((Result and $AA) shr 1) or ((Result and $55) shl 1);
     Reverse:=Result;
End;

Begin
     Result:='';
     case C of
          ' ' : result:=Chr(Reverse($00))+Chr(Reverse($00))+Chr(Reverse($00))+Chr(Reverse($00))+Chr(Reverse($00));
          '0' : result:=Chr(Reverse($3E))+Chr(Reverse($51))+Chr(Reverse($49))+Chr(Reverse($45))+Chr(Reverse($3E));
          '1' : result:=Chr(Reverse($00))+Chr(Reverse($42))+Chr(Reverse($7F))+Chr(Reverse($40))+Chr(Reverse($00));
          '2' : result:=Chr(Reverse($42))+Chr(Reverse($61))+Chr(Reverse($51))+Chr(Reverse($49))+Chr(Reverse($46));
          '3' : result:=Chr(Reverse($21))+Chr(Reverse($41))+Chr(Reverse($45))+Chr(Reverse($4B))+Chr(Reverse($31));
          '4' : result:=Chr(Reverse($18))+Chr(Reverse($14))+Chr(Reverse($12))+Chr(Reverse($7F))+Chr(Reverse($10));
          '5' : result:=Chr(Reverse($27))+Chr(Reverse($45))+Chr(Reverse($45))+Chr(Reverse($45))+Chr(Reverse($39));
          '6' : result:=Chr(Reverse($3C))+Chr(Reverse($4A))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($30));
          '7' : result:=Chr(Reverse($01))+Chr(Reverse($71))+Chr(Reverse($09))+Chr(Reverse($05))+Chr(Reverse($03));
          '8' : result:=Chr(Reverse($36))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($36));
          '9' : result:=Chr(Reverse($06))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($29))+Chr(Reverse($1E));
          ',' : result:=Chr(Reverse($00))+Chr(Reverse($50 shl 1))+Chr(Reverse($30 shl 1))+Chr(Reverse($00))+Chr(Reverse($00));
          ':' : result:=Chr(Reverse($00))+Chr(Reverse($36))+Chr(Reverse($36))+Chr(Reverse($00))+Chr(Reverse($00));
          ';' : result:=Chr(Reverse($00))+Chr(Reverse($56))+Chr(Reverse($36))+Chr(Reverse($00))+Chr(Reverse($00));
          '/' : result:=Chr(Reverse($20))+Chr(Reverse($10))+Chr(Reverse($08))+Chr(Reverse($04))+Chr(Reverse($02));
          '!' : result:=Chr(Reverse($00))+Chr(Reverse($00))+Chr(Reverse($5F))+Chr(Reverse($00))+Chr(Reverse($00));
          '?' : result:=Chr(Reverse($02))+Chr(Reverse($01))+Chr(Reverse($51))+Chr(Reverse($09))+Chr(Reverse($06));
          '@' : result:=Chr(Reverse($32))+Chr(Reverse($49))+Chr(Reverse($79))+Chr(Reverse($41))+Chr(Reverse($3E));
          '_' : result:=Chr(Reverse($80))+Chr(Reverse($80))+Chr(Reverse($80))+Chr(Reverse($80))+Chr(Reverse($80));
          '-' : result:=Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($08));
          '.' : result:=Chr(Reverse($00))+Chr(Reverse($60))+Chr(Reverse($60))+Chr(Reverse($00))+Chr(Reverse($00));
          '+' : result:=Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($3E))+Chr(Reverse($08))+Chr(Reverse($08));
          '*' : result:=Chr(Reverse($08))+Chr(Reverse($2A))+Chr(Reverse($1C))+Chr(Reverse($2A))+Chr(Reverse($08));
          '<' : result:=Chr(Reverse($00))+Chr(Reverse($08))+Chr(Reverse($14))+Chr(Reverse($22))+Chr(Reverse($41));
          '=' : result:=Chr(Reverse($14))+Chr(Reverse($14))+Chr(Reverse($14))+Chr(Reverse($14))+Chr(Reverse($14));
          '>' : result:=Chr(Reverse($41))+Chr(Reverse($22))+Chr(Reverse($14))+Chr(Reverse($08))+Chr(Reverse($00));
          '[' : result:=Chr(Reverse($00))+Chr(Reverse($00))+Chr(Reverse($7F))+Chr(Reverse($41))+Chr(Reverse($41));
          ']' : result:=Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($7F))+Chr(Reverse($00))+Chr(Reverse($00));
          '\' : result:=Chr(Reverse($02))+Chr(Reverse($04))+Chr(Reverse($08))+Chr(Reverse($10))+Chr(Reverse($20));
          '%' : result:=Chr(Reverse($23))+Chr(Reverse($13))+Chr(Reverse($08))+Chr(Reverse($64))+Chr(Reverse($62));
          '|' : result:=Chr(Reverse($00))+Chr(Reverse($00))+Chr(Reverse($7F))+Chr(Reverse($00))+Chr(Reverse($00));
          ')' : result:=Chr(Reverse($00))+Chr(Reverse($41))+Chr(Reverse($22))+Chr(Reverse($1C))+Chr(Reverse($00));
          '(' : result:=Chr(Reverse($00))+Chr(Reverse($1C))+Chr(Reverse($22))+Chr(Reverse($41))+Chr(Reverse($00));
          '{' : result:=Chr(Reverse($00))+Chr(Reverse($08))+Chr(Reverse($36))+Chr(Reverse($41))+Chr(Reverse($00));
          '}' : result:=Chr(Reverse($00))+Chr(Reverse($41))+Chr(Reverse($36))+Chr(Reverse($08))+Chr(Reverse($00));
          '^' : result:=Chr(Reverse($04))+Chr(Reverse($02))+Chr(Reverse($01))+Chr(Reverse($02))+Chr(Reverse($04));
          '`' : result:=Chr(Reverse($00))+Chr(Reverse($01))+Chr(Reverse($02))+Chr(Reverse($04))+Chr(Reverse($00));
         '''' : result:=Chr(Reverse($00))+Chr(Reverse($05))+Chr(Reverse($03))+Chr(Reverse($00))+Chr(Reverse($00));
          '&' : result:=Chr(Reverse($36))+Chr(Reverse($49))+Chr(Reverse($55))+Chr(Reverse($22))+Chr(Reverse($50));
          '"' : result:=Chr(Reverse($00))+Chr(Reverse($07))+Chr(Reverse($00))+Chr(Reverse($07))+Chr(Reverse($00));
          '#' : result:=Chr(Reverse($14))+Chr(Reverse($7F))+Chr(Reverse($14))+Chr(Reverse($7F))+Chr(Reverse($14));
          '$' : result:=Chr(Reverse($24))+Chr(Reverse($2A))+Chr(Reverse($7F))+Chr(Reverse($2A))+Chr(Reverse($12));

          'a' : result:=Chr(Reverse($20))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($78));
          'b' : result:=Chr(Reverse($7F))+Chr(Reverse($48))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($38));
          'c' : result:=Chr(Reverse($38))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($00));
          'd' : result:=Chr(Reverse($38))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($48))+Chr(Reverse($7F));
          'e' : result:=Chr(Reverse($38))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($18));
          'f' : result:=Chr(Reverse($08))+Chr(Reverse($7E))+Chr(Reverse($09))+Chr(Reverse($01))+Chr(Reverse($02));
          'g' : result:=Chr(Reverse($08))+Chr(Reverse($14))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($3C));
          'h' : result:=Chr(Reverse($7F))+Chr(Reverse($08))+Chr(Reverse($04))+Chr(Reverse($04))+Chr(Reverse($78));
          'p' : result:=Chr(Reverse($7C))+Chr(Reverse($14))+Chr(Reverse($14))+Chr(Reverse($14))+Chr(Reverse($08));

          'A' : result:=Chr(Reverse($7E))+Chr(Reverse($11))+Chr(Reverse($11))+Chr(Reverse($11))+Chr(Reverse($7E));
          'B' : result:=Chr(Reverse($7F))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($36));
          'C' : result:=Chr(Reverse($3E))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($22));
          'D' : result:=Chr(Reverse($7F))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($22))+Chr(Reverse($1C));
          'E' : result:=Chr(Reverse($7F))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($41));
          'F' : result:=Chr(Reverse($7F))+Chr(Reverse($09))+Chr(Reverse($09))+Chr(Reverse($01))+Chr(Reverse($01));
          'G' : result:=Chr(Reverse($3E))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($51))+Chr(Reverse($32));
          'H' : result:=Chr(Reverse($7F))+Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($7F));
          'I' : result:=Chr(Reverse($00))+Chr(Reverse($41))+Chr(Reverse($7F))+Chr(Reverse($41))+Chr(Reverse($00));
          'J' : result:=Chr(Reverse($20))+Chr(Reverse($40))+Chr(Reverse($41))+Chr(Reverse($3F))+Chr(Reverse($01));
          'K' : result:=Chr(Reverse($7F))+Chr(Reverse($08))+Chr(Reverse($14))+Chr(Reverse($22))+Chr(Reverse($41));
          'L' : result:=Chr(Reverse($7F))+Chr(Reverse($40))+Chr(Reverse($40))+Chr(Reverse($40))+Chr(Reverse($40));
          'M' : result:=Chr(Reverse($7F))+Chr(Reverse($02))+Chr(Reverse($04))+Chr(Reverse($02))+Chr(Reverse($7F));
          'N' : result:=Chr(Reverse($7F))+Chr(Reverse($04))+Chr(Reverse($08))+Chr(Reverse($10))+Chr(Reverse($7F));
          'O' : result:=Chr(Reverse($3E))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($3E));
          'P' : result:=Chr(Reverse($7F))+Chr(Reverse($09))+Chr(Reverse($09))+Chr(Reverse($09))+Chr(Reverse($06));
          'Q' : result:=Chr(Reverse($3E))+Chr(Reverse($41))+Chr(Reverse($51))+Chr(Reverse($21))+Chr(Reverse($5E));
          'R' : result:=Chr(Reverse($7F))+Chr(Reverse($09))+Chr(Reverse($19))+Chr(Reverse($29))+Chr(Reverse($46));
          'S' : result:=Chr(Reverse($26))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($32));
          'T' : result:=Chr(Reverse($01))+Chr(Reverse($01))+Chr(Reverse($7F))+Chr(Reverse($01))+Chr(Reverse($01));
          'U' : result:=Chr(Reverse($3F))+Chr(Reverse($40))+Chr(Reverse($40))+Chr(Reverse($40))+Chr(Reverse($3F));
          'V' : result:=Chr(Reverse($1F))+Chr(Reverse($20))+Chr(Reverse($40))+Chr(Reverse($20))+Chr(Reverse($1F));
          'W' : result:=Chr(Reverse($7F))+Chr(Reverse($20))+Chr(Reverse($18))+Chr(Reverse($20))+Chr(Reverse($7F));
          'X' : result:=Chr(Reverse($63))+Chr(Reverse($14))+Chr(Reverse($08))+Chr(Reverse($14))+Chr(Reverse($63));
          'Y' : result:=Chr(Reverse($03))+Chr(Reverse($04))+Chr(Reverse($78))+Chr(Reverse($04))+Chr(Reverse($03));
          'Z' : result:=Chr(Reverse($61))+Chr(Reverse($51))+Chr(Reverse($49))+Chr(Reverse($45))+Chr(Reverse($43));

          'а' : result:=Chr(Reverse($20))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($78));
          'б' : result:=Chr(Reverse($3C))+Chr(Reverse($4A))+Chr(Reverse($4A))+Chr(Reverse($49))+Chr(Reverse($31));
          'в' : result:=Chr(Reverse($7C))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($28))+Chr(Reverse($00));
          'г' : result:=Chr(Reverse($7C))+Chr(Reverse($04))+Chr(Reverse($04))+Chr(Reverse($04))+Chr(Reverse($0C));
          'д' : result:=Chr(Reverse($E0))+Chr(Reverse($54))+Chr(Reverse($4C))+Chr(Reverse($44))+Chr(Reverse($FC));
          'е' : result:=Chr(Reverse($38))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($18));
          'ж' : result:=Chr(Reverse($6C))+Chr(Reverse($10))+Chr(Reverse($7C))+Chr(Reverse($10))+Chr(Reverse($6C));
          'и' : result:=Chr(Reverse($7C))+Chr(Reverse($20))+Chr(Reverse($10))+Chr(Reverse($08))+Chr(Reverse($7C));
          'й' : result:=Chr(Reverse($7C))+Chr(Reverse($41))+Chr(Reverse($22))+Chr(Reverse($11))+Chr(Reverse($7C));
          'к' : result:=Chr(Reverse($7C))+Chr(Reverse($10))+Chr(Reverse($28))+Chr(Reverse($44))+Chr(Reverse($00));
          'л' : result:=Chr(Reverse($20))+Chr(Reverse($44))+Chr(Reverse($3C))+Chr(Reverse($04))+Chr(Reverse($7C));
          'м' : result:=Chr(Reverse($7C))+Chr(Reverse($08))+Chr(Reverse($10))+Chr(Reverse($08))+Chr(Reverse($7C));
          'н' : result:=Chr(Reverse($7C))+Chr(Reverse($10))+Chr(Reverse($10))+Chr(Reverse($10))+Chr(Reverse($7C));
          'о' : result:=Chr(Reverse($38))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($38));
          'п' : result:=Chr(Reverse($7C))+Chr(Reverse($04))+Chr(Reverse($04))+Chr(Reverse($04))+Chr(Reverse($7C));
          'с' : result:=Chr(Reverse($38))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($44))+Chr(Reverse($00));
          'т' : result:=Chr(Reverse($04))+Chr(Reverse($04))+Chr(Reverse($7C))+Chr(Reverse($04))+Chr(Reverse($04));
          'у' : result:=Chr(Reverse($0C))+Chr(Reverse($50))+Chr(Reverse($50))+Chr(Reverse($50))+Chr(Reverse($3C));
          'ф' : result:=Chr(Reverse($30))+Chr(Reverse($48))+Chr(Reverse($FC))+Chr(Reverse($48))+Chr(Reverse($30));
          'ч' : result:=Chr(Reverse($0C))+Chr(Reverse($10))+Chr(Reverse($10))+Chr(Reverse($10))+Chr(Reverse($7C));
          'ь' : result:=Chr(Reverse($7C))+Chr(Reverse($50))+Chr(Reverse($50))+Chr(Reverse($20))+Chr(Reverse($00));
          'э' : result:=Chr(Reverse($28))+Chr(Reverse($44))+Chr(Reverse($54))+Chr(Reverse($54))+Chr(Reverse($38));
          'ю' : result:=Chr(Reverse($7C))+Chr(Reverse($10))+Chr(Reverse($38))+Chr(Reverse($44))+Chr(Reverse($38));
          'я' : result:=Chr(Reverse($08))+Chr(Reverse($54))+Chr(Reverse($34))+Chr(Reverse($14))+Chr(Reverse($7C));

          'В' : result:=Chr(Reverse($7F))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($49))+Chr(Reverse($36));
          'Д' : result:=Chr(Reverse($E0))+Chr(Reverse($51))+Chr(Reverse($4F))+Chr(Reverse($41))+Chr(Reverse($FF));
          'Ж' : result:=Chr(Reverse($77))+Chr(Reverse($08))+Chr(Reverse($7F))+Chr(Reverse($08))+Chr(Reverse($77));
          'Й' : result:=Chr(Reverse($7C))+Chr(Reverse($21))+Chr(Reverse($12))+Chr(Reverse($09))+Chr(Reverse($7C));
          'Н' : result:=Chr(Reverse($7F))+Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($08))+Chr(Reverse($7F));
          'П' : result:=Chr(Reverse($7F))+Chr(Reverse($01))+Chr(Reverse($01))+Chr(Reverse($01))+Chr(Reverse($7F));
          'С' : result:=Chr(Reverse($3E))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($41))+Chr(Reverse($22));
          'Х' : result:=Chr(Reverse($63))+Chr(Reverse($14))+Chr(Reverse($08))+Chr(Reverse($14))+Chr(Reverse($63));
          'Ш' : result:=Chr(Reverse($7F))+Chr(Reverse($40))+Chr(Reverse($7F))+Chr(Reverse($40))+Chr(Reverse($7F));
          'Щ' : result:=Chr(Reverse($7F))+Chr(Reverse($40))+Chr(Reverse($7F))+Chr(Reverse($40))+Chr(Reverse($FF));
     End;
     result:=result+Chr(0);
     GetCharByte:=Result;
End;

Procedure ScrollString(TextToScroll : String; DelayValue : Integer);

Var I,DataSize : Integer;
    S : String;
    SCROLL_DATA : Array [0..2999] Of Byte;

Begin
     S:='';
     DataSize:=Length(TextToScroll) * 6;
     For I:=1 To Length(TextToScroll)
         Do
           S:=S+GetCharByte(TextToScroll[I]);
     For I:=1 To Length(S)
         Do
           SCROLL_DATA[I-1]:=ord(S[I]);

     For I:=0 To DataSize-1+5
         Do
           Begin
                MATRIX[0]:=MATRIX[1];
                MATRIX[1]:=MATRIX[2];
                MATRIX[2]:=MATRIX[3];
                MATRIX[3]:=MATRIX[4];
                MATRIX[4]:=MATRIX[5];
                if I>DataSize-1
                   Then
                       MATRIX[5]:=0
                   Else
                       MATRIX[5]:=SCROLL_DATA[I];
                Update;
                Delay(DelayValue);
           End;
End;

Procedure AllOn;

Begin
     MATRIX[0]:=$FF;
     MATRIX[1]:=$FF;
     MATRIX[2]:=$FF;
     MATRIX[3]:=$FF;
     MATRIX[4]:=$FF;
     MATRIX[5]:=$FF;
     Update;
End;

Procedure AllOff;

Begin
     MATRIX[0]:=0;
     MATRIX[1]:=0;
     MATRIX[2]:=0;
     MATRIX[3]:=0;
     MATRIX[4]:=0;
     MATRIX[5]:=0;
     Update;
End;

Procedure VLineOn(I : Integer);

Begin
     MATRIX[I]:=255;
     Update;
End;

Procedure VLineOff(I : Integer);

Begin
     MATRIX[I]:=0;
     Update;
End;

Procedure HLineOn(I : Integer);

Var J : Integer;

Begin
     For J:=0 To 5
         Do
           MATRIX[J]:=MATRIX[J] or (1 shl I);
     Update;
End;

Procedure HLineOff(I : Integer);

Var J : Integer;

Begin
     For J:=0 To 5
         Do
           MATRIX[J]:=MATRIX[J] and not(1 shl I);
     Update;
End;

Procedure PixelOn(X,Y : Integer);

Begin
     MATRIX[X]:=MATRIX[X] or (1 shl Y);
     Update;
End;

Procedure PixelOff(X,Y : Integer);

Begin
     MATRIX[X]:=MATRIX[X] and not(1 shl Y);
     Update;
End;

Procedure PixelOnAbs(I : Integer);

Begin
     PixelOn(I DIV 8,I MOD 8);
End;

Procedure PixelOffAbs(I : Integer);

Begin
     PixelOff(I DIV 8,I MOD 8);
End;

Procedure HAL2000(N, DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To N
         Do
           Begin
                MATRIX[0]:=Random($FF+1);
                MATRIX[1]:=Random($FF+1);
                MATRIX[2]:=Random($FF+1);
                MATRIX[3]:=Random($FF+1);
                MATRIX[4]:=Random($FF+1);
                MATRIX[5]:=Random($FF+1);
                Update;
                Delay(DelayValue);
     End;
     AllOff;
End;

Procedure ShowChar(Ch : Char);

Var S : String;

Begin
     S:=GetCharByte(Ch);
     MATRIX[0]:=Ord(S[1]);
     MATRIX[1]:=Ord(S[2]);
     MATRIX[2]:=Ord(S[3]);
     MATRIX[3]:=Ord(S[4]);
     MATRIX[4]:=Ord(S[5]);
     MATRIX[5]:=Ord(S[6]);
     Update;
End;

Function Shuffle : String; Forward;

Procedure RevealChar(Ch : Char; DelayValue : Integer);

Var S,Random : String;
    I,J,K : Integer;
    CharMatrix : Array[0..5] Of Byte;

Begin
     AllOn;
     S:=GetCharByte(Ch);
     CharMatrix[0]:=Ord(S[1]);
     CharMatrix[1]:=Ord(S[2]);
     CharMatrix[2]:=Ord(S[3]);
     CharMatrix[3]:=Ord(S[4]);
     CharMatrix[4]:=Ord(S[5]);
     CharMatrix[5]:=Ord(S[6]);
     Random:=Shuffle;
     For I:=1 To 48
         Do
           Begin
                J:=Ord(Random[I]) Div 8;
                K:=Ord(Random[I]) Mod 8;
                If (CharMatrix[J] And (1 shl K))=0
                   Then
                       Begin
                            PixelOffAbs(Ord(Random[I]));
                            Delay(DelayValue);
                       End;
           End;
End;

Procedure RevealString(S : String; DelayPixel, DelayChar : Integer);

Var I : Integer;

Begin
     For I:=1 To Length(S)
         Do
           Begin
                RevealChar(S[I], DelayPixel);
                Delay(DelayChar);
           End;
     AllOff;
End;

Procedure ShowString(S : String; DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To Length(S)
         Do
           Begin
                ShowChar(S[I]);
                Delay(DelayValue);
                AllOff;
                Delay(DelayValue DIV 2);
           End;
End;

Procedure BouncingHLine(N,DelayValue : Integer);

Var I,K : Integer;

Begin
     For K:=1 To N
         Do
           Begin
                For I:=0 To 7
                    Do
                      Begin
                           HLineOn(I);
                           Delay(DelayValue * 5);
                           HLineOff(I);
                           Delay(DelayValue);
                      End;
                For I:=6 DownTo 1
                    Do
                      Begin
                           HLineOn(I);
                           Delay(DelayValue* 5);
                           HLineOff(I);
                           Delay(DelayValue);
                      End;
           End;
     AllOff;
End;

Procedure BouncingVLine(N,DelayValue : Integer);

Var I,K : Integer;

Begin
     For K:=1 To N
         Do
           Begin
                For I:=0 To 5
                    Do
                      Begin
                           VLineOn(I);
                           Delay(DelayValue * 5);
                           VLineOff(I);
                           Delay(DelayValue);
                      End;
                For I:=4 DownTo 1
                    Do
                      Begin
                           VLineOn(I);
                           Delay(DelayValue * 5);
                           VLineOff(I);
                           Delay(DelayValue);
                      End;
           End;
     AllOff;
End;

Function Shuffle : String;

Var I, Rand : Integer;
    S : String;
    A : Array[0..47] Of Byte;
    Temp : Byte;

Begin
     For I:=0 To 47
         Do
           A[I]:=I;
     For I:=0 To 47
         Do
           Begin
                Rand:=Random(48 - I) + I;
                Temp:=A[Rand];
                A[Rand]:=A[I];
                A[I]:=Temp;
           End;
     S:='';
     For I:=0 To 47
         Do
           S:=S+Chr(A[I]);
     Shuffle:=S;
End;

Procedure Random_IN_OUT(N,DelayValue : Integer);

Var I,K : Integer;
    S : String;

Begin
     For K:=1 To N
         Do
           Begin
                S:=Shuffle;
                For I:=1 To 48
                    Do
                      Begin
                           PixelOnAbs(Ord(S[I]));
                           Delay(DelayValue);
                      End;
                S:=Shuffle;
                For I:=1 To 48
                    Do
                      Begin
                           PixelOffAbs(Ord(S[I]));
                           Delay(DelayValue);
                      End;
           End;
End;

Procedure VerticalInterlacing(N,DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To N
         Do
           Begin
                VLineOn(0);
                VLineOn(2);
                VLineOn(4);
                VLineOff(1);
                VLineOff(3);
                VLineOff(5);
                Delay(DelayValue);
                VLineOff(0);
                VLineOff(2);
                VLineOff(4);
                VLineOn(1);
                VLineOn(3);
                VLineOn(5);
                Delay(DelayValue);
           End;
     AllOff;
End;

Procedure HorizontalInterlacing(N,DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To N
         Do
           Begin
                HLineOn(0);
                HLineOn(2);
                HLineOn(4);
                HLineOn(6);
                HLineOff(1);
                HLineOff(3);
                HLineOff(5);
                HLineOff(7);
                Delay(DelayValue);
                HLineOff(0);
                HLineOff(2);
                HLineOff(4);
                HLineOff(6);
                HLineOn(1);
                HLineOn(3);
                HLineOn(5);
                HLineOn(7);
                Delay(DelayValue);
           End;
     AllOff;
End;

Procedure VSnake(On : Boolean; DelayValue : Integer);

Var X,Y,I : Integer;

Begin
     For X:=0 To 5
         Do
           Begin
                If Odd(X)
                   Then
                       Y:=7
                   Else
                       Y:=0;
                For I:=0 To 7
                    Do
                      Begin
                           If On
                              Then
                                  PixelOn(X,Y)
                              Else
                                  PixelOff(X,Y);
                           Delay(DelayValue);
                           If Odd(X)
                              Then
                                  Y:=Y-1
                              Else
                                  Y:=Y+1;
                      End;
           End;
End;

Procedure HSnake(On : Boolean; DelayValue : Integer);

Var X,Y,I : Integer;

Begin
     For Y:=0 To 7
         Do
           Begin
                If Odd(Y)
                   Then
                       X:=5
                   Else
                       X:=0;
                For I:=0 To 5
                    Do
                      Begin
                           If On
                              Then
                                  PixelOn(X,Y)
                              Else
                                  PixelOff(X,Y);
                           Delay(DelayValue);
                           If Odd(Y)
                              Then
                                  X:=X-1
                              Else
                                  X:=X+1;
                      End;
           End;
End;

Procedure Flash(N,DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To N
         Do
           Begin
                AllOn;
                Delay(DelayValue);
                AllOff;
                Delay(DelayValue);
           End;
End;

Procedure PoliceLights(N, DelayValue : Integer);

Var I,K : Integer;

Begin
     For K:=1 To N
         Do
           Begin
                For I:=0 To 4
                    Do
                      Begin
                           MATRIX[0]:=$0F;
                           MATRIX[1]:=$0F;
                           MATRIX[2]:=$0F;
                           MATRIX[3]:=$0F SHL 4;
                           MATRIX[4]:=$0F SHL 4;
                           MATRIX[5]:=$0F SHL 4;
                           Update;
                           Delay(DelayValue);
                           AllOff;
                           Delay(DelayValue);
                      End;
                For I:=0 To 4
                    Do
                      Begin
                           MATRIX[3]:=$0F;
                           MATRIX[4]:=$0F;
                           MATRIX[5]:=$0F;
                           MATRIX[0]:=$0F SHL 4;
                           MATRIX[1]:=$0F SHL 4;
                           MATRIX[2]:=$0F SHL 4;
                           Update;
                           Delay(DelayValue);
                           AllOff;
                           Delay(DelayValue);
                      End;
           End;
     AllOff;
End;

Procedure Snake(N, DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To N
         Do
           Begin
                VSnake(True,DelayValue);
                VSnake(False,DelayValue);
                HSnake(True,DelayValue);
                HSnake(False,DelayValue);
           End;
End;

Procedure Space(N,DelayValue : Integer);

Var I : Integer;

Begin
     For I:=1 To N
         Do
           Begin
                MATRIX[2]:=BinaryStringToByte('00011000');
                MATRIX[3]:=BinaryStringToByte('00011000');
                Update;
                Delay(DelayValue);
                AllOff;
                MATRIX[2]:=BinaryStringToByte('00111100');
                MATRIX[3]:=BinaryStringToByte('00111100');
                Update;
                Delay(DelayValue);
                AllOff;
                MATRIX[1]:=BinaryStringToByte('00011000');
                MATRIX[2]:=BinaryStringToByte('00011000');
                MATRIX[3]:=BinaryStringToByte('00011000');
                MATRIX[4]:=BinaryStringToByte('00011000');
                Update;
                Delay(DelayValue);
                AllOff;
                MATRIX[1]:=BinaryStringToByte('01111110');
                MATRIX[2]:=BinaryStringToByte('01000010');
                MATRIX[3]:=BinaryStringToByte('01000010');
                MATRIX[4]:=BinaryStringToByte('01111110');
                Update;
                Delay(DelayValue);
                AllOff;
                MATRIX[0]:=BinaryStringToByte('11111111');
                MATRIX[1]:=BinaryStringToByte('10000001');
                MATRIX[2]:=BinaryStringToByte('10000001');
                MATRIX[3]:=BinaryStringToByte('10000001');
                MATRIX[4]:=BinaryStringToByte('10000001');
                MATRIX[5]:=BinaryStringToByte('11111111');
                Update;
                Delay(DelayValue);
                AllOff;
           End;
End;

Function IntToStr(I : Integer) : String;

Var temp : String;

Begin
     Str(I,temp);
     IntToStr:=temp;
End;

Function GetTimeString : String;

Var h,m,s,hund : Word;
    hs,ms : String;

Begin
     GetTime(h,m,s,hund);
     hs:=IntToStr(h);
     if Length(hs)=1
        Then
            hs:='0'+hs;
     ms:=IntToStr(m);
     if Length(ms)=1
        Then
            ms:='0'+ms;
     GetTimeString:='Вpемя: '+hs+':'+ms;
End;

Function GetDateString : String;

Var y,m,d,dow : Word;

Function GetDayOfWeek(D : Integer) : String;

Begin
     Case D Of
           0 : GetDayOfWeek:='воскpесенье';
           1 : GetDayOfWeek:='понедельник';
           2 : GetDayOfWeek:='втоpник';
           3 : GetDayOfWeek:='сpеда';
           4 : GetDayOfWeek:='четвеpг';
           5 : GetDayOfWeek:='пятница';
           6 : GetDayOfWeek:='суббота';
     End;
End;

Function GetMonth(M : Integer) : String;

Begin
     Case M Of
           1 : GetMonth:='янваpя';
           2 : GetMonth:='февpаля';
           3 : GetMonth:='маpта';
           4 : GetMonth:='апpеля';
           5 : GetMonth:='мая';
           6 : GetMonth:='июня';
           7 : GetMonth:='июля';
           8 : GetMonth:='августа';
           9 : GetMonth:='сентябpя';
          10 : GetMonth:='октябpя';
          11 : GetMonth:='ноябpя';
          12 : GetMonth:='декабpя';
     End;
End;

Begin
     GetDate(y,m,d,dow);
     GetDateString:='Сегодня '+GetDayOfWeek(dow)+', '+IntToStr(d)+' '+GetMonth(m)+' '+IntToStr(y)+' года.';
End;

Procedure ChessBoard(N,DelayValue : Integer);

Var I,J : Integer;
    Value1, Value2 : Byte;

Begin
     Value1:=BinaryStringToByte('10101010');
     Value2:=BinaryStringToByte('01010101');
     For I:=1 To N
         Do
           Begin
                For J:=0 To 5
                    Do
                      Begin
                           If odd(J)
                              Then
                                  MATRIX[J]:=Value1
                              Else
                                  MATRIX[J]:=Value2;
                      End;
                Update;
                Delay(DelayValue);
                For J:=0 To 5
                    Do
                      Begin
                           If odd(J)
                              Then
                                  MATRIX[J]:=Value2
                              Else
                                  MATRIX[J]:=Value1;
                      End;
                Update;
                Delay(DelayValue);
           End;
     AllOff;
End;

Begin
     Init;
     ChessBoard(6,100);
     ScrollString('Пpивет,Хабp!', 70);
     Snake(2,12);
     ScrollString(GetDateString, 70);
     PoliceLights(4,80);
     ScrollString(GetTimeString, 70);
     Space(8,100);
     Flash(10,70);
     BouncingHLine(3,10);
     BouncingVLine(3,10);
     VerticalInterlacing(10,150);
     HorizontalInterlacing(10,150);
     Random_IN_OUT(5,7);
     HAL2000(50,50);
     ShowString('На этом-все!',300);
     RevealString('Спасибо!',15,300);
End.