DIR = paper/sections/

all: paper.html paper.md 

paper.html: $(DIR)00-abstract.md $(DIR)01-introduction.md $(DIR)02-discussion.md $(DIR)03-conclusions.md
	cd paper/sections; pandoc *.md -s -o paper.html 
	cd paper/sections; mv paper.html ../../

paper.md: $(DIR)00-abstract.md $(DIR)01-introduction.md $(DIR)02-discussion.md $(DIR)03-conclusions.md
	cd paper/sections; pandoc *.md > paper.md
	cd paper/sections; mv paper.md ../../

