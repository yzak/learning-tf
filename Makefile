export GODEBUG=asyncpreemptoff=1

genimg:
	cat ./diagrams.py | docker run -i --rm -v $(PWD)/img:/out gtramontina/diagrams:0.21.1

.PHONY: genimg