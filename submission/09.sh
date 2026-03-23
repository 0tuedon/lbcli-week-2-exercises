# Create a transaction whose fee can be later updated to a higher fee if it is stuck or doesn't get mined on time

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

txid_1=$(bitcoin-cli -regtest decoderawtransaction $raw_tx | jq -r '.txid')
total_amount=$(bitcoin-cli -regtest decoderawtransaction $raw_tx | jq -r '.vout | .[] | .value' | awk '{s+=$1} END {print int(s*100000000 + 0.5)}')
amount=0.2
vout_1=0
vout_2=1
address_to_send="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
replace_by_fee=1 #4294967293

bitcoin-cli -regtest -named createrawtransaction inputs='''[{"txid": "'$txid_1'", "vout":'$vout_1', "sequence":'$replace_by_fee'}, {"txid": "'$txid_1'", "vout": '$vout_2', "sequence":'$replace_by_fee'}]''' outputs='''[{"'$address_to_send'":'$amount'}]'''

