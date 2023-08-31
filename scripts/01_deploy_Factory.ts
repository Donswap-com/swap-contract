import { ethers } from 'hardhat'
import config from '../../../config'

async function main() {
  // eslint-disable-next-line no-unused-vars
  const [owner] = await ethers.getSigners()

  const Factory = await ethers.getContractFactory('DONSwapFactory')
  const factory: any = await Factory.deploy(owner.address)
  await factory.deployed()

  await factory.setFeeTo(config.EXCHANGE_FEES)

  console.log('Factory address:', factory.address)
  // Modify DONSwapLibrary.sol to add the following hash
  console.log('Factory INIT_CODE_PAIR_HASH', await factory.INIT_CODE_PAIR_HASH())
}

main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
