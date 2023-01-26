module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const { CONFIG, NETWORK } = require('../scripts/utils');
  
  if(NETWORK == 'mumbai') {
    this.vabToken = CONFIG.mumbai.vabToken
    this.usdc = CONFIG.mumbai.usdcAdress
  } else if(NETWORK == 'ethereum') {
    this.vabToken = CONFIG.ethereum.vabToken
    this.usdc = CONFIG.ethereum.usdcAdress
  } else if(NETWORK == 'polygon') {
    this.vabToken = CONFIG.polygon.vabToken
    this.usdc = CONFIG.polygon.usdcAdress
  }

  await deploy('Ownablee', {
    from: deployer,
    args: [
      CONFIG.daoWalletAddress,
      this.vabToken,            // mockVAB
      this.usdc
    ],
    log: true,
    deterministicDeployment: false,
    skipIfAlreadyDeployed: false,
  });
};

module.exports.id = 'deploy_ownablee'
module.exports.tags = ['Ownablee'];
