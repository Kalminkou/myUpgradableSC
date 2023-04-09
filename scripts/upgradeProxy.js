const { ethers, upgrades } = require('hardhat')

const proxyAdr = '0x3FCc417B151931FeF75841cf8794Fa86d0770545'
async function main() {
    const VendingMachineV2 = await ethers.getContractFactory('VendingMachineV2')
    const upgraded = await upgrades.upgradeProxy(proxyAdr, VendingMachineV2)

    const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxyAdr)
    console.log("The current contract owner is: " + upgraded.owner());
    console.log("Implementation contract address: : " + implementationAddress )
}

main()