<h1 id="abstract">Abstract</h1>
<p>This report provides a beginners tutorial on many essential tools in the data science world. While teaching you about what these tools are for, their perks and downfalls, and best practices, I will use examples that came up throughout the actual production of this report.</p>
<p>We will cover some of the following topics: version control systems, local and remote repositories, markup languages, and file conversions.</p>
<h1 id="introduction">Introduction</h1>
<div class="figure">
<img src="~/Documents/stat159/stat159-fall2016-project1/images/stat159-logo.png" alt="Stat159-logo" />
<p class="caption">Stat159-logo</p>
</div>
<h2 id="motivation">Motivation</h2>
<p>In data science there is an abundance of tools at your disposal, which can be overwhelming for beginners. This paper is designed as a tutorial, created both by and for, some of these tools. It's purpose is to familiarize the reader with basic but essential tools to develop a reproducible and collaborative workflow.</p>
<h2 id="scope">Scope</h2>
<p>The scope of this paper will be how to use and work with Gnu Make, Git, GitHub, Pandoc, Markdown, and Vim. It's emphasis will be on what these tools are for, how to get started with them, and their use in a successful workflow. These tools will mostly help you to collaborate with others and more so to create reproducible reports and analysis. We will not spend covering more traditional topics such as statistics, data visualization, etc. Before beginning to do proper analysis of data first one needs to learn tools to help us re-run analysis with new data, understand file dependencies, and more. All of which will be covered in the following.</p>
<h2 id="goal">Goal</h2>
<p>At the end of this paper, the reader should be able to reproduce it completely on their own.</p>
<h1 id="discussion">Discussion</h1>
<h2 id="gnu-make-makefile">GNU Make &amp; Makefile</h2>
<h3 id="about-make-makefile-structure">About Make &amp; Makefile Structure</h3>
<p><a href="https://www.gnu.org/software/make/">GNU Make</a> is a tool which allows you to generate target files, outputs, from any number of dependent files, inputs, based on series of commands, rules. This is essential to this report because it enables it to be easily reproducible even when the input files may change overtime. To do this in Make, you must write a textfile referred to as a Makefile that contains rules on how to build your output files. A Makefile has the following structure:</p>
<pre class="make"><code>target: dependency 
    command</code></pre>
<h3 id="makefile-example">Makefile Example</h3>
<p>In this particular project, Makefile was useful for generating the paper as a whole from an abstract, introduction, discussion, and conclusion. Then converting that from Markdown to HTML using Pandoc (both Markdown and Pandoc will be discussed later on). This example is as follows:</p>
<pre class="make"><code>DIR = paper/sections/

all: paper.html paper.md 

paper.html: $(DIR)00-abstract.md $(DIR)01-introduction.md $(DIR)02-discussion.md $(DIR)03-conclusions.md
    cd paper/sections; pandoc *.md -s -o paper.html 
    cd paper/sections; mv paper.html ../../

paper.md: $(DIR)00-abstract.md $(DIR)01-introduction.md $(DIR)02-discussion.md $(DIR)03-conclusions.md
    cd paper/sections; pandoc *.md &gt; paper.md
    cd paper/sections; mv paper.md ../../</code></pre>
<p>Notice that tabs must be used for rules and a Makefile can contain multiple targets, dependencies and rules.</p>
<h3 id="using-makefile-to-reproduce-files">Using Makefile to Reproduce Files</h3>
<p>To use the Makefile once created, you should create a directory which contains the contents of all your dependent files and your Makefile. To continue the example from above, a directory to produce paper.md and paper.html would look as follows:</p>
<pre><code>make-paper/
    Makefile
    paper/
        00-abstract.md
        01-introduction.md
        02-discussion.md
        03-conclusions.md</code></pre>
