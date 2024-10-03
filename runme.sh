#!/usr/bin/env bash
#
# cert_manager_role_arn=$(aws iam list-roles --output yaml |
  # yq '.Roles[] |
  # select(.RoleName == "*cert-manager*") |
  # .Arn') \
  # envsubst < template/cluster-issuer.tftpl > kustomize/base/cluster-issuer.yaml
value=($(yq '.metadata | (.namespace, .name)' kustomize/base/gateway.yaml))
echo "${value[@]}"
namespace_name=$(printf "%s/%s" "${value[0]}" "${value[1]}")
echo $namespace_name
hash_value=$(printf "%s" "$namespace_name" | sha256sum | awk '{print substr($1,1,8)}')
echo $hash_value
svc_name=$(printf "envoy-%s-$hash_value" "$(echo $namespace_name | tr '/' ''-)")
echo $svc_name
dns_name=$(k -n envoy-gateway-system get svc $svc_name -oyaml | yq '.status.loadBalancer.ingress[0].hostname') envsubst < template/main.tftpl > main.tf
