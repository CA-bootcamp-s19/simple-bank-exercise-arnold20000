pragma solidity ^0.5.0;

contract TestSimpleBank { // Real Original. Done and Ready to submit. Running Truffle test in truffle/supply-chain/test

     //
     // State variables
     //

     uint withdrawAmount;
     uint newBalance;

     /* Fill in the keyword. Hint: We want to protect our users balance from other contracts*/
     //Me: Private functions/ Variables can only be used internally and not even by derived contracts.
     
     mapping (address => uint) private balances;

     

     /* Fill in the keyword. We want to create a getter function and allow contracts to be able to see if a user is enrolled.  */
     //Me: Public functions/ Variables can be used both externally and internally. For public state variable, Solidity automatically creates a getter function.
     mapping (address => bool) public enrolled;

     
     /* Let's make sure everyone knows who owns the bank. Use the appropriate keyword for this*/
     //Me: Public functions/ Variables can be used both externally and internally. For public state variable, 
     //Solidity automatically creates a getter function.
     address public owner;

     //
     // Events - publicize actions to external listeners
     //

     /* Add an argument for this event, an accountAddress */
     event LogEnrolled(address accountAddress);

     /* Add 2 arguments for this event, an accountAddress and an amount */
     event LogDepositMade(address accountAddress, uint amount);
     
 /* Create an event called LogWithdrawal */
     /* Add 3 arguments for this event, an accountAddress, withdrawAmount and a newBalance */
     event  LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);



     //
     // Functions
     //

     /* Use the appropriate global variable to get the sender of the transaction */
     constructor() public {
         /* Set the owner to the creator of this contract */

         owner = msg.sender;
     }

     // Fallback function - Called if other functions don't match call or
     // sent ether without data
     // Typically, called when invalid data is sent
     // Added so ether sent to this contract is reverted if the contract fails
     // otherwise, the sender's money is transferred to contract





     function() external payable {
         revert();
     }

     /// @notice Get balance
     /// @return The balance of the user
     // A SPECIAL KEYWORD prevents function from editing state variables;
     // allows function to run locally/off blockchain

       function testgetBalance() public returns (uint) {
        /* Get the balance of the sender of this transaction */
         return balances[msg.sender];

         //function balance() public view returns (uint) {
     }

     /// @notice Enroll a customer with the bank
     /// @return The users enrolled status
     // Emit the appropriate event


     function testenroll() public returns (bool){
     
       enrolled[msg.sender] = true;
       emit LogEnrolled(msg.sender);
       return enrolled[msg.sender] == true;
     }

     /// @notice Deposit ether into bank
     /// @return The balance of the user after the deposit is made
     // Add the appropriate keyword so that this function can receive ether
     // Use the appropriate global variables to get the transaction sender and value
     // Emit the appropriate event    
     // Users should be enrolled before they can make deposits
//START

       //modifier verifyEnroll() { require (enrolled[msg.sender] == true); _;}
       
       modifier verifyEnroll { require (enrolled[msg.sender] == true); _;}

     function testdeposit() payable public verifyEnroll() returns (uint) {
         /* Add the amount to the user's balance, call the event associated with a deposit,
           then return the balance of the user */
            balances[msg.sender] += msg.value;
            emit LogDepositMade(msg.sender, msg.value);
            return balances[msg.sender] + msg.value;

     }
     modifier verifyBalance  {require(balances[msg.sender] >= msg.value); _;}

     /// @notice withdraw ether from bank
     /// @dev This does not return any excess ether sent to it
     /// @param //withdrawAmount amount you want to withdraw
     /// @return The balance remaining for the user
     // Emit the appropriate event

           // modifier verifyBalance /*()*/ {require(balances[msg.sender] >= msg.value); _;}
           
           

     function testwithdraw() payable public verifyBalance() returns (uint) {
             withdrawAmount = msg.value;
             newBalance = balances[msg.sender] - msg.value; //withdrawAmount;
             
             //newBalance = balances[msg.sender] - withdrawAmount;
             //balances[msg.sender] = 0;
             msg.sender.transfer(newBalance);
             
             emit LogWithdrawal(msg.sender, withdrawAmount, newBalance);
             
             return newBalance; 
             

         /* If the sender's balance is at least the amount they want to withdraw,
            Subtract the amount from the sender's balance, and try to send that amount of ether
            to the user attempting to withdraw. 
            return the user's balance.*/
     }

 }
 
 

