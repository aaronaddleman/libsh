
aws_validate_env() {
    if command -v aws > /dev/null; then
        AWS_EXISTS=t
    else
        AWS_EXISTS=missing
        libsh__exit_with_message "Problem" "aws command is $AWS_EXISTS"
        return 1
    fi

    if command -v jq > /dev/null; then
        JQ_EXISTS=t
    else
        JQ_EXISTS=f
        libsh__exit_with_message "Problem" "jq status is $JQ_STATUS"
        return 1
    fi

    export AWS_CLI_VERSION=$(aws --version | awk '{print $1}' | awk -F\/ '{print $2}')

    [[ $AWS_CLI_VERSION =~ '^1.*' ]] && export LIBSH_AWS_CMD="aws"
    [[ $AWS_CLI_VERSION =~ '^2.*' ]] && export LIBSH_AWS_CMD="aws --no-cli-pager"
}

aws_pre() {
    vault_validate_env
    aws_validate_env
}

#aws_post() {
#}

aws_vpcs_cidr() {
    local help=$(cat <<HELP
## aws_vpcs_cidr

List cidr blocks for vpcs in current account

Eg.

...shell
aws_vpcs_cidr
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    aws_validate_env
    eval "$LIBSH_AWS_CMD ec2 describe-vpcs" | jq '.Vpcs[] | {id: .VpcId, cidr: .CidrBlock}'
}

aws_vpc_sg() {
    local help=$(cat <<HELP
## aws_vpc_sg

List security groups ID and description for current account

Eg.

...shell
aws_vpc_sg
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    aws_validate_env
    eval "$LIBSH_AWS_CMD ec2 describe-security-groups | jq '.SecurityGroups[] | {groupid: .GroupId, description: .Description}'"
}

aws_vpc_subnets() {
    local help=$(cat <<HELP
## aws_vpc_subnets

List subnets groups ID and description for current account

Eg.

...shell
aws_vpc_sg
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    VPCID=$1
    aws_validate_env
    eval "$LIBSH_AWS_CMD ec2 describe-subnets --filters \"Name=vpc-id,Values=$VPCID\" --output text"
}

aws_cli_install_macos_2() {
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "/tmp/AWSCLIV2.pkg"
    sudo installer -pkg /tmp/AWSCLIV2.pkg -target /
    rm /tmp/AWSCLIV2.pkg
}

aws_ami_shared_with() {
    local help=$(cat <<HELP
## aws_ami_shared_with

List the AWS accounts the AMI is shared with

Eg.

...shell
aws_ami_shared_with AMI-ID
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    AMI_ID=$1
    aws_validate_env
    eval "$LIBSH_AWS_CMD ec2 describe-image-attribute --attribute launchPermission --image-id $AMI_ID"
}

aws_reset(){
    unset AWS_DEFAULT_REGION AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCESS_KEY_ID
}

aws_find_instance_ips_by_name() {
    local help=$(cat <<HELP
## aws_find_instance_ips_by_name

Find instance ips by name and return their private ip address

Eg.

...shell
aws_find_instance_ips_by_name "*Name*Pattern*"
aws_find_instance_ips_by_name "*EndName"
aws_find_instance_ips_by_name "StartName*"
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    aws_validate_env
    tag_value=$1
    aws_region=$2
    eval "$LIBSH_AWS_CMD ec2 describe-instances --filters \"Name=tag-value,Values=${tag_value}\" --region \"${aws_region}\" --query \"Reservations[*].Instances[*].PrivateIpAddress\" | jq -r '.[] | .[]' | xargs"
}


aws_find_lambda_arn_by_name() {
    local help=$(cat <<HELP
## aws_find_lambda_arn_by_name

Find a lambda ARN by filtering on its name

Eg.

...shell
aws_find_lambda_arn_by_name "*pattern*"
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    aws_validate_env
    pattern=$1
    aws_region=${2:-us-west-2}
    eval "$LIBSH_AWS_CMD lambda list-functions --query 'Functions[?contains(FunctionName, \`${pattern}\`) == \`true\`].FunctionArn'"
}

aws_find_download_url_lambda_arn() {
    local help=$(cat <<HELP
## aws_find_download_url_lambda_arn

Find a download url from a lambda arn

Eg.

...shell
aws_find_download_url_lambda_arn the_arn
aws_find_download_url_lambda_arn the_arn | xargs -L 1 wget
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    aws_validate_env
    lambda_arn=$1
    eval "$LIBSH_AWS_CMD lambda get-function --function-name ${lambda_arn} --query 'Code.Location'"
}
