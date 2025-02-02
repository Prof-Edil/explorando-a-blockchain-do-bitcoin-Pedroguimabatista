# Only one single output remains unspent from block 123,321. What address was it sent to?


hash123321=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash "123321")

blockdata=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock $hash123321)


transactions=$(echo $blockdata | jq -r '.tx[]')


while IFS= read -r tx; do
    
    txdata=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$tx" 1)
    
    
    vout_count=$(echo $txdata | jq '.vout | length')
    
    for i in $(seq 0 $(($vout_count - 1))); do
        unspent=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" gettxout "$tx" $i)
        if [ ! -z "$unspent" ]; then
            echo "Found unspent output:"
            echo $txdata | jq -r ".vout[$i].scriptPubKey.address"
        fi
    done
done <<< "$transactions"




