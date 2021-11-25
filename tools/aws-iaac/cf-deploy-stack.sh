#!/usr/bin/env bash
# ------------------------------
# Deploy CloudFormation stack from source code.
###############################################
# TODO: add comments
readonly AWS_REGION="${AWS_REGION:-us-east-1}"
readonly TEMPLATE="$1"

[[ -n "$2" ]] && DEBUG=1

[[ -z "$AWS_PROFILE" ]] && printf %s\\n "Error: profile isn't specified." && exit 1
[[ -z "$TEMPLATE" ]] && printf %s\\n "Error: template isn't specified." && exit 1

readonly STACK_NAME=$(basename "$TEMPLATE" | sed 's/\(.*\)\..*/\1/')

printf %s\\n "Upload template '$TEMPLATE' for profile '$AWS_PROFILE' in region '$AWS_REGION'. Disable rollback set to $( (( DEBUG == 1 )) && printf %s 'true' || printf %s 'false' )."

# TODO: may be add --tags <value> for informativeness
aws cloudformation create-stack \
--stack-name "$STACK_NAME" \
--template-body "file://$TEMPLATE" \
--disable-rollback \
--parameters \
ParameterKey="AWSEBEnvironmentName",ParameterValue="$STACK_NAME" \
ParameterKey="AWSEBEnvironmentId",ParameterValue="" \
ParameterKey="AWSEBEnvironmentBucket",ParameterValue="" \
--profile "$AWS_PROFILE" \
--region "$AWS_REGION" \
${DEBUG:+"--disable-rollback"}

printf %s\\n "Operation successful."

exit 0
