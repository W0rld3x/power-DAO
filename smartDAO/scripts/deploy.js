const hre = require("hardhat");


async function main() {

  const Dao = await hre.ethers.getContractFactory("Dao");
  const daodeploy = await Dao.deploy();

  await daodeploy.deployed();

  console.log("Dao deployed to:", daodeploy.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
