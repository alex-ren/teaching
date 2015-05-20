.. Last Modified: 05/19/2015

**********************
Lab Session 1
**********************



Usage of Git
================================

Git is a free and open source distributed version control system designed to handle 
everything from small to very large projects with speed and efficiency. In this class
we use Git to distribute course materials, assignments, projects. Grading is also
based on the usage of Git. You can find various information (documentation, tutorial,
and etc) about Git from its website http://git-scm.com/ as well as many other
sources available online. However, we only need a very small set of Git commands,
which will be illustrated later in this page.

Bitbucket
======================

Bitbucket https://bitbucket.org provides online Git repository as well as related
management facilities. After getting a free account on Bitbucket, you can create
private repository holding your work for this class.

Create repository for this class
------------------------------------

Use the webpage of Bitbucket to create a new repository. Make sure that the new repository
has the name CS320-Summer-2015 and keep all the other settings by default.

Record the name of your new repository. For example, mine is 
``https://alex2ren@bitbucket.org/alex2ren/cs320-summer-2015.git``


Cloud9
=================

Cloud9 provides a full Ubuntu workspace in the cloud as well as online code editors. 
Simply put, it provides a virtual machine which can be accessed via web browser. Just
imagine that you can access csa2.bu.edu via a web browser instead of a Telnet/SSH client
(e.g. PuTTy). What's even better is that you are provided with text editors to edit files.

Create a new workspace on Cloud9 for this class. Open a terminal in the newly created
workspace and execute the following commands to install ATS2 in this workspace.

.. code-block:: bash

    # download the script for installing ATS2 into your workspace
    wget https://gist.githubusercontent.com/githwxi/7e31f4fd4df92125b73c/raw/ATS2-C9-install.sh
    # execute the script
    sh ./ATS2-C9-install.sh

Execute the following commands to set up the Git repository for tracking your code.

.. code-block:: bash

    mkdir cs320-summer-2015
    cd cs320-summer-2015
    git init # initialize the repository
    # add your own repository on Bitbucket with name mybitbucket
    git remote add mybitbucket https://alex2ren@bitbucket.org/alex2ren/cs320-summer-2015.git 
    # add the repository for this course with name origin
    git remote add origin http://bithwxi@bitbucket.org/bithwxi/cs320-summer-2015.git
    # get all the resources released so far
    git fetch origin
    git merge origin/master
    # push everything to your own repository on Bitbucket.
    git push -u mybitbucket --all # pushes up the repo and its refs for the first time

Now you can work on assignment00. You can share your workspace with others by inviting
them into your workspace by clicking *share*. My C9 id is *alex2ren*.

After finish your coding, try the following command:

.. code-block:: bash

    cd cs320-summer-2015
    git status

Git would remind you which files have been modified. The following is an example:

    On branch master
    Your branch is up-to-date with 'mybitbucket/master'.
    
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)
    
            modified:   assignments/00/assign00_sol.dats
    
    Untracked files:
      (use "git add <file>..." to include in what will be committed)
    
            assignments/00/assign00_sol
            assignments/00/assign00_sol_dats.c
    
    no changes added to commit (use "git add" and/or "git commit -a")
    
Use the following command to stage your modification.

.. code-block:: bash

    git add assignments/00/assign00_sol.dats

Use the following command to commit your modification.

.. code-block:: bash

    git commit -m "This is my first try of ATS."

Try the following command to check the history of your commit.

.. code-block:: bash

    git log

Use the following command to push your commit onto your own repository on Bitbucket.

.. code-block:: bash

    git push mybitbucket master 

Now you can go to Bitbucket and share your repository with us for grading.

In the future, you can use the following commands on Cloud9 to get the newest
materials of the class.

.. code-block:: bash

    cd cs320-summer-2015 # get into the directory for the repository
    git fetch origin
    git merge origin/master

.. warning:: For each assignment, some files contain incomplete code left for you to
    finish. You can edit these files and creating new files. Do not edit other files.
    The following command can help undo your modification to an existing file.
    
    .. code-block:: bash

        git checkout -- <file>  # replace <file> with the path of the file

csa2.bu.edu
=====================

ATS has been installed on csa2.bu.edu. To use it, you need to import the required
environment. If you use *bash*, you can use the following command.

.. code-block:: bash

  source /cs/coursedata/cs320/environment

The Git related command used on Cloud9 can also be used on csa2. Assume you wrote some
code on Cloud9, and succeeded in pushing it onto your repository on Bitbucket, you can
use the following command to pull such update into the repository created on csa2.

.. code-block:: bash

  cd cs320-summer-2015 # assume you already created such repository on csa2.bu.edu
  git fetch mybitbucket
  git merge mybitbucket/master







