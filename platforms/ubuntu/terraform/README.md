# Example

## Summary

This example shows how to terraform a host with remote SSH access enabled.


The example assumes that a key set has been imported.


```
marckel@aics-macbook: ssh-keygen -t rsa -C "terra-example" -f ~/.ssh/terra-example

jmarckel@aics-macbook: ls ~/.ssh
id_rsa      known_hosts  terra-test.pub     terra-example.pub
id_rsa.pub  terra-test   terra-example

jmarckel@aics-macbook:  aws ec2 import-key-pair \
	--debug \
	--key-name "terra-example-key" \
	--public-key-material file://~/.ssh/terra-example.pub
```

In this case, once the instance is started, we can ssh as user 'ubuntu' using
the key set.

```
ssh -i ~/.ssh/terra-example ubuntu@ec2-3-16-180-110.us-east-2.compute.amazonaws.com
```


