paper.md: 00-abstract.md 01-introduction.md 02-discussion.md 03-conclusions.md
	pandoc *.md > paper.md

paper.html: paper.md 
	pandoc paper.md -s -o paper.html
