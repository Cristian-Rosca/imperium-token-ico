const ImperiumICO = artifacts.require("ImperiumICO");

module.exports = function (deployer) {
  deployer.deploy(ImperiumICO, "0xB9F415afD3ee1ee5300170631929b91AF5998CA8");
};
