uses SHA3;

{ $Id: testsha3.pas,v 1.1 2016/11/17 20:06:40 ralph Exp $
  This is a small testprogramm for the SHA suite from https://github.com/ncs-sniper
  Written by Ralph Roth, ROSE SWE, http://rose.rult.at/

Currently it seems that the implementation of Keccak_b and SHAKE128/SHALE256 is missing:

File: testsha3.pas
Keccak224        B12112CF84B86F9926A073241C01CF00BC34644D35DC26F3F1E87E8F
Keccak256        E7FA0CFDA8F9114C6146B457679D79EECB66C6971E5AE4790763535B32081FDC
Keccak384        AEFFAB662B6F669C4AE8AAEB453DD56CF89D1199632E5A56665FB02A3193C1BC85515F5F3FC2EF3869E432B30F90818B
Keccak512        CFDE438C603E6211420B1B974CF2678868480418A94BD037FFD1F560949AFF348DC6B5C8DF937CDCFA0AE7F9949A2D550E9131C309CC406F0A544AF49ADC911D
Keccak_b         
SHA3_224         F64170421098674D11DB8CDDF7BF86408E7AB118E132438CECD02D59
SHA3_256         9EAA47BFA48545DDA3A2D6F8F3A244F946F6E22103B82A152BF7D6CC06896C71
SHA3_384         24A7B6A52C65AFF7D349B67241B6A36EF11F6376861087D620AA6DDCBB6944B6C870141EFDCEB4482FF155590411329A
SHA3_512         86B2ADD92A3780765FDB0C4779F7D680147345E3D621DB54E82C60C9A6CD51C091301ADB900FA94B6B2E014A7F4ECC4F22D68373E1A031987F7CAF68BA038B57
SHAKE128         
SHAKE256         

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
                writeln;
                halt(1);
        end;

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
