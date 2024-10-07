#!/bin/bash
TOKEN="fard"
URLC="https://api.telegram.org/bot$TOKEN/getUpdates"
URLP="https://api.telegram.org/bot$TOKEN/sendMessage"
#what no! stop!
slovo='"text":"sayhello"}}'
MSGDATE=0
while true; do
resp=$(curl -s $URLC \
| tail -n1)
#echo $resp
#echo $slovo
if [[ "$resp" == *"$slovo"* ]]; then
res=$resp
chatid=$(
echo $res | awk -F \
'"chat":{"id":|,"title"'\
 '{print $2}'\
)
date=$(
echo $res | awk -F \
'"date":|,"text"'\
 '{print $2}'\
)

echo $date
echo $chatid

if [[ "$MSGDATE" != "0" ]]; then
if [[ "$MSGDATE" != *"$date"* ]]; then
MSG=$(shuf -n1 slova)
curl -s -X POST $URLP -d chat_id=$chatid -d text="$MSG"
#echo $res
fi
fi
export MSGDATE="$date"
fi
#uhhh working not well with 0.1s and less
sleep 1s
done
