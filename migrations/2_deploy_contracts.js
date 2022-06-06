let ERC20TokenGenerator = artifacts.require("./ERC20TokenGenerator.sol");
let ERC20Token = artifacts.require("./ERC20Token.sol");

module.exports = async function (deployer) {
  await deployer.deploy(ERC20TokenGenerator);
  await deployer.deploy(ERC20Token);
};
