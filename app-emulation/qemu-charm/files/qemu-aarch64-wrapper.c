/*
 * Call QEMU binary with additional "-cpu cortex-a53" argument.
 *
 * Copyright (c) 2018 sakaki <sakaki@deciban.com>
 * License: GPL v3.0+
 *
 * Based on code from the Gentoo Embedded Handbook
 * ("General/Compiling_with_qemu_user_chroot")
 */
 
 /* https://github.com/multiarch/qemu-user-static/releases  some bins here... 
 */


#include <string.h>
#include <unistd.h>

int main(int argc, char **argv, char **envp) {
	char *newargv[argc + 3];

	newargv[0] = argv[0];
	newargv[1] = "-cpu";
	newargv[2] = "cortex-a53";

	memcpy(&newargv[3], &argv[1], sizeof(*argv) * (argc -1));
	newargv[argc + 2] = NULL;
	return execve("/usr/local/bin/qemu-aarch64", newargv, envp);
}