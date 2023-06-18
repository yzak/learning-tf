export GODEBUG=asyncpreemptoff=1

init:
	terraform init --upgrade

plan: init
	terraform plan

apply: init
	terraform apply -auto-approve

destroy: init
	terraform destroy -auto-approve

.PHONY: init plan apply destroy