declare EC2_REGION=''

__get_env() {
  EC2_REGION="$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')"
}


:<<'DOCUMENT'
"privateIp" : "10.10.1.99",
"devpayProductCodes" : null,
"marketplaceProductCodes" : null,
"version" : "2017-09-30",
"region" : "us-west-2",
"instanceId" : "i-061c199944d0af5a8",
"billingProducts" : null,
"instanceType" : "t2.micro",
"kernelId" : null,
"ramdiskId" : null,
"accountId" : "734741078887",
"availabilityZone" : "us-west-2a",
"architecture" : "x86_64",
"imageId" : "ami-221f5c5a",
"pendingTime" : "2018-06-12T23:28:41Z"
DOCUMENT
