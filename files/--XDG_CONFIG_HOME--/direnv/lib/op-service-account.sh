# file location: ${XDG_CONFIG_HOME}/direnv/lib/op-service-account.sh
#
# direnv sources every ${XDG_CONFIG_HOME}/direnv/lib/*.sh before an .envrc, so any folder opts in with:
#   use op_service_account 'op://<vault>/<item>/<field>'
# The argument is the 1Password reference of the service-account token (a reference, not a secret, so
# it is safe in an .envrc). The token is read with the signed-in 1Password app -- no keychain entry is
# involved -- and OP_SERVICE_ACCOUNT_TOKEN is then set only inside that folder (direnv unloads it on the
# way out), so the remaining 'op' calls in the .envrc and in the folder's tools run as the service account.
# Tradeoff: entering the folder while 1Password is locked shows its unlock prompt once per load.
# Service accounts cannot read Private vaults: keep the items such a folder needs in a shared vault.
use_op_service_account() {
  local reference="${1:-}" token
  if [ -z "${reference}" ]; then
    log_error "use op_service_account needs the token's 1Password reference, e.g. use op_service_account 'op://<vault>/<item>/credential'"
    return 1
  fi
  # A parent folder's .envrc may already have set it; skip the extra 1Password call.
  if [ -n "${OP_SERVICE_ACCOUNT_TOKEN:-}" ]; then
    return 0
  fi
  if ! token="$(op read "${reference}")"; then
    log_error "could not read the service-account token from '${reference}' -- is 1Password unlocked?"
    return 1
  fi
  export OP_SERVICE_ACCOUNT_TOKEN="${token}"
}
