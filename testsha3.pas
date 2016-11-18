uses SHA3;

{ $Id: testsha3.pas,v 1.2 2016/11/18 15:20:03 ralph Exp $
  This is a small testprogramm for the SHA suite from https://github.com/ncs-sniper
  Written by Ralph Roth, ROSE SWE, http://rose.rult.at/

Test against /dev/zero to get the checksums of empty data:

File: /dev/zero
Keccak224        F71837502BA8E10837BDD8D365ADB85591895602FC552B48B7390ABD
Keccak256        C5D2460186F7233C927E7DB2DCC703C0E500B653CA82273B7BFAD8045D85A470
Keccak384        2C23146A63A29ACF99E73B88F8C24EAA7DC60AA771780CCC006AFBFA8FE2479B2DD2B21362337441AC12B515911957FF
Keccak512        0EAB42DE4C3CEB9235FC91ACFFE746B29C29A8C366B7C60E4E67C466F36A4304C00FA9CAF9D87976BA469BCBE06713B435F091EF2769FB160CDAB33D3670680E
Keccak_b         6753E3380C09E385D0339EB6B050A68F66CFD60A73476E6FD6ADEB72F5EDD7C6
SHA3_224         6B4E03423667DBB73B6E15454F0EB1ABD4597F9A1B078E3F5B5A6BC7
SHA3_256         A7FFC6F8BF1ED76651C14756A061D662F580FF4DE43B49FA82D80A4B80F8434A
SHA3_384         0C63A75B845E4F7D01107D852E4C2485C51A50AAAA94FC61995E71BBEE983A2AC3713831264ADB47FB6BD1E058D5F004
SHA3_512         A69F73CCA23A9AC5C8B567DC185A756E97C982164FE25859E0D1DCC1475C80A615B2123AF1F5F94C11E3E9402C3AC558F500199D95B6D3E301758586281DCD26
SHAKE128         7F9C2BA4E88F827D616045507605853ED73B8093F6EFBC88EB1A6EACFA66EF26
SHAKE256         46B9DD2B0BA88D13233B3FEB743EEB243FCD52EA62B81B82B50C27646ED5762F


}

{$DEFINE BARE_FPC}

var
    Hash        : TSHA3Hash;
    HashBits    : UInt32;
    i           : TSHA3HashSize;
    t           : Integer;
    szFile      : String;

begin

        if (ParamCount < 1) then
        begin
                writeln('usage: sha3 file(s)');
                writeln('prints various SHA3 hashes (Keccak) for the file(s) passed as command line argument');
                writeln('SHA3_256 = SHA3 commonly used');
                writeln('Keccak_b, SHAKE128 and SHAKE256 uses a variable hash length, we use here 256 bits');
                writeln;
                halt(1);
        end;

        HashBits := 256;

        for t := 1 to ParamCount do
        begin
                szFile := ParamStr(t);
                writeln('File: ', szFile);

                for i in TSHA3HashSize do
                begin
                    Hash := FileSHA3(i, szFile, HashBits);
                    writeln(i:15,'  ', SHA3ToStr(Hash));
                end;
                writeln;
        end;
end.
