types of account 
    * EOA : externally owned accounts -> they have a private key 
    * contract account -> have smart contract code, has no private key. 

since contract account no private key, they cannot initiate a transaction 

contract runs -> transaction destination is a contract address, causes contract to run in the EVM using the transaction and transaction data as input 

no contract can initiate a transaction , only EOA can (how do escrows work then?)

in solidity , you dont access stuff using 

simply put 

