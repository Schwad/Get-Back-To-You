Get-Back-To-You
===============

A quick, slick, phone call and email manager to save your life when you have a full inbox and voicemail.


*Run corefile.rb*


The standard way to do a command sets type, content and priority.Such as 'call jeff smith before thursday 2'.

1 is the highest priority and down from there. 

Other commands include 'ls all', 'ls call', 'ls email', and exit.

You may also call 'taskno' to see the number of tasks.

You may backup your data file, completed file, or deleted files with 'backup data' or 'backup completed' or 'backup removed'.

 If you have an issue with this program you can report it at https://github.com/Schwad

 **Outstanding issues**

 1. Need to create a separate .txt file to store an integer to be used to generate new ID numbers for each task. Currently the supposed "id number" is just the rows' length. 

 2. Need to identify tasks for completion or removal based on that ID number, currently at row number. 

 3. Obligatory code cleanup and refining.

 4. More robust use of the priority system and possible ranking and ordering. Maybe convert to array and sort by [-1]?

 5. Display "completed"