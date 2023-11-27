slave_array=(10.36.0.6 10.40.0.3); index=2 && while [ ${index} -gt 0 ]; do for slave in ${slave_array[@]}; do if echo 'test open port' 2>/dev/null > /dev/tcp/${slave}/1099; then echo ${slave}' ready' && slave_array=(${slave_array[@]/${slave}/}); index=$((index-1)); else echo ${slave}' not ready'; fi; done; echo 'Waiting for slave readiness'; sleep 2; done
echo "Installing needed plugins for master"
cd /opt/jmeter/apache-jmeter/bin
sh PluginsManagerCMD.sh install-for-jmx PetStoreAPIScript1.jmx
echo "Done installing plugins, launching test"
jmeter -Ghost= -Gport= -Gprotocol= -Gthreads= -Gduration= -Grampup= --reportatendofloadtests --reportoutputfolder /report/report-PetStoreAPIScript1.jmx-2023-11-24_062801 --logfile /report/PetStoreAPIScript1.jmx_2023-11-24_062801.jtl --nongui --testfile PetStoreAPIScript1.jmx -Dserver.rmi.ssl.disable=true --remoteexit --remotestart 10.36.0.6 >> jmeter-master.out 2>> jmeter-master.err &
trap 'kill -10 1' EXIT INT TERM
java -jar /opt/jmeter/apache-jmeter/lib/jolokia-java-agent.jar start JMeter >> jmeter-master.out 2>> jmeter-master.err
echo "Starting load test at : Fri Nov 24 06:28:01 UTC 2023" && wait
