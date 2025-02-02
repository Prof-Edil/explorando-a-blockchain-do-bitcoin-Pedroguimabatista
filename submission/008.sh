# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

#!/usr/bin/env bash

txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
tx_json=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$txid" 1)
witness_script=$(echo "$tx_json" | jq -r '.vin[0].txinwitness[2]')
decoded=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" decodescript "$witness_script")
echo "$decoded" | jq -r '.asm' | awk '{print $2}'
