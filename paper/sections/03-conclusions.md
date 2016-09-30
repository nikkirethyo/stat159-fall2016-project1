#Conclusions

Now that we are familiar with these various tools, we can successfully recreate this report if needed. You now understand the importance of version control, remote repositories, reproducible reports, markup languages, text editors, and file conversions. In conclusion, I'll leave you with some final advice on how to approach projects and what to do when you become stuck.  

When tackling a project such as this one, the challenge can be in figuring out where to start. It's best practice to have an idea of what the organizational structure will be before jumping in. For example, this project was organized as follows: 

```
stat159-fall2016-project1/
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

```

Once you have this in mind, you can start from bare bones. For example, I created placeholder files to begin with, and added to them as I went. What makes it easier is thinking of each file as a product of other files. The paper.md file is a product of 00-abstract.md, 01-introduction.md, 02-discussion.md, and 03-conclusions.md. Whereas the paper.html file is a product of paper.md. Understanding this flow will help you get an idea of where to start. 

Another easy part is learning the tools needed to create reproducible and collaborative projects. There is an abundance of online resources for the tools discussed in this project, many of which I've included throughout our discussion. For example, when I was stuck on constructing multiple targets in the Makefile, I easily found many tutorials and answers to help. 

Ultimately, the main takeaway for is to think about the bigger picture before getting down into the details and take advantage of the many resources available for help. 

