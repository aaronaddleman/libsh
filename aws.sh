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
}

aws_pre() {
    vault_validate_env
    aws_validate_env
}

#aws_post() {
#}

aws_vpcs_cidr() {
    aws_validate_env
    aws ec2 describe-vpcs | jq '.Vpcs[] | {id: .VpcId, cidr: .CidrBlock}'
}

aws_vpc_sg() {
    aws_validate_env
    aws ec2 describe-security-groups | jq '.SecurityGroups[] | {groupid: .GroupId, description: .Description}'
}

aws_vpc_sg_base() {
    aws_validate_env
    aws ec2 describe-security-groups --filters "Name=description,Values=Base*" | jq '.SecurityGroups[] | {groupid: .GroupId, description: .Description}'
}

aws_vpc_subnets() {
    VPCID=$1
    aws_validate_env
    aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPCID" --output text
}

aws_ami_shared_with() {
    AMI_ID=$1
    aws_validate_env
    aws ec2 describe-image-attribute --attribute launchPermission --image-id $AMI_ID
}

aws_reset(){
    unset AWS_DEFAULT_REGION AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCESS_KEY_ID
}

aws_find_instance_ips_by_name() {
    aws_validate_env
    tag_value=$1
    aws_region=$2
    aws ec2 describe-instances --filters "Name=tag-value,Values=${tag_value}" --region "${aws_region}" --query "Reservations[*].Instances[*].PrivateIpAddress" | jq -r '.[] | .[]' | xargs
}
