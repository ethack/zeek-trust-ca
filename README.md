
Very rough installation steps:

```
# Create a new Zeek plugin that loads the custom certificate into Zeek's trusted cert store
mkdir /opt/zeek/share/zeek/custom-ca
# Copy all custom certificates to the directory. Can be .cer, .crt, .pem, .der
cp *.cer /opt/zeek/share/zeek/custom-ca
# Copy the script to the directory as well
cp cer2zeek.sh /opt/zeek/share/zeek/custom-ca
# Run the script. This generates a __load__.zeek that installs the custom certs.
/opt/zeek/share/zeek/custom-ca/cer2zeek.sh
# Enable the custom-ca plugin
echo >> /opt/zeek/share/zeek/site/local.zeek
echo "# Load custom CA" >> /opt/zeek/share/zeek/site/local.zeek
echo "@load custom-ca" >> /opt/zeek/share/zeek/site/local.zeek
# Restart Zeek
so-zeek-restart || zeekctl deploy
```

# References
- https://securityonion.readthedocs.io/en/latest/zeek.html#custom-scripts
- https://old.zeek.org/bro-workshop-2011/solutions/extending/index.html
- https://superuser.com/a/1207746 


# TODO
- Read CN out of cert and use instead of filename
- Read certs in with Zeek script rather than shell script
- Create package installable with `zkg`