#Discussion

1. **GNU Make & Makefile** 

###About Make & Makefile Structure

[GNU Make](https://www.gnu.org/software/make/) is a tool which allows you to generate target files, outputs, from any number of dependent files, inputs, based on series of commands, rules. This is essential to this report because it enables it to be easily reproducible even when the input files may change overtime. To do this in Make, you must write a textfile referred to as a Makefile that contains rules on how to build your output files. A Makefile has the following structure: 

```make
target: dependency 
	command
```
###Makefile Example

In this particular project, Makefile was useful for generating the paper as a whole from an abstract, introduction, discussion, and conclusion. Then converting that from Markdown to HTML using Pandoc (both Markdown and Pandoc will be discussed later on). This example is as follows: 

```make
paper.md: 00-abstract.md 01-introduction.md 02-discussion.md 03-conclusions.md
	pandoc *.md > paper.md

paper.html: paper.md 
	pandoc paper.md -s -o paper.html
```

Notice that tabs must be used for rules and a Makefile can contain multiple targets, dependencies and rules.   

###Using Makefile to Reproduce Files 

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

2. **Git & Version Control** 

###About Git and Setting Git Up 

![Git-logo](~/Documents/stat159/stat159-fall2016-project1/images/git-logo.png) 

[Git](https://git-scm.com/) is a version control software which enables you to track any changes you make to both files and directories. The importance of this tool is not just in its tracking ability, but its ability to provide an unlimited amount of undos and to allow multiple people to work on a project in parallel.

Setting up Git is simple enough, commands are written of the form *git verb*. To set up your account and access the Git manual which will provide you with more information about basic commands, you should run the following in your terminal. 

```
git config --global user.name "Your Name"
git config --global user.email "Your Email" 
git config --help

```

###Initializing a Git Repository

Git stores information in a repository, storing your changes to files there. For example, this report has a repository in the directory where all of the relevant files are stored. To create a repository for a project, we must use the `git init` command as follows: 

```
mkdir stat159-fall2016-project1
cd stat159-fall2016-project1
git init 

```

###Tracking Changes With Git

Once the repository is initialized you are now ready to track changes. Suppose that you wanted to include a .gitignore textfile (any files mentioned in .gitignore will not be ignored when tracking the repository)  with your project and so you create one within your project directory. 

```
stat159-fall2016-project1/
    .gitignore
``` 

A commmand you'll use often is `git status` in order to see which changes in your directory have or haven't been tracked in your repository. Now that we have a new file present in the directory that *has not* been tracked in the repository, we will see the following message when we run the command: 

```
nrethmeier-mbp13:stat159-fall2016-project1 nrethmeier$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore

nothing added to commit but untracked files present (use "git add" to track)
```

Git has recognized that you are not tracking the new .gitignore file in your repository for the project. In order to track this in our repository, we must first place it in the staging area. Only once the file has been added to the staging area can it be *committed* to the repository, meaning the changes have been documented there. Below is a table to describing where the file currently exists, and the commands to include it in the staging area and repository. 


Directory  | Staging Area      | Repository 
-----------|-------------------|-----------
.gitignore |git add .gitignore | git commit -m "add .gitignore" 

This file has now been added to the repository in its current state, think of it as a screenshot. However, as you continue to edit and change the file, you will need to take more screeshots following the above process. For example, suppose I add a file to .gitignore, then the next time I run `git status` it will tell me that .gitignore has been modified. In order to track these changes with Git we would run: 

```
git add .gitignore
git commit -m "added file to .gitignore

```

The portion of the command `-m "added file to .gitignore"` is the message that you are submitting with your commit. It's best practice to always commit with a message so that you can tell what modifications were made in each snapshot. Now that you know how to commit changes to a repository, we will cover undoing those changes. 

###Undoing Changes With Git

As you commit changes, you will notice that each commit gets a unique number to identify it with. At any point, if you run the `git log --oneline` command you can see a brief history of your commits for a project. You'll notice that each commit shows the first 7 digits of the 40 digit identifier and the message with which the commit was submitted. Below is an example of the commit history for this report. 

```
nrethmeier-mbp13:stat159-fall2016-project1 nrethmeier$ git log --oneline
1912900 updated to include Git discussion
88b6d24 updated outline in README.md
24a9e11 updated to include GNU Make manual
d12cc4c updated to include Makefile discussion
4992c3a updated introduction
17d6d15 add README.md
47a973f add paper and sections
264ec0c add images directory with logos

``` 

To view the differences between the different versions of your projects or files that have been committed, you can use the command `git diff` in two different ways.
1. `git diff HEAD~#` will show you the difference between your current version and # versions ago 
2. `git diff #######` will show you the difference between your current version and the version associated with commit #######

Now, if you wanted to revert back to one of those versions instead of your current version, you would use `git checkout` instead. 
1. `git checkout HEAD~# stat159-fall2016-project1` will revert back to your project # versions ago 
2. `git checkout ####### stat159-fall2016-project1` will revert back to the version associated with commit #######

The easiest part of working with Git is the ability to go back as needed, while the challenge can be in knowing what to commit when. While working with this project I committed changes as I progressed section by section, which I found to be the best practice. A helpful resource when working with Git is this tutorial, [Version Control with Git](http://swcarpentry.github.io/git-novice/). 


3. **GitHub & Remote Repositories**

![GitHub-logo](~/Documents/stat159/stat159-fall2016-project1/images/github-logo.png) 

In the above section we worked with local repositories, essentially meaning it exists on your device. In this section, we will introduce remote repositories. 

[GitHub] (https://guides.github.com/activities/hello-world/) is a tool where you can host remote Git repositories on the web. Essentially, the changes you on your local repository can be pushed out to a repository on GitHub where they are then accessible online. Similarly, you can pull repositories from GitHub online and then begin to work on them in your local repository. This tool is essential to collaborating on projects and files, as it allows multiple people to work remotely on the same repository, pushing out their own changes and pulling in their collaborators changes as they go. 

For starters, you'll want to sign up for a GitHub account. Once that's done, you'll need to add the remote repository to your local one. For example, this report's local repository exists within the `stat159-fall2016-project1` directory on my device. If I want to be able to sync this work with a web based repository, I'll first have to create a new repository on GitHub. Click the `+` in the top right corner, give your repository a name, and you'll be directed to a quick setup page providing you with a link, such as [https://github.com/nikkirethyo/Stat159.git](https://github.com/nikkirethyo/Stat159.git). This is the address of your new remote repository that you'll want to associate with your local one. To do so, follow the below example: 

```

#origin will be the name of the remote repository, it's best practice to name it origin
git remote add origin "https://github.com/nikkirethyo/Stat159.git"

#to then check that the remote repository has been added, you can view it by running 
git remote -v 

#which should give you the following output now 
origin	https://github.com/nikkirethyo/Stat159.git (fetch)
origin	https://github.com/nikkirethyo/Stat159.git (push)

```   

Now that you've successfully added a remote repository, you can continue to work in your local one, pushing and pulling changes to and from your remote repository as needed. 

To push out your most recent changes in your local repository: 
```
git push origin master 
```
To pull the most up to date remote repository to your local one:
```
git pull origin master
```

For example, once this report is complete, I will want to push out all my changes to the remote repository so that it is accessible by my professor for grading. It's best practice to always pull the most recent version from a remote repository before continuing to make changes. GitHub is an easy to use tool which you can leverage greatly, this [cheatcheet](https://education.github.com/git-cheat-sheet-education.pdf) is a useful resource for all your basic GitHub needs. 

4. Pandoc 

![Pandoc-logo](~/Documents/stat159/stat159-fall2016-project1/images/pandoc-logo.png) 

[Pandoc](http://pandoc.org/) is a universal document converter, enabling you to convert from one markup language to the next. Although for this project we will just be using Pandoc on Markdown and HTML files, it's advantage lies in the wide range of languages it can seemlessly convert between. 

We will go over two use cases that are relevant to this project: 
1. Rendering multiple markdown files into one 
2. Rendering a markdown file to an HTML file 

###Pandoc Examples

In order to merge our markdown sections into paper.md we can use the following command and then convert the markdown file to HTML we use the following: 

```
#merges markdown sections into one markdown file
pandoc *.md > paper.md

#converts markdown file to html 
pandoc paper.md -s -o paper.html

```  

The advantages of Pandoc also make Pandoc a challenge to work with - a wide variety of use cases makes it difficult to remember commands for them all. A helpful resource when working with Pandoc is the examples they have available of conversion scenarios, which can be found at [Pandoc Demos](http://pandoc.org/demos.html). 


5. **Markdown**

![Markdown-logo](~/Documents/stat159/stat159-fall2016-project1/images/markdown-logo.png) 

Markdown is a lightweight markup language which allows you to add *style* anything you write using plaintext. This is important because it allows reproducibility and collaboration by providing a standard syntax to control document displays. For example, this whole report is written using Markdown. 

Markdown is written in plaintext, meaning using only letters, characters, and symbols on your keyboard. You can *italicize* words or **bold** them, you can insert [links](https://www.google.com/search?q=puppies&espv=2&biw=1280&bih=612&source=lnms&tbm=isch&sa=X&ved=0ahUKEwioudCljLjPAhVY92MKHVgeDx0Q_AUIBigB) where needed, or insert `code`. Some examples used in this paper are below: 

```

**how to make words bold**

*how to italicize words*

1. ordered 
2. lists 
    1. sublists 

* unordered 
* lists 

```

Markdown is very easy to use, which is why it is most people's preferred markup language, which makes it extremeley important for collaborating with others. It is rendered stylistically when converted to html, pdf, etc. through using tools such as Pandoc. This [Mastering Markdown](https://guides.github.com/features/mastering-markdown/) guide on GitHub is a great resource for learning what you need to get started using Markdown. 

6. **Vim & Text Editors** 

Vim is one of many text editors, and the one I used to create this project. A text editor is pretty self-explanatory, it is a system which allows you to edit plaintext files. All of the files in this project were created and edited using Vim. 
