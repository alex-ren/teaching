.. Last Modified: 05/27/2015

**********************
Lab Session 2
**********************



Usage of Git: Merge and Resovle Conflict
================================================

You can find useful information here on `Git's website 
<https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging>`_. We shall 
also discuss about this in the session.

Use the following commands to create a conflict in Git repository.

.. code-block:: bash

    $ mkdir repoA
    $ mkdir repoB
    $ cd repoA
    $ git init
    Initialized empty Git repository in /home/grad2/aren/teach/website/temprepos/repoA/.git/
    $ cat > a.txt
    Hello World AAA!
    $ git add a.txt
    $ git commit -m "first commit of A"
    [master (root-commit) 0a7b425] first commit of A
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 a.txt
    $ git status
    # On branch master
    nothing to commit (working directory clean)
    $ cd ../repoB
    $ git init
    Initialized empty Git repository in /home/grad2/aren/teach/website/temprepos/repoB/.git/
    $ git remote add repoA ../repoA
    $ git fetch repoA 
    remote: Counting objects: 3, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects:  33% (1/3)   
    Unpacking objects:  66% (2/3)   
    Unpacking objects: 100% (3/3)   
    Unpacking objects: 100% (3/3), done.
    From ../repoA
     * [new branch]      master     -> repoA/master
    $ git merge repoA/master 
    $ ls
    a.txt
    $ cat > a.txt
    Hello World BBB!
    $ git add a.txt
    $ git commit -m "update of B"
    [master bec83e3] update of B
     1 files changed, 1 insertions(+), 1 deletions(-)
    $ cd ../repoA
    $ cat >> a.txt 
    Hello World CCC!
    $ git add a.txt
    $ git commit -m "second update of A"
    [master 21e0ea4] second update of A
     1 files changed, 1 insertions(+), 0 deletions(-)
    $ cd ../repoB
    $ git fetch repoA 
    remote: Counting objects: 5, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects:  33% (1/3)   
    Unpacking objects:  66% (2/3)   
    Unpacking objects: 100% (3/3)   
    Unpacking objects: 100% (3/3), done.
    From ../repoA
       0a7b425..21e0ea4  master     -> repoA/master
    $ git merge repoA/master 
    Auto-merging a.txt
    CONFLICT (content): Merge conflict in a.txt
    Automatic merge failed; fix conflicts and then commit the result.
    $ git status
    # On branch master
    # Unmerged paths:
    #   (use "git add/rm <file>..." as appropriate to mark resolution)
    #
    #	both modified:      a.txt
    #
    no changes added to commit (use "git add" and/or "git commit -a")
    $ cat a.txt
    <<<<<<< HEAD
    Hello World BBB!
    =======
    Hello World AAA!
    Hello World CCC!
    >>>>>>> repoA/master
    $ cat > a.txt
    Hello World !!!
    $ git add a.txt
    $ git commit 


Slides of the session
======================


:download:`lecture.pdf <./lecture.pdf>`.

Review of Assignment 01

.. code-block:: text

    (*
    // Please implement [show_triangle] as follows:
    // show_triangle (3) outputs
    //    *
    //   ***
    //  *****
    // 
    // show_triangle (5) outputs
    //      *
    //     ***
    //    *****
    //   *******
    //  *********
    *)
    
    (*
    ** HX: 10 points
    *)
    extern
    fun show_triangle (level: int): void
    
    implement
    show_triangle (level) = let
      fun printn (c: char, n: int): void = 
        if n > 0 then let
          val () = print c
        in
          printn (c, n - 1)
        end
        else ()
    
      fun print_lines (cur: int, total: int): void =
        if cur >= total then ()
        else let
          val n_blank = 1 + total - cur
          val n_star = 2 * cur + 1
          val () = printn (' ', n_blank)
          val () = printn ('*', n_star)
          val () = print ("\n")
        in
          print_lines (cur + 1, total)
        end
    in
      print_lines (0, level)
    end
    





