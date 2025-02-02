# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
#!/usr/bin/env bash

XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

DESC1="tr(${XPUB}/*)"


for DESC in "$DESC1"; do
  CHK=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp"  getdescriptorinfo "$DESC" | jq -r '.descriptor')
  ADDR=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp"  deriveaddresses "$CHK" "[100,100]" | jq -r '.[0]')
  echo "$ADDR"
done
