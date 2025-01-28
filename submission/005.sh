# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

#!/usr/bin/env bash

tx="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
tx_data=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction ${tx} 1)
npub1=$(echo "$tx_data" | jq -r '.vin[0].txinwitness[1]')
npub2=$(echo "$tx_data" | jq -r '.vin[1].txinwitness[1]')
npub3=$(echo "$tx_data" | jq -r '.vin[2].txinwitness[1]')
npub4=$(echo "$tx_data" | jq -r '.vin[3].txinwitness[1]')
mulsigaddr=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" createmultisig 1 "[\"$npub1\",\"$npub2\",\"$npub3\",\"$npub4\"]")
echo "$mulsigaddr" | jq -r '.address'
