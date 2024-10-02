#!/usr/bin/env bash
#
# cert_manager_role_arn=$(aws iam list-roles --output yaml |
  # yq '.Roles[] |
  # select(.RoleName == "*cert-manager*") |
  # .Arn') \
  # envsubst < template/cluster-issuer.tftpl > kustomize/base/cluster-issuer.yaml

name=$(k -n envoy-gateway-system get svc envoy-demoapp-gw-envoyproxy-bdecae54 -oyaml | yq '.status.loadBalancer.ingress[0].hostname') envsubst < template/main.tftpl > main.tf
