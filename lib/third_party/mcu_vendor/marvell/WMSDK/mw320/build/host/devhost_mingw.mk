# Copyright (C) 2008-2017, Marvell International Ltd.
# All Rights Reserved.

os_dir := Windows
file_ext := .exe

t_mconf := mconf_not_on_mingw
mconf_not_on_mingw:
	@echo ""
	@echo "The 'menuconfig' option is not supported in MinGW"
	@echo "Please use 'make config' instead"
	@echo ""
	@false

# Function to resolve input path
define b-abspath
$(join $(filter %:,$(subst :,: ,$(1))),$(abspath $(filter-out %:,$(subst :,: ,$(subst \,/,$(1))))))
endef

# This is used to replace ":" in drive letter
# This will be handy in resolving issues in rules/targets
escape_dir_name := _wmdrive

# Alphabet to be escaped
escape_let := :

# List of  Drive letters
drive-list-y := c d e f C D E F

t_bin_path := sdk/tools/bin/GnuWin32/bin


# Check if both arguments has same arguments. Result is empty string if equal.
arg-check = $(strip $(filter-out $(1),$(subst ",\",$(cmd_$(subst $(escape_let),$(escape_dir_name),$@)))) \
                    $(filter-out $(subst ",\",$(cmd_$(subst $(escape_let),$(escape_dir_name),$@))),$(1)))

# execute command and store the command line in $@.cmd file
cmd_save = @$(t_printf) "cmd_$(subst $(escape_let),$(escape_dir_name),$@) := %s\n" "$(1)" > $@.cmd
