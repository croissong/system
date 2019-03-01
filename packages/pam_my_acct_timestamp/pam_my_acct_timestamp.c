/* Define which PAM interfaces we provide */
#define PAM_SM_ACCOUNT
#include <security/pam_appl.h>
#include <security/pam_modules.h>

int pam_sm_open_session(pam_handle_t *pamh, int flags, int argc, const char **argv);

/* PAM entry point for accounting */
PAM_EXTERN int pam_sm_acct_mgmt(pam_handle_t *pamh, int flags, int argc, const char **argv) {
    return pam_sm_open_session(pamh, flags, argc, argv);
}
