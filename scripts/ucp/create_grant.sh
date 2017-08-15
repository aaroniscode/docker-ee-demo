# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{print $2}')
subject_id=$1
collection=$2
role_id=$3

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -X PUT https://ucp.${tld}/collectionGrants/${subject_id}/${collection}/${role_id}
