types of account 
    * EOA : externally owned accounts -> they have a private key 
    * contract account -> have smart contract code, has no private key. 

since contract account no private key, they cannot initiate a transaction 

contract runs -> transaction destination is a contract address, causes contract to run in the EVM using the transaction and transaction data as input 

no contract can initiate a transaction , only EOA can (how do escrows work then?)

in solidity , you dont access stuff using 

for every valid unicode, we have ranges of bytes 
for UTF-8 , we have 8 bits, so that means only 256 charecters , 
not quite 

Why it matters: Almost every modern script, punctuation mark, currency sign, emoji precursor, etc., lives here, so one 16-bit value is enough to encode most characters. 
otherwise we have surrogate pairs, for utf16 , usually not required as much 

if anything goes beyond the 16 bit limit, we use 20 bit values which after subtracting are 