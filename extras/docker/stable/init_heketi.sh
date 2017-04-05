#!/bin/bash
# Create the topology for heketi
sleep 2
if [ ! -z $VOLUME_PATH ]; then
	volume_path="$VOLUME_PATH"
	records="${VOLUME_PATH}/loaded_records"
else
	volume_path="/etc/heketi"
	records="/etc/heketi/loaded_records"
fi
if [ ! -f records ]; then
	touch $records
fi

IFS=';' read -ra clusters <<< "$CLUSTERS"
for cluster in "${clusters[@]}"; do
	if grep -q "$cluster" $records; then
		echo "$cluster already loaded; skip"
		continue
	else
	    echo "loading $cluster"
	fi
    printf "{\"clusters\":[\n\t{\"nodes\":[" > $volume_path/tmp-topology.json
    IFS=',' read -ra nodes <<< "$cluster"
    flag=0
    for node in "${nodes[@]}"; do
	    echo "adding $node"
    	if [ $flag -eq 1 ]; then
	    	printf ",\n" >> $volume_path/tmp-topology.json
	    else 
	    	printf "\n" >> $volume_path/tmp-topology.json
	    	flag=1
	    fi
    	printf "\t\t{\"node\":{ \"hostnames\":{\"manage\":[\"$node\"],\"storage\":[\"$node\"]},\"zone\":1}," >> $volume_path/tmp-topology.json
    	printf "\"devices\":[\"$PARTITION\"]}" >> $volume_path/tmp-topology.json
    done
    printf "\n\t]}\n\t]\n}" >> $volume_path/tmp-topology.json
    load_cluster $volume_path/tmp-topology.json
    echo "$cluster" >> $records
done