<p>From the make-paper directory, containing all of your dependent files and the Makefile, simply use the command <code>make</code> to generate <code>paper.md</code> and <code>paper.html</code>. You will see the commands from your Makefile executed as well a the output files. Say you were to expand upon your abstract, you could run make again to update and reproduce your outputs.</p>
<p>There are several reasons a Makefile is important to the reproducible workflow. For example, yourself or a collaborator, wants to:</p>
<ul>
<li>Edit a dependent file, ie. correct a typo in the introduction and reproduce the reports</li>
<li>Keep track and document how one file was produced from another</li>
<li>Pass this report along to another person so they can work on it and reproduce it</li>
</ul>
<p>A helpful resource on topics such as rule syntax, multiple targets, parallel executions and more is the <a href="https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents">GNU Make Manual</a>.</p>
<h2 id="git-version-control">Git &amp; Version Control</h2>
<h3 id="about-git-and-setting-git-up">About Git and Setting Git Up</h3>
<div class="figure">
<img src="~/Documents/stat159/stat159-fall2016-project1/images/git-logo.png" alt="Git-logo" />
<p class="caption">Git-logo</p>
</div>
<p><a href="https://git-scm.com/">Git</a> is a version control software which enables you to track any changes you make to both files and directories. The importance of this tool is not just in its tracking ability, but its ability to provide an unlimited amount of undos and to allow multiple people to work on a project in parallel.</p>
<p>Setting up Git is simple enough, commands are written of the form <em>git verb</em>. To set up your account and access the Git manual which will provide you with more information about basic commands, you should run the following in your terminal.</p>
<pre><code>git config --global user.name &quot;Your Name&quot;
git config --global user.email &quot;Your Email&quot; 
git config --help
</code></pre>
<h3 id="initializing-a-git-repository">Initializing a Git Repository</h3>
<p>Git stores information in a repository, storing your changes to files there. For example, this report has a repository in the directory where all of the relevant files are stored. To create a repository for a project, we must use the <code>git init</code> command as follows:</p>
<pre><code>mkdir stat159-fall2016-project1
cd stat159-fall2016-project1
git init 
</code></pre>
<h3 id="tracking-changes-with-git">Tracking Changes With Git</h3>
<p>Once the repository is initialized you are now ready to track changes. Suppose that you wanted to include a .gitignore textfile (any files mentioned in .gitignore will not be ignored when tracking the repository) with your project and so you create one within your project directory.</p>
<pre><code>stat159-fall2016-project1/
    .gitignore</code></pre>
<p>A commmand you'll use often is <code>git status</code> in order to see which changes in your directory have or haven't been tracked in your repository. Now that we have a new file present in the directory that <em>has not</em> been tracked in the repository, we will see the following message when we run the command:</p>
<pre><code>nrethmeier-mbp13:stat159-fall2016-project1 nrethmeier$ git status
On branch master
Untracked files:
  (use &quot;git add &lt;file&gt;...&quot; to include in what will be committed)

    .gitignore

