pragma solidity >=0.4.25 <0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract TicketingSystem is ERC721, Ownable {
    uint256 private nextTicketId;

    struct Ticket {
        string eventName;
        uint256 eventDate;
        uint256 eventTime;
        uint256 seatNumber;
    }

    mapping(uint256 => Ticket) public tickets;

    constructor() ERC721("TicketingSystem", "TS") {
        nextTicketId = 1;
    }

    // TODO
    // only allow event organizers to mint the ticket
    function mintTicket(
        address to,
        string memory eventName,
        uint256 eventDate,
        uint256 eventTime,
        uint256 seatNumber
    ) public onlyOwner {
        Ticket memory newTicket = Ticket(eventName, eventDate, eventTime, seatNumber);
        tickets[nextTicketId] = newTicket;
        _mint(to, nextTicketId);
        nextTicketId++;
    }

    function buyTicket(uint256 ticketId) public payable {
        require(msg.value >= getTicketPrice(ticketId), "Insufficient funds");
        address currentOwner = ownerOf(ticketId);
        _transfer(currentOwner, msg.sender, ticketId);
        payable(currentOwner).transfer(msg.value);
    }

    function getTicketPrice(uint256 ticketId) public pure returns (uint256) {
        // TODO
        // Replace this function with a more sophisticated pricing mechanism if desired
        return 0.1 ether;
    }

    function verifyTicketOwnership(uint256 ticketId, address claimant) public view returns (bool) {
        return ownerOf(ticketId) == claimant;
    }
}
