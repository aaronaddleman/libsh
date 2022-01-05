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


ssl_split_pem() {
    local help=$(cat <<HELP
## ssl_split_pem

Use this to take a OpenSSL pem file and split its parts into separate files of PrivateKey, Certificate, and Chain.

...shell
ssl_split_pem CERTFILE.pem
...

Expect the output to make the following files:

CERTFILE.json       <-- certs in json on oneline
CERTFILE-chain.crt  <-- chain certificate
CERTFILE.crt        <-- certificate key
CERTFILE.key        <-- private key
CERTFILE.pem        <-- original file

HELP
      )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    pemfile=$1

    pemformatparts=`grep -E "BEGIN.*PRIVATE KEY|BEGIN CERT" ${pemfile} 2> /dev/null | wc -l`

    if [ ${pemformatparts} -lt 2 ]
    then
	      echo "ERROR: ${pemfile} is not combined PEM format"
	      exit 1
    fi

    getcn=$(/usr/bin/openssl x509 -noout -subject -in ${pemfile} | sed -e "s/.*CN=//g" -e "s/\/.*//g")

    if [[ "${getcn}" == "" ]]
    then
	      pembase=${pemfile%%????}
    else
	      echo "Retrieved CN, using ${getcn} as basename"
	      pembase=${getcn}
    fi

    # Extract key
    echo -n "Extracting key ${pembase}.key "
    openssl pkey -in ${pemfile} -out ${pembase}.key || {
	      echo "FAILED"
        libsh__exit_with_message "Error"
    }
    echo "DONE"
    # Extract cert
    echo -n "Extracting certificate ${pembase}.crt "
    #/usr/bin/openssl x509 -in ${pemfile}  -outform DER -out ${pembase}.der.crt
    openssl x509 -in ${pemfile}  -outform PEM -out ${pembase}.crt || {
	      echo "FAILED"
        libsh__exit_with_message "Error"
    }
    echo "DONE"
    # Extract chain
    echo -n "Extracting certificate chain ${pembase}-chain.crt "
    /usr/bin/openssl crl2pkcs7 -nocrl -certfile ${pemfile} |   /usr/bin/openssl pkcs7 -print_certs -out ${pembase}-chain.crt || {
	      echo "FAILED"
        libsh__exit_with_message "Error"
    }
    echo "DONE"

    [[ -f ${pembase}.key ]] && local pembaseKEY_oneline=$(awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' ${pembase}.key)
    [[ -f ${pembase}.crt ]] && local pembaseCRT_oneline=$(awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' ${pembase}.crt)
    [[ -f ${pembase}-chain.crt ]] && local pembaseChainCRT_oneline=$(awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' ${pembase}-chain.crt)

    cat >${pembase}.json <<EOF
{
  "certificate": "${pembaseCRT_oneline%??}",
  "certificateChain": "${pembaseChainCRT_oneline%??}",
  "privateKey": "${pembaseKEY_oneline%??}"
}
EOF

}