nothing added to commit but untracked files present (use &quot;git add&quot; to track)</code></pre>
<p>Git has recognized that you are not tracking the new .gitignore file in your repository for the project. In order to track this in our repository, we must first place it in the staging area. Only once the file has been added to the staging area can it be <em>committed</em> to the repository, meaning the changes have been documented there. Below is a table to describing where the file currently exists, and the commands to include it in the staging area and repository.</p>
<table>
<thead>
<tr class="header">
<th>Directory</th>
<th>Staging Area</th>
<th>Repository</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>.gitignore</td>
<td>git add .gitignore</td>
<td>git commit -m &quot;add .gitignore&quot;</td>
</tr>
</tbody>
</table>
<p>This file has now been added to the repository in its current state, think of it as a screenshot. However, as you continue to edit and change the file, you will need to take more screeshots following the above process. For example, suppose I add a file to .gitignore, then the next time I run <code>git status</code> it will tell me that .gitignore has been modified. In order to track these changes with Git we would run:</p>
<pre><code>git add .gitignore
git commit -m &quot;added file to .gitignore
</code></pre>
<p>The portion of the command <code>-m &quot;added file to .gitignore&quot;</code> is the message that you are submitting with your commit. It's best practice to always commit with a message so that you can tell what modifications were made in each snapshot. Now that you know how to commit changes to a repository, we will cover undoing those changes.</p>
<h3 id="undoing-changes-with-git">Undoing Changes With Git</h3>
<p>As you commit changes, you will notice that each commit gets a unique number to identify it with. At any point, if you run the <code>git log --oneline</code> command you can see a brief history of your commits for a project. You'll notice that each commit shows the first 7 digits of the 40 digit identifier and the message with which the commit was submitted. Below is an example of the commit history for this report.</p>
<pre><code>nrethmeier-mbp13:stat159-fall2016-project1 nrethmeier$ git log --oneline
1912900 updated to include Git discussion
88b6d24 updated outline in README.md
24a9e11 updated to include GNU Make manual
d12cc4c updated to include Makefile discussion
4992c3a updated introduction
17d6d15 add README.md
47a973f add paper and sections
264ec0c add images directory with logos
</code></pre>
<p>To view the differences between the different versions of your projects or files that have been committed, you can use the command <code>git diff</code> in two different ways. 1. <code>git diff HEAD~#</code> will show you the difference between your current version and # versions ago 2. <code>git diff #######</code> will show you the difference between your current version and the version associated with commit #######</p>
<p>Now, if you wanted to revert back to one of those versions instead of your current version, you would use <code>git checkout</code> instead. 1. <code>git checkout HEAD~# stat159-fall2016-project1</code> will revert back to your project # versions ago 2. <code>git checkout ####### stat159-fall2016-project1</code> will revert back to the version associated with commit #######</p>
<p>The easiest part of working with Git is the ability to go back as needed, while the challenge can be in knowing what to commit when. While working with this project I committed changes as I progressed section by section, which I found to be the best practice. A helpful resource when working with Git is this tutorial, <a href="http://swcarpentry.github.io/git-novice/">Version Control with Git</a>.</p>
<h2 id="github-remote-repositories">GitHub &amp; Remote Repositories</h2>
<div class="figure">
<img src="~/Documents/stat159/stat159-fall2016-project1/images/github-logo.png" alt="GitHub-logo" />
<p class="caption">GitHub-logo</p>
</div>
<p>In the above section we worked with local repositories, essentially meaning it exists on your device. In this section, we will introduce remote repositories.</p>
<p>[GitHub] (https://guides.github.com/activities/hello-world/) is a tool where you can host remote Git repositories on the web. Essentially, the changes you on your local repository can be pushed out to a repository on GitHub where they are then accessible online. Similarly, you can pull repositories from GitHub online and then begin to work on them in your local repository. This tool is essential to collaborating on projects and files, as it allows multiple people to work remotely on the same repository, pushing out their own changes and pulling in their collaborators changes as they go.</p>
<p>For starters, you'll want to sign up for a GitHub account. Once that's done, you'll need to add the remote repository to your local one. For example, this report's local repository exists within the <code>stat159-fall2016-project1</code> directory on my device. If I want to be able to sync this work with a web based repository, I'll first have to create a new repository on GitHub. Click the <code>+</code> in the top right corner, give your repository a name, and you'll be directed to a quick setup page providing you with a link, such as <a href="https://github.com/nikkirethyo/Stat159.git" class="uri">https://github.com/nikkirethyo/Stat159.git</a>. This is the address of your new remote repository that you'll want to associate with your local one. To do so, follow the below example:</p>
<pre><code>
#origin will be the name of the remote repository, it&#39;s best practice to name it origin
git remote add origin &quot;https://github.com/nikkirethyo/Stat159.git&quot;

#to then check that the remote repository has been added, you can view it by running 
git remote -v 

#which should give you the following output now 
origin  https://github.com/nikkirethyo/Stat159.git (fetch)
origin  https://github.com/nikkirethyo/Stat159.git (push)
</code></pre>
<p>Now that you've successfully added a remote repository, you can continue to work in your local one, pushing and pulling changes to and from your remote repository as needed.</p>
<p>To push out your most recent changes in your local repository:</p>
<pre><code>git push origin master </code></pre>
<p>To pull the most up to date remote repository to your local one:</p>
<pre><code>git pull origin master</code></pre>
<p>For example, once this report is complete, I will want to push out all my changes to the remote repository so that it is accessible by my professor for grading. It's best practice to always pull the most recent version from a remote repository before continuing to make changes. GitHub is an easy to use tool which you can leverage greatly, this <a href="https://education.github.com/git-cheat-sheet-education.pdf">cheatcheet</a> is a useful resource for all your basic GitHub needs.</p>
<h2 id="pandoc">Pandoc</h2>
<div class="figure">
<img src="~/Documents/stat159/stat159-fall2016-project1/images/pandoc-logo.png" alt="Pandoc-logo" />
<p class="caption">Pandoc-logo</p>
</div>
<p><a href="http://pandoc.org/">Pandoc</a> is a universal document converter, enabling you to convert from one markup language to the next. Although for this project we will just be using Pandoc on Markdown and HTML files, it's advantage lies in the wide range of languages it can seemlessly convert between.</p>
<p>We will go over two use cases that are relevant to this project: 1. Rendering multiple markdown files into one 2. Rendering a markdown file to an HTML file</p>
<h3 id="pandoc-examples">Pandoc Examples</h3>
<p>In order to merge our markdown sections into paper.md we can use the following command and then convert the markdown file to HTML we use the following:</p>
<pre><code>#merges markdown sections into one markdown file
pandoc *.md &gt; paper.md

#converts markdown file to html 
pandoc paper.md -s -o paper.html
</code></pre>
<p>The advantages of Pandoc also make Pandoc a challenge to work with - a wide variety of use cases makes it difficult to remember commands for them all. A helpful resource when working with Pandoc is the examples they have available of conversion scenarios, which can be found at <a href="http://pandoc.org/demos.html">Pandoc Demos</a>.</p>
<h2 id="markdown">Markdown</h2>
<div class="figure">
<img src="~/Documents/stat159/stat159-fall2016-project1/images/markdown-logo.png" alt="Markdown-logo" />
<p class="caption">Markdown-logo</p>
</div>
<p>Markdown is a lightweight markup language which allows you to add <em>style</em> anything you write using plaintext. This is important because it allows reproducibility and collaboration by providing a standard syntax to control document displays. For example, this whole report is written using Markdown.</p>
<p>Markdown is written in plaintext, meaning using only letters, characters, and symbols on your keyboard. You can <em>italicize</em> words or <strong>bold</strong> them, you can insert <a href="https://www.google.com/search?q=puppies&amp;espv=2&amp;biw=1280&amp;bih=612&amp;source=lnms&amp;tbm=isch&amp;sa=X&amp;ved=0ahUKEwioudCljLjPAhVY92MKHVgeDx0Q_AUIBigB">links</a> where needed, or insert <code>code</code>. Some examples used in this paper are below:</p>
<pre><code>
**how to make words bold**

*how to italicize words*

1. ordered 
2. lists 
    1. sublists 

* unordered 
* lists 
</code></pre>
<p>Markdown is very easy to use, which is why it is most people's preferred markup language, which makes it extremeley important for collaborating with others. It is rendered stylistically when converted to html, pdf, etc. through using tools such as Pandoc. This <a href="https://guides.github.com/features/mastering-markdown/">Mastering Markdown</a> guide on GitHub is a great resource for learning what you need to get started using Markdown.</p>
<h2 id="vim-text-editors">Vim &amp; Text Editors</h2>
<p>Vim is one of many text editors, and the one I used to create this project. A text editor is pretty self-explanatory, it is a system which allows you to edit plaintext files. All of the files in this project were created and edited using Vim.</p>
<h3 id="creating-a-new-file">Creating a New File</h3>
<p>Vim is my text editor of choice due to its simplicity, it is a WYSIWYG (What You See Is What You Get) type of system. In order to create a new text file you run the command <code>vi filename.ext</code> where <code>ext</code> would be the file extension, typically either <code>.txt</code>, <code>.md</code>, <code>.html</code>, etc. Once you run that command, you will leave the command line interface and will be brought to your blank file.</p>
<h3 id="editing-your-file">Editing Your File</h3>
<p>Once you are brought to your file, you will need to switch to <em>Insert Mode</em> to start editing. To do this simply hit <code>i</code> and enter. You can now begin to type into your new file. When you are finished editing the file, you will need to enter back into <em>Normal Mode</em>. To do this simply press <code>esc</code> button. Now that you have exited insert mode, you can save your file by type <code>:wq</code> and pressing enter again.</p>
<p>If you ever want to edit your file again, which is bound to happen many times, run the command <code>vi filename.ext</code> again. Since the file already exists, it will not create a new one but return you to your current one. Switch back to insert mode and you can continue editing from where you left off.</p>
<p>Vim is another easy to use tool, but if you want to practice, this interactive <a href="http://www.openvim.com/">tutorial</a> is very helpful.</p>
<h1 id="conclusions">Conclusions</h1>
<p>Now that we are familiar with these various tools, we can successfully recreate this report if needed. You now understand the importance of version control, remote repositories, reproducible reports, markup languages, text editors, and file conversions. In conclusion, I'll leave you with some final advice on how to approach projects and what to do when you become stuck.</p>
<p>When tackling a project such as this one, the challenge can be in figuring out where to start. It's best practice to have an idea of what the organizational structure will be before jumping in. For example, this project was organized as follows:</p>
<pre><code>stat159-fall2016-project1/
    .gitignore
    README.md
    Makefile
    paper/
        sections/
            00-abstract.md
            01-introduction.md
            02-discussion.md
            03-conclusions.md
        paper.md
        paper.html
    images/
        git-logo.png
        github-logo.png
        markdown-logo.png
        pandoc-logo.png
        stat159-logo.png
</code></pre>
<p>Once you have this in mind, you can start from bare bones. For example, I created placeholder files to begin with, and added to them as I went. What makes it easier is thinking of each file as a product of other files. The paper.md file is a product of 00-abstract.md, 01-introduction.md, 02-discussion.md, and 03-conclusions.md. Whereas the paper.html file is a product of paper.md. Understanding this flow will help you get an idea of where to start.</p>
<p>Another easy part is learning the tools needed to create reproducible and collaborative projects. There is an abundance of online resources for the tools discussed in this project, many of which I've included throughout our discussion. For example, when I was stuck on constructing multiple targets in the Makefile, I easily found many tutorials and answers to help.</p>
<p>Ultimately, the main takeaway for is to think about the bigger picture before getting down into the details and take advantage of the many resources available for help.</p>
