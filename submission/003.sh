# How many new outputs were created by block 123,456?
#!/usr/bin/env bash

block_number=123456
blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash "$block_number")

total_outputs=$(
  bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock "$blockhash" 2 \
  | jq '[.tx[].vout | length] | add'
)

echo "$total_outputs"
