# How many new outputs were created by block 123,456?

total_outputs=0
for txid in $txids; do
  outputs=$(C:\Program Files\Bitcoin\daemon\bitcoin-cli.exe -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$txid" 1 | jq '.vout | length')
  total_outputs=$((total_outputs + outputs))
done
echo "Total outputs in block 123,456: $total_outputs"

