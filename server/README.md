curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY=NRAK-8GT7NAI7PFURCKRDAPRSQIL8CI4 NEW_RELIC_ACCOUNT_ID=2537282 /usr/local/bin/newrelic install -n logs-integration

MAC: /opt/datadog-agent/etc/datadog.yaml

launchctl stop com.datadoghq.agent
launchctl start com.datadoghq.agent