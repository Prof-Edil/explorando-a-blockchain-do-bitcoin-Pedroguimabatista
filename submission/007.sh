# Only one single output remains unspent from block 123,321. What address was it sent to?

#!/usr/bin/env bash

#!/bin/bash
set -e

block_hash=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblockhash 123321)
block=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getblock "$block_hash")

unspent_count=0
unspent_address=""

for tx in $(echo "$block" | jq -r '.tx[]'); do
    tx_data=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" getrawtransaction "$tx" 1)
    num_outputs=$(echo "$tx_data" | jq '.vout | length')

    for (( i=0; i<num_outputs; i++ )); do
        txout=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser="user_256" -rpcpassword="LSduUiqlO3wp" gettxout "$tx" "$i")

        if [ "$txout" != "null" ]; then
            addr=$(echo "$tx_data" | jq -r ".vout[$i].scriptPubKey.addresses[0]")

            if [ "$addr" != "null" ] && [ -n "$addr" ]; then
                unspent_address="$addr"
                unspent_count=$((unspent_count+1))
            fi
        fi
    done
done

if [ $unspent_count -eq 1 ]; then
    echo "$unspent_address"
else
    echo "Erro: Encontrado $unspent_count outputs não gastos. Esperava exatamente 1." >&2
    exit 1
fi




