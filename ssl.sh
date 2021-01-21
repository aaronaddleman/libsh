#
# print expire date of cert
#
# usage: ssl_show_expire_date www.url.com 443
ssl_show_expire_date() {
    local help=$(cat <<HELP
## ssl_show_expire_date

Show the expire date in a SSL cert by a url and port

...shell
ssl_show_expire_date domain.com 443
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    timeout 1 openssl s_client -showcerts -servername $1 -connect $1:$2 2> /dev/null | openssl x509 -noout -enddate
}

#
# look at cert file
#
ssl_inspect() {
    openssl x509 -in $1 -text -noout
}

#
# remove the passphrase from the cert
#
ssl_cert_remove_passphrase() {
    openssl rsa -in $CERTFILE -out $CERTFILE.private-key.no-passphrase.key
}

#
# convert the private key to pem format
#
ssl_cert_convert_privatekey_to_pem() {
    openssl rsa -in $CERTFILE.private-key.no-passphrase.key -outform PEM
}

#
# convert cert
#
# these instructions were taken from the following page:
# https://knowledge.symantec.com/support/partner/index?page=content&actp=CROSSLINK&id=SO20424
ssl_cert_convert() {
    local help=$(cat <<HELP
## ssl_cert_convert

Use some functions to remove the passphrase from a cert and convert privatekey to pem
Args needed are:

...shell
ssl_cert_convert CERTFILE
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    CERTFILE=$1
    ssl_cert_remove_passphrase "$CERTFILE"
    ssl_cert_convert_privatekey_to_pem "$CERTFILE"
}
