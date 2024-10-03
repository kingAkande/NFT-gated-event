import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const NftEventModule = buildModule("NftEventModule", (m) => {


  const nftEvent = m.contract("NftEvent");

  return { nftEvent };
});

export default NftEventModule;
