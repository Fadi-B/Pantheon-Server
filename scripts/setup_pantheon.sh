#!/bin/bash

sudo apt-get update

#Dealing with Pantheon

git clone https://github.com/StanfordSNR/pantheon.git

sudo apt-get install python-yaml

cd pantheon

tools/fetch_submodules.sh
src/experiments/setup.py --install-deps --schemes "bbr copa cubic fillp fillp_sheep ledbat pcc pcc_experimental quic scream sprout taova vegas verus vivace webrtc"
src/experiments/setup.py --setup --schemes "bbr copa cubic fillp fillp_sheep ledbat pcc pcc_experimental quic scream sprout taova vegas verus vivace webrtc"

sudo sysctl -w net.ipv4.ip_forward=1

#Dealing with the pcap -> panth traces conversion



sudo add-apt-repository -y ppa:wireshark-dev/stable
sudo apt install -y tshark



if [[ -d "pcap_traces" ]]
then
  echo "pcap_traces exists"
else
  echo "pcap_traces creating directory"
  mkdir pcap_traces
fi

if [[ -d "panth_traces" ]]
then
  echo "panth_traces exists"
else
  echo "panth_traces creating directory"
  mkdir panth_traces
fi


chmod +x pcap_to_pantheon.py

cd pcap_traces

#Below should be edited such that converted files are numbered

i=0

for FILE in *;
do
  ../pcap_to_pantheon.py $FILE 155.98.38.41 "../panth_traces/$FILE.x"
  echo i: $i
done;
