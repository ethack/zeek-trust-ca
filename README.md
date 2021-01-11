
Very rough installation steps:

```
# These steps may need to be run as root or with sudo
# Create a new Zeek plugin that loads the custom certificate into Zeek's trusted cert store
mkdir -p /opt/zeek/share/zeek/custom-ca
# Copy all custom certificates to the directory. Can be .cer, .crt, .pem, .der
# Note that you will need all intermediate and root certificates
cp *.cer /opt/zeek/share/zeek/custom-ca
# Copy the script to the directory as well
cp cer2zeek.sh /opt/zeek/share/zeek/custom-ca
chmod +x /opt/zeek/share/zeek/custom-ca
# Run the script. This generates a __load__.zeek that installs the custom certs.
/opt/zeek/share/zeek/custom-ca/cer2zeek.sh
# Enable the custom-ca plugin. You may need to create this file and directory if it doesn't exist.
# If local.zeek doesn't exist you can download a default one with:
mkdir -p /opt/zeek/share/zeek/site/
# wget -O /opt/zeek/share/zeek/site/local.zeek https://raw.githubusercontent.com/activecm/docker-zeek/master/share/zeek/site/local.zeek
echo >> /opt/zeek/share/zeek/site/local.zeek
echo "# Load custom CA" >> /opt/zeek/share/zeek/site/local.zeek
echo "@load custom-ca" >> /opt/zeek/share/zeek/site/local.zeek
# Restart Zeek
so-zeek-restart || zeekctl deploy || zeek restart
```

# References
- https://securityonion.readthedocs.io/en/latest/zeek.html#custom-scripts
- https://old.zeek.org/bro-workshop-2011/solutions/extending/index.html
- https://superuser.com/a/1207746 


# TODO
- Read CN out of cert and use instead of filename
- Read certs in with Zeek script rather than shell script
- Create package installable with `zkg`
