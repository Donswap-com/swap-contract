import { ethers } from 'hardhat'
import config from '../../../config'

async function main() {
  const Router = await ethers.getContractFactory('DONSwapRouter')
  const router: any = await Router.deploy(config.EXCHANGE_FACTORY, config.WBNB)
  await router.deployed()

  console.log('Router address:', router.address)
}

main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
