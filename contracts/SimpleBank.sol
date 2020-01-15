pragma solidity ^0.5.0;
contract SimpleBank { // got 0 passing from truffle test






    mapping (address => uint) internal balances;


    mapping (address => bool) public enrolled;


    address public owner;






    event LogEnrolled(address accountAddress);


    event LogDepositMade(address accountAdress, uint amount);




    event  LogWithdrawal(address accountAddress, uint withdrawalAmount, uint newBalance);





    constructor() public {

        owner = msg.sender;
    }






    function() external payable {
        revert();
    }






    function balance() public view returns (uint) {

        return balances[msg.sender];
    }











    function enroll() public returns (bool){
      enrolled[msg.sender] = true;
      emit LogEnrolled(msg.sender);
      return enrolled[msg.sender];


    }













    function deposit() public payable returns (uint) {  



          balances[msg.sender] += msg.value;

          emit LogDepositMade(msg.sender, msg.value);

          return balances[msg.sender];
      }














      



















function withdraw(uint withdrawAmount) public returns (uint) {





    require(withdrawAmount <= balances[msg.sender]);

    balances[msg.sender] -= withdrawAmount;
    msg.sender.transfer(withdrawAmount);
    return balances[msg.sender] += withdrawAmount;
     }

}