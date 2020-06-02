source /home/p0dxd/.secrets
PRIVKEY_NAME="privkey3"
P12KEY_NAME="website"
FULLCHAIN_NAME="fullchain3"
CERTS_DIR=".certs"
if [ "$1" ]; then
	certbot renew --cert-name joserod.space --dry-run
fi
#copy the certs
cp /etc/letsencrypt/archive/joserod.space/"$FULLCHAIN_NAME".pem . && chmod +r "$FULLCHAIN_NAME".pem
cp /etc/letsencrypt/archive/joserod.space/"$PRIVKEY_NAME".pem . && chmod +r "$PRIVKEY_NAME".pem
cat $FULLCHAIN_NAME.pem $PRIVKEY_NAME.pem >combined.pem
#create p12
openssl pkcs12 -export -in combined.pem -out "$P12KEY_NAME".p12 -name "$KEYSTORE_ALIAS_SECRET" -password pass:"$KEYSTORE_PASSWORD_SECRET" && chmod +r "$P12KEY_NAME".p12

base64 -w 0 $P12KEY_NAME.p12 > $P12KEY_NAME.p12.base64
base64 -w 0 $FULLCHAIN_NAME.pem > $FULLCHAIN_NAME.pem.base64
base64 -w 0 $PRIVKEY_NAME.pem > $PRIVKEY_NAME.pem.base64

if [ ! -d "/home/p0dxd/$CERTS_DIR" ]; then
	mkdir /home/p0dxd/$CERTS_DIR  
fi

yes | mv *.base64 /home/p0dxd/$CERTS_DIR

yes | keytool -importkeystore  -srckeystore "$P12KEY_NAME".p12 -destkeystore "$P12KEY_NAME".jks -srcstoretype PKCS12 -deststoretype jks -srcstorepass "$KEYSTORE_PASSWORD_SECRET" -deststorepass "$KEYSTORE_PASSWORD_SECRET" -srcalias "$KEYSTORE_ALIAS_SECRET" -destalias "$KEYSTORE_ALIAS_SECRET" -srckeypass "$KEYSTORE_PASSWORD_SECRET" -destkeypass "$KEYSTORE_PASSWORD_SECRET" && chmod +r "$P12KEY_NAME".jks
mv "$P12KEY_NAME".jks /mnt/jenkins/var/jenkins_home/
rm -f *.pem *.p12 *.jks
