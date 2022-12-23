export GODEBUG=asyncpreemptoff=1

init:
	terraform init

plan: init
	terraform plan

apply: init
	terraform apply

destroy: init
	terraform destroy

genimg:
	cat ./diagrams.py | docker run -i --rm -v $(PWD)/img:/out gtramontina/diagrams:0.21.1

.PHONY: init plan apply destroy genimg