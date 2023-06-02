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
        uint256 price;
    }

    mapping(uint256 => Ticket) public tickets;

    constructor() ERC721("TicketingSystem", "TS") {
        nextTicketId = 1;
    }

    // TODO
    // now only the address that deployed the contract can mint tickets
    // consider using AccessControl if we want to allow multiple specific address
    function mintTicket(
        address to,
        string memory eventName,
        uint256 eventDate,
        uint256 eventTime,
        uint256 seatNumber,
        uint256 price // unit is in wei; 0.1 ETH: 100000000000000000 weis
    ) public onlyOwner {
        Ticket memory newTicket = Ticket(eventName, eventDate, eventTime, seatNumber, price);
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

    function getTicketPrice(uint256 ticketId) public view returns (uint256) {
        return tickets[ticketId].price;
    }

    function verifyTicketOwnership(uint256 ticketId, address claimant) public view returns (bool) {
        return ownerOf(ticketId) == claimant;
    }
}
