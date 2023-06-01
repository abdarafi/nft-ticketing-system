const TicketingSystem = artifacts.require("TicketingSystem");

module.exports = function(deployer) {
  deployer.deploy(TicketingSystem);
};