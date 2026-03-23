# Create a SegWit address.
NEW_SEGWIT=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32)
# Add funds to the address.
supress=$(bitcoin-cli -regtest -rpcwallet=btrustwallet generatetoaddress 102 $NEW_SEGWIT)
# Return only the Address
bitcoin-cli -regtest -rpcwallet=btrustwallet getaddressinfo $NEW_SEGWIT | jq -r '.address'
