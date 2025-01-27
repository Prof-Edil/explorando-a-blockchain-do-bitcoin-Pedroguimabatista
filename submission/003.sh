# How many new outputs were created by block 123,456?

total_outputs=0

for txid in $txids; do
  outputs=$(bitcoin-cli getrawtransaction "$txid" 1 | jq '.vout | length')
  total_outputs=$((total_outputs + outputs))
done

echo "Total de outputs no bloco 123456: $total_outputs"

