// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  const TiketEvent = await hre.ethers.getContractFactory("tiketEvent");
  const tiketEvent = await TiketEvent.attach("0x1FbD34f4F61c578f4f700021895f8E2bE339e698");

  // Metamask public key 
  // Token uri = metadata URL
  await tiketEvent.mintNFT("0x5F8F81C73C34269aBF936333Fc2C9872aba18bCD", "https://gateway.pinata.cloud/ipfs/QmasWxpjKd18rLdPTZdbTC4Np8oQVb5Fu9CzoTk4AALHCg");

  console.log(
    ` deployed to ${tiketEvent.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});