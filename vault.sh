vault_validate_env() {
    # check vault command exists
    command -v vault > /dev/null
    [ $? = "0" ] && VAULT_EXISTS=t
    [ $? = "0" ] || VAULT_EXISTS=f && libsh_exit_with_message "Problem" "vault cannot be found in $PATH"

    # check VAULT_ADDR is populated
    if [ -z $VAULT_ADDR ]; then
        libsh__exit_with_message "Problem" "VAULT_ADDR is not set"
    else
        vault_host=$(echo $VAULT_ADDR | sed -E 's/(http|https)\:\/\///g' | awk -F\: '{print $1}')
        vault_port=$(echo $VAULT_ADDR | sed -E 's/(http|https)\:\/\///g' | awk -F\: '{print $2}')
        if command -v nc > /dev/null; then
            nc -w 2 -z ${vault_host} ${vault_port} >/dev/null 2>&1
            local nc_results=$(echo "$?")

            if [ $nc_results -gt 0 ]; then
                libsh__exit_with_message "Problem" "unable to reach $vault_host on $vault_port"
            fi
        fi
    fi

    # # check vault version
    # VAULT_VERSION=$(vault --version | awk '{print $2}')
    # [ $VAULT_VERSION = "v1.4*"] || libsh__exit_with_message "Problem" "Vault version not supported"
}

vault_pre() {
    [ -z $LIBSH_VAULT_TOKEN_ALWAYS_UNSET ] || unset VAULT_TOKEN
    vault_validate_env
}

