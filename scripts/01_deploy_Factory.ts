import { keccak256 } from '@ethersproject/solidity'
import { ethers } from 'hardhat'
import { bytecode } from '../artifacts/contracts/DONSwapPair.sol/DONSwapPair.json'

async function main() {
  // eslint-disable-next-line no-unused-vars
  const [owner] = await ethers.getSigners()

  const Factory = await ethers.getContractFactory('DONSwapFactory')
  const factory: any = await Factory.deploy(owner.address)
  await factory.deployed()

  await factory.setFeeTo('0x5dC3967ACc048b3644F86158DC164bF7303e6D55')

  console.log('Factory address:', factory.address)

  // get init code hash
  const initCodeHash = keccak256(['bytes'], [bytecode])
  console.log('Factory INIT_CODE_PAIR_HASH', initCodeHash)
  // Modify DONSwapLibrary.sol to add the following hash
  // console.log('Factory INIT_CODE_PAIR_HASH', await factory.INIT_CODE_PAIR_HASH())
}

main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
