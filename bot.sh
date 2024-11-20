#!/bin/sh
TOKEN="augh"
URLC="https://api.telegram.org/bot$TOKEN/getUpdates"
URLP="https://api.telegram.org/bot$TOKEN/sendMessage"
MESSAGE="hello"
slovo='"text":"sayhello"}}'
PM="ahh"


while true; do
rm getUpdates
wget "$URLC"
resp=$(cat getUpdates | tail -n1)
if [ "$resp" =  "$PM" ];then
echo "fard"
else
if echo $resp | grep -q "$slovo"; then
sleep 2s
chatid=${resp##*'"chat":{"id":'}
chatid=${chatid%%',"first_name"'*}

rm sendMessage
wget --post-data="chat_id=$chatid&text=$MESSAGE" "$URLP"

fi
fi
PM="$resp"
sleep 1s
done
