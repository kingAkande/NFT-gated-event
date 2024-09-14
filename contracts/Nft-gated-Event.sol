// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "./IErc721.sol" ;

contract NftEvent {

    address owner;
    uint256 eventCount;
    address tokenAddress;

    constructor(address _tokenAddress){

        owner = msg.sender;
        tokenAddress = _tokenAddress;
    }

    struct Event {

    uint256 id;     
    string name;
    string description;
    string eventDate;
    bool isOngoing;
    address[] registeredUsers;

}

 
    mapping(address => bool) hasNFT;

    mapping (uint256 => Event) events;
    mapping(address => mapping(uint256 => bool)) hasRegistered;

    function createEvent(string memory _name , string memory _description , string memory _eventDate ) external {

    uint256 _eventID = eventCount + 1;  /* unique ID to look up event */
    
    Event storage evT = events[_eventID];
    evT.id = _eventID;
    evT.name = _name;
    evT.description = _description;
    evT.eventDate =_eventDate;
    evT.registeredUsers.push(msg.sender);
    hasRegistered[msg.sender][_eventID] = true;

    eventCount +=1 ;

    }

 function registerAttendees(uint256 _eventID) external {

    require (IERC721(tokenAddress).balanceOf(msg.sender) > 0 , "not an nft holder");
    require(_eventID != 0 , "not in existence");
    require(_eventID <= eventCount , "not in existence");
    require( !hasRegistered[msg.sender][_eventID] , "Already registered");
    events[_eventID].registeredUsers.push(msg.sender);
    hasRegistered[msg.sender][_eventID] = true;

 }


 function getAregisteredUsers(uint256 _eventID) external view returns (address[] memory){

        require( _eventID >0  && _eventID <= eventCount,"invalid" );


        return events[_eventID].registeredUsers;
 }
    


}


