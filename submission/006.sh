# Which tx in block 257,343 spends the coinbase output of block 256,128?

#!/usr/bin/env bash

b256128_hash="$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash 256128)"
b256128_data="$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock "$b256128_hash")"
cb_txid="$(echo "$b256128_data" | jq -r '.tx[0]')"

b257343_hash="$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash 257343)"
b257343_data="$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock "$b257343_hash")"
txids=$(echo "$b257343_data" | jq -r '.tx[]')

for txid in $txids; do
rawtx="$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$txid" 1)"
found=$(echo "$rawtx" | jq -r --arg cb "$cb_txid" '.vin[] | select(.txid == $cb) | .txid' )
if [ -n "$found" ]; then
echo "$txid"
break
fi
done