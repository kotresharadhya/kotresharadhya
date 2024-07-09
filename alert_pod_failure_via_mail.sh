#!/bin/bash

# Set the namespace to monitor
namespace="<namespace"

# Get the list of failing or crash-loop-back pods
failing_pods=$(kubectl get pods -A -o custom-columns="POD:metadata.name,STATE:status.containerStatuses[*].state.waiting.reason" | grep -v "none")

# Check if there are any failing pods
if [ -n "$failing_pods" ]; then
    # Send an email alert
    mail -s "Pods Alert in Namespace $namespace" <mail_address>@example.com <<EOF
    Dear User,

    There are pods which are not in running state  in the $namespace namespace. 
    Please investigate and take appropriate actions.
    Here is the list of pods which are not in running state.
    $failing_pods
    Regards,
    Your DevOps Team
EOF
else
    echo "No alert: No failing pods found in the $namespace namespace."
fi

