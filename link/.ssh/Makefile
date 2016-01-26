.PHONY: ~/.ssh/conf.d/*.conf $(HOME)/.ssh/config

# Generate configs used by SSH_config_file_management (search opswiki)
all: $(HOME)/.ssh/config

SHELL=/bin/bash

# TODO this should be set by an environment variable
TEMPLATE_DIR=$(HOME)/work/code/svn/ops/sysadmin/ssh_config_template

# if you want the wildcard entry, put it in ~/.ssh/conf.d/zzz_custom

$(HOME)/.ssh/config: /tmp/ssh-config
	@diff --brief "$(PWD)/config" "$@" >&/dev/null && { \
		echo "No changes"; \
	} || { \
		cp "/tmp/ssh-config" "$@"; \
		chmod 600 "$@"; \
		echo "Installed new config to $@"; \
	}
	@rm /tmp/ssh-config

/tmp/ssh-config: $(TEMPLATE_DIR)/conf.d/*.conf ~/.ssh/conf.d/*.conf
	@svn up $(TEMPLATE_DIR)
	@svn_configs=($(TEMPLATE_DIR)/conf.d/*.conf); \
	personal_configs=(~/.ssh/conf.d/*.conf); \
	all_configs=$$( (IFS=$$'\n'; echo "$${svn_configs[*]}$${IFS}$${personal_configs[*]}") | awk -F'/' '{print $$NF, $$0}' | sort | awk '{print $$NF}' ); \
	echo "$$all_configs" | while read file; do \
		[[ -f $$file ]] || continue; \
		echo "# $$file"; \
		grep -v "^# vim"':' "$$file"; \
	done > $@

# Add target to generate from svn
