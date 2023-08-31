import { ethers } from 'hardhat'

async function main() {
  const fakeToken = await ethers.getContractFactory('fakeToken')
  const fake: any = await fakeToken.deploy('fakeToken', 'FTOKEN', ethers.utils.parseEther('100000000'))
  await fake.deployed()

  console.log('Router address:', fake.address)
}

main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
