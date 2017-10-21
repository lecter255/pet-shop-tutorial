pragma solidity ^0.4.13;

contract Owned {

    address public owner;

    event LogOwnerSet(address indexed previousOwner, address indexed newOwner);

    modifier fromOwner {
        require(msg.sender == owner);
        _;
    }

    function Owned() {
        owner = msg.sender;
    }


    /**
     * Sets the new owner for this contract.
     *   - only the current owner can call this function
     *   - only a new address can be accepted
     *   - only a non-0 address can be accepted
     * @param newOwner The new owner of the contract
     * @return Whether the action was successful.
     * Emits LogOwnerSet.
     */
    function setOwner(address newOwner)
       public
       fromOwner
       returns (bool success)
    {
        require(newOwner != 0);
        address prevOwner = owner;
        owner = newOwner;
        LogOwnerSet(owner, prevOwner);
        return true;
    }

    /**
     * @return The owner of this contract.
     */
    function getOwner()
      public
      constant
      returns (address ownerAddress)
    {
        return owner;
    }

}
