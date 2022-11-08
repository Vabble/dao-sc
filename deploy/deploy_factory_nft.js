module.exports = async function ({ ethers, getNamedAccounts, deployments, getChainId }) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const { CONFIG, NETWORK } = require('../scripts/utils');
  
  this.StakingPool = await deployments.get('StakingPool');
  this.UniHelper = await deployments.get('UniHelper');
  this.Property = await deployments.get('Property');
  this.Ownablee = await deployments.get('Ownablee');

  await deploy('FactoryNFT', {
    from: deployer,
    args: [
      this.Ownablee.address,
      this.StakingPool.address,
      this.UniHelper.address,
      this.Property.address,
      'Vabble NFT', 
      'vnft'
    ],
    log: true,
    deterministicDeployment: false,
    skipIfAlreadyDeployed: false,
  }); 
};

module.exports.id = 'deploy_factory_nft'
module.exports.tags = ['FactoryNFT'];
module.exports.dependencies = ['Ownablee', 'StakingPool', 'UniHelper', 'Property'];