vault_read() {
    local help=$(cat <<HELP
## vault_read

Read secrets from vault with curl

...shell
vault_read path/to/secret
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    VAULT_PATH=$1
    VAULT_TOKEN=$(jq -r '.auth.client_token' <<<$VAULT_DATA)
    VAULT_READ=$(curl \
                     -H "X-Vault-Token: $VAULT_TOKEN"
                     --silent \
                     --request GET \
                     $VAULT_ADDR/v1/$VAULT_PATH)
}

vault_policies() {
    local help=$(cat <<HELP
## vault_2_aws

Grab credentials from Vault and set to shell
environment variables.

Assumes user has logged into vault and $VAULT_ADDR is setup properly given
vault path as input, reads from vault and exports AWS_ env vars properly

...shell
vault_2_aws path/to/aws/sts/role
...

If set the environment variable of LIBSH_USE_VAULT_LOGIN this function
will check the usage of your vault token and if its not valid, to try
login and prompt for password.
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    vault token lookup -format=json | jq '.data.policies'
}

v2aws(){
    local help=$(cat <<HELP
## vault_2_aws

Grab credentials from Vault and set to shell
environment variables.

Assumes user has logged into vault and $VAULT_ADDR is setup properly given
vault path as input, reads from vault and exports AWS_ env vars properly

...shell
vault_2_aws path/to/aws/sts/role
...

If set the environment variable of LIBSH_USE_VAULT_LOGIN this function
will check the usage of your vault token and if its not valid, to try
login and prompt for password.
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [ ${1} = "--help" ] && libsh__libsh_help v2aws
    vault_pre
    aws_validate_env
    aws_pre || libsh__exit_with_message "Unable to load 'aws_pre' function."
    if [ -z "$1" ];then
        echo "Must specify vault path to read"
        return 1
    fi

    # clear vars being set
    aws_reset

    # if LIBSH_USE_VAULT_LOGIN is set, then try logging in
    [ ! -z ${LIBSH_USE_VAULT_LOGIN} ] && vault_login > /dev/null

    echo "Looking at vault path $1"

    local vault_json=$(vault write -format=json $1 -ttl=4h)

    # if there is a problem, exit with error
    [ $? -ne 0 ] && __exit_with_message "Problem reading from vault or path '$1'"

    export AWS_ACCESS_KEY_ID=$(jq -r '.data.access_key' <<< $vault_json)
    export AWS_SECRET_ACCESS_KEY=$(jq -r '.data.secret_key' <<< $vault_json)
    export AWS_SESSION_TOKEN=$(jq -r '.data.security_token' <<< $vault_json)
    aws sts get-caller-identity

}

#
# eg:
#
# vault_decrypt_key
# (enter your key)
# (should get reponse)
#
vault_decrypt_key() {
    local help=$(cat <<HELP
## vault_decrypt_key

asks for your key wrapped in base64 and tries to decrypt it

...shell
vault_decrypt_key
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    case $OS_TYPE in
        darwin*)
            echo "Copy your encrypted key to your buffer "
            echo "Hit enter when your ready."
            read -s key
            pbpaste | base64 -D | gpg -d --pinentry-mode loopback
            unset $key
            ;;
        *)
            echo "undefined."
            ;;
    esac


}

vault_verify_host() {
    local help=$(cat <<HELP
## vault_verify_host

Validates a vault host. Defaults to 8200 and cannot be changed at this time.

...shell
vault_verify_host hostname.com
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    VAULT_HOST=$1
    export VAULT_SKIP_VERIFY=1
    export VAULT_ADDR="https://${VAULT_HOST}:8200"
    curl https://${VAULT_HOST}:8200/v1/sys/health -k
}

vault_setenv() {
    local help=$(cat <<HELP
## vault_setenv

Sets the VAULT_TOKEN to your .data.id value

...shell
vault_setenv
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    export VAULT_TOKEN=`vault token lookup --format=json | jq -r '.data.id'`
}

vault_eval() {
    local help=$(cat <<HELP
## vault_eval

read a vault path and set variables with an optional prefix

eg.

...shell
vault_eval account/12345/sts/Application-Ops "mystuff_"
echo $mystuff_secret_key
echo $mystuff_access_key
echo $mystuff_security_token
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    local VAULT_PATH=$1
    local VAR_PREFIX=$2
    eval $(vault read -format=json ${VAULT_PATH} | jq -r --arg VAR_PREFIX "${VAR_PREFIX}" '.data | to_entries | .[] | "export " + $VAR_PREFIX + .key + "=" + .value + ""')
}

vault_login() {
    local help=$(cat <<HELP
## vault_login

Login to vault with VAULT_USER variable or the USER
variable. Use the VAULT_METHOD_VALUE for what method
to login with or just try logging in.

...shell
export VAULT_METHOD_VALUE=ldap
export VAULT_USER=aaronaddleman
vault_login
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    vault_pre
    local VAULT_USER=${1:-$USER}
    vault token lookup > /dev/null
    if [ $? != 0 ]; then
        case "$VAULT_METHOD_VALUE" in
            ldap)
                vault login -method=$VAULT_METHOD_VALUE username=$VAULT_USER
                ;;
            *)
                vault login username=$VAULT_USER
        esac
    fi
}

# vault_share
#
#
vault_share() {
    local help=$(cat <<HELP
## vault_share

Share the contents of a file with another person

...shell
vault_share 10m mysecret.txt

➜ vault_share 2s mysecret.txt
Success! Data written to: cubbyhole/data
To share these secrets, tell the receiving party to use:
VAULT_ADDR=https://VAULTADDR:8200 VAULT_TOKEN=*********************rNH vault read -field=value cubbyhole/data
...

To remove your secret before the TTL:

...shell
vault token revoke 5sspSoLG3kWMBqTU4iXihrNH
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    vault_pre
    # ttl
    TTL=$1
    # file with secrets
    FILE=$2
    # create token with policy=default
    CLIENT_TOKEN=$(vault token create -format=json -policy="default" -ttl=${TTL} | jq -r '.auth.client_token')
    # write secret to cubby with token created
    VAULT_TOKEN=${CLIENT_TOKEN} vault write cubbyhole/data value=@${FILE}
    # print line for sharing secret
    echo "To share these secrets, tell the receving party to use:"
    echo "VAULT_ADDR=$VAULT_ADDR VAULT_TOKEN=$CLIENT_TOKEN vault read -field=value cubbyhole/data"
    unset VAULT_TOKEN
}


#
# VAULT MGMT
#
# vault_install_token_helper() {
#     [ ! -f $HOME/.vault ] && echo "token_helper = \"${LIBSH_HOME}/scripts/vault_token_helper.sh\"" > ~/.vault
# }

vault_data() {
    cat $HOME/.config/libsh/hc_vaults.json
}

vault_list() {
    local help=$(cat <<HELP
## vault_list

List known vaults from ~/.config/libsh/hc_vaults.json

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0

    # test for config file
    [ -f $HOME/.config/libsh/hc_vaults.json ] || libsh__exit_with_message "Missing $HOME/.config/libsh/hc_vaults.json"
    # load host
    local vault_hosts=$(jq -r '.[].name' <<<$(vault_data) )
    echo $vault_hosts
}

vault_use() {
    local help=$(cat <<HELP
## vault_use

Select one of the vault hosts using the name in $HOME/.config/libsh/hc_vaults.json

...shell
vault_use name_of_vault
...

This will set the following:

* VAULT_ADDR
* VAULT_METHOD
* VAULT_USER

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    local name=$1
    local selected_record=$(jq -r --arg NAME $name '.[] | select(.name == $NAME)' <<<$(vault_data) )
    export VAULT_ADDR=$(jq -r '.url' <<<$selected_record )

    local VAULT_METHOD=$(jq -r '.auth_method' <<<$selected_record )
    local VAULT_USER=$(jq -r '.auth_user' <<<$selected_record )

    [ -d $HOME/.config/vault/tokens ] || mkdir -p $HOME/.config/vault/tokens
}
