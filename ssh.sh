ssh_ec2() {
    local help=$(cat <<HELP
## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

Args needed are:

...shell
ssh_ec2 KeyToUse HostIp CommandToRun
...

HELP
     )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    local key=$1
    local host=$2
    local command=$3

    [ -z $key ] && __exit_with_message "MIA" "Key not found for pos 1"
    [ -z $host ] && __exit_with_message "MIA" "Host not found for pos 2"
    [ -z $command ] && __exit_with_message "MIA" "Command not found for pos 3"
    libsh__debug "Connecting to $host"
    ssh -o "StrictHostKeyChecking no" -q -t -i $key ec2-user@$host $command
}

# ssh_ec2_autokey() {
#     local help=$(cat <<HELP
# ## ssh_ec2

# SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

# WORK IN PROGRESS

# HELP
#          )
#     [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
#     local host=$1
#     local command=$2

#     # try to lookup the host and get its assigned pem key name
#     [ $(command -v aws) ] || libsh__exit_with_message "ERR" "Cmd of aws not found"
#     [ $(command -v jq) ] || libsh__exit_with_message "ERR" "Cmd of jq not found"
#     [ $(command -v lpass) ] || libsh__exit_with_message "ERR" "Cmd of lpass not found"
#     local aws_key_name=$(aws ec2 describe-instances --filter "Name=private-ip-address,Values=0.0.0.0" | jq -r ".Reservations[].Instances[].KeyName")
#     # look for keyname in lpass with grep
#     # get the "id: ######" with awk -F'[][]'
#     # get the #### with awk '{print $2}'
#     local pem_filename=$(lpass ls | grep "$aws_key_name.pem" | awk -F'[][]' '{print $2}' | awk '{print $2}')

#     if [ $(command -v lpass) ]; then
#         # try to find pem based on aws_key_name returned
#         lpass ls | grep "${aws_key_name}.pem" | awk -F'[][]' '{print $2}' | awk '{print $2}'
#     fi

#     [ -z $host ] && libsh__exit_with_message "MIA" "Host not found for pos 2"
#     [ -z $command ] && libsh__exit_with_message "MIA" "Command not found for pos 3"
#     libsh__debug "Connecting to $host"
#     ssh -o "StrictHostKeyChecking no" -q -t -i $key ec2-user@$host $command
# }
