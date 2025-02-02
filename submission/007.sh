# Only one single output remains unspent from block 123,321. What address was it sent to?

#!/usr/bin/env bash

hash123321=$(bitcoin-cli  -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp"  getblockhash 123321)
blockdata=$(bitcoin-cli  -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp"  getblock "$hash123321")
txids=$(echo "$blockdata" | jq -r '.tx[]')

for txid in $txids; do
rawtx=$(bitcoin-cli  -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp"  getrawtransaction "$txid" 1)
vout_count=$(echo "$rawtx" | jq '.vout | length')

for (( i=0; i<"$vout_count"; i++ )); do
unspent=$(bitcoin-cli  -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp"  gettxout "$txid" "$i")
if [ -n "$unspent" ]; then
address=$(echo "$rawtx" | jq -r ".vout[$i].scriptPubKey.addresses[0] // .vout[$i].scriptPubKey.address // empty")
echo "$address"
exit 0
fi
done
done



