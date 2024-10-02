#!/usr/bin/env bash
#
cert_manager_role_arn=$(aws iam list-roles --output yaml |
  yq '.Roles[] |
  select(.RoleName == "*cert-manager*") |
  .Arn') \
  envsubst < template/cluster-issuer.tftpl > kustomize/base/cluster-issuer.yaml
