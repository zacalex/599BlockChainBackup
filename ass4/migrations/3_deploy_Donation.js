var DonateForEarn = artifacts.require("./DonateForEarn.sol");

module.exports = function(deployer) {
  deployer.deploy(DonateForEarn,"0x627306090abaB3A6e1400e9345bC60c78a8BEf57");
//   deployer.link(DonateForEarn);
};
