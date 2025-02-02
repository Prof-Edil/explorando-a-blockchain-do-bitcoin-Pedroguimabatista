# Only one single output remains unspent from block 123,321. What address was it sent to?

# Only one single output remains unspent from block 123,321. What address was it sent to?

hash123321=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash "123321")
blockdata=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock $hash123321)
siginputtx=$(echo $blockdata | jq -r '.tx[6]')
answer=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$siginputtx" 1)
echo $answer | jq -r '.vout[0].scriptPubKey.address'

