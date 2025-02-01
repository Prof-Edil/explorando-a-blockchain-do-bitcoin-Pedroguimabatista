# Only one single output remains unspent from block 123,321. What address was it sent to?

#!/usr/bin/env bash

blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash 123321)
txids=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock "$blockhash" | jq -r '.tx[]')

for txid in $txids; do
rawtx=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$txid" 1)
vout_count=$(echo "$rawtx" | jq '.vout | length')

for (( i=0; i<"$vout_count"; i++ )); do
unspent=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" gettxout "$txid" "$i")
if [ -n "$unspent" ]; then
out=$(echo "$rawtx" | jq ".vout[$i]")
address=$(echo "$out" | jq -r '.scriptPubKey.addresses[0] // .scriptPubKey.address // empty')
echo "$address"
exit 0
fi
done
done