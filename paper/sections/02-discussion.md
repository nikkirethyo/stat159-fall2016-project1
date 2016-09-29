#Discussion

1. *GNU Make & Makefile* 

[GNU Make](https://www.gnu.org/software/make/) is a tool which allows you to generate target files, outputs, from any number of dependent files, inputs, based on series of commands, rules. This is essential to this report because it enables it to be easily reproducible even when the input files may change overtime. To do this in Make, you must write a textfile referred to as a Makefile that contains rules on how to build your output files. A Makefile has the following structure: 

```make
target: dependency 
	command
```

In this particular project, Makefile was useful for generating the paper as a whole from an abstract, introduction, discussion, and conclusion. Then converting that from Markdown to HTML using Pandoc (both Markdown and Pandoc will be discussed later on). This example is as follows: 

```make
paper.md: 00-abstract.md 01-introduction.md 02-discussion.md 03-conclusions.md
	pandoc *.md > paper.md

paper.html: paper.md 
	pandoc paper.md -s -o paper.html
```

Notice that tabs must be used for rules and a Makefile can contain multiple targets, dependencies and rules.   


There are several reasons a Makefile is important to the reproducible workflow. For example, yourself or a collaborator, wants to: 

* Edit a dependent file, ie. correct a typo in the introduction and reproduce the reports
* Keep track and document how one file was produced from another 
* Pass this report along to another person so they can work on it and reproduce it 

 
