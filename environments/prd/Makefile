export GODEBUG=asyncpreemptoff=1

init:
	terraform init

plan: init
	terraform plan

apply: init
	terraform apply -auto-approve

destroy: init
	terraform destroy -auto-approve

genimg:
	cat ./diagrams.py | docker run -i --rm -v $(PWD)/img:/out gtramontina/diagrams:0.21.1

.PHONY: init plan apply destroy genimg