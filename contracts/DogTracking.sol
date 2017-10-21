pragma solidity ^0.4.13;

import "./Owned.sol";

contract DogTracking is Owned {

    //map dog  => owner
    mapping(address => address) public dogToOwner;
    mapping(address => int) public dogCoordLong;
    mapping(address => int) public dogCoordLat;

    event NewDogRegistered(
        address indexed dogOwner,
        address indexed dogTag);

    modifier dogTagExists() {
        require(dogToOwner[msg.sender] != 0);
        _;
    }

    function registerNewDog(address dogOwner, address dogTag)
      public
      fromOwner
      returns (bool success)
    {
       require(dogOwner != 0);
       require(dogTag != 0);
       //dog was not registered before
       require(dogToOwner[dogTag] == 0);
       dogToOwner[dogTag] = dogOwner;
       NewDogRegistered(dogOwner, dogTag);
       return true;
    }

    function saveDogLocation(int lat, int long)
       public
       dogTagExists
       returns (bool success)
    {
        dogCoordLat[msg.sender] = lat;
        dogCoordLong[msg.sender] = long;

        return true;
    }

    function getDogLocation(address dogTag)
      public
      returns (int lat, int long)
    {
        require(dogTag != 0);
        require(dogToOwner[dogTag] != 0);
        require(dogToOwner[dogTag] == msg.sender);
        return (dogCoordLat[dogTag], dogCoordLong[dogTag]);
    }

}
