#Discussion

1. **GNU Make & Makefile** 

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

To use the Makefile once created, you should create a directory which contains the contents of all your dependent files and your Makefile. To continue the example from above, a directory to produce paper.md and paper.html would look as follows: 

```
make-paper/
    Makefile
    paper/
        00-abstract.md
        01-introduction.md
        02-discussion.md
        03-conclusions.md
```

From the make-paper directory, containing all of your dependent files and the Makefile, simply use the command `make` to generate `paper.md` and `paper.html`. You will see the commands from your Makefile executed as well a the output files. Say you were to expand upon your abstract, you could run make again to update and reproduce your outputs. 

There are several reasons a Makefile is important to the reproducible workflow. For example, yourself or a collaborator, wants to: 

* Edit a dependent file, ie. correct a typo in the introduction and reproduce the reports
* Keep track and document how one file was produced from another 
* Pass this report along to another person so they can work on it and reproduce it 


A helpful resource on topics such as rule syntax, multiple targets, parallel executions and more is the [GNU Make Manual](https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents).

2. **Git** 

![Git-logo](~/Documents/stat159/stat159-fall2016-project1/images/git-logo.png) 

[Git](https://git-scm.com/) is a version control software which enables you to track any changes you make to both files and directories. The importance of this tool is not just in its tracking ability, but its ability to provide an unlimited amount of undos and to allow multiple people to work on a project in parallel.

Setting up Git is simple enough, commands are written of the form *git verb*. To set up your account and access the Git manual which will provide you with more information about basic commands, you should run the following in your terminal. 

```
git config --global user.name "Your Name"
git config --global user.email "Your Email" 
git config --help

```

Git stores information in a repository, storing your changes to files there. For example, this report has a repository in the directory where all of the relevant files are stored. To create a repository for a project, we must use the `git init` command as follows: 

```
mkdir stat159-fall2016-project1
cd stat159-fall2016-project1
git init 

```

Once the repository is initialized you are now ready to track changes. Suppose that you wanted to include a .gitignore textfile with your project and so you create one within your project directory. 

```
stat159-fall2016-project1/
    .gitignore
``` 

A commmand you'll use often is `git status` in order to see which changes in your directory have or haven't been tracked in your repository. Now that we have a new file present in the directory that *has not* been tracked in the repository, we will see the following message. 
