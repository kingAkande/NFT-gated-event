// SPDX-License-Identifier: M
pragma solidity ^0.8.24;

import "./IErc721.sol";

contract NftEvent {

    address public owner;
    uint256 public eventCount;
    IERC721 public nftContract; // ERC-721 contract address to verify NFT ownership

    constructor(address _nftContractAddress) {
        owner = msg.sender;
        nftContract = IERC721(_nftContractAddress);
    }

    struct Event {
        uint256 id;
        string name;
        string description;
        string eventDate;
        bool isOngoing;
        address[] registeredUsers; // List of registered attendees
    }

    // Mapping of event ID to Event details
    mapping (uint256 => Event) public events;

    // Mapping to keep track of which users registered for which events
    mapping(address => mapping(uint256 => bool)) public isRegistered;

    // Create a new event (only for NFT holders)
    function createEvent(
        string memory _name,
        string memory _description,
        string memory _eventDate,
        bool _isOngoing
    ) external {
        require(nftContract.balanceOf(msg.sender) > 0, "Not an NFT holder"); // Ensure the caller holds an NFT
        
        eventCount++;
    
       

        events[eventCount] = Event({
            id: eventCount,
            name: _name,
            description: _description,
            eventDate: _eventDate,
            isOngoing: _isOngoing,
            registeredUsers:  // Initialize with empty list
            
        });
    }

    // Register as an attendee for a specific event (only for NFT holders)
    function registerAttendees(uint256 _eventId) external {
        require(nftContract.balanceOf(msg.sender) > 0, "Not an NFT holder"); // Ensure the caller holds an NFT
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        require(!isRegistered[msg.sender][_eventId], "Already registered");

        // Register the user for the event
        events[_eventId].registeredUsers.push(msg.sender);
        isRegistered[msg.sender][_eventId] = true;
    }

    // View registered users for an event
    function getRegisteredUsers(uint256 _eventId) external view returns (address[] memory) {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        return events[_eventId].registeredUsers;
    }
}
