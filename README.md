# Assembly

Here are my programs following along with 'The Art of Assembly Language 2nd
edition'.

I quickly ran into an issue as HLA is provided as a 32-bit executable/library.
While I tried to use 64-bit assembler and linker, I ran into the problem of
32/64 bit incompatibility with the standard library basically every time.
Additionally, attempting to build from source faced me with another problem as
it seemed there was some kind of circular dependency. hlaparse required hlalib,
and hlalib required hlaparse. I didn't have the time to really try to fix this
issue, so a little google searching lead me to the following blog post:
http://hypervion.blogspot.com/2013/12/hla-issues-when-linking-with-ld-binary.html
Instructing the right way to fix this issue.

It turns out that the hla program can be passed linker options which we must do
in our case as the linker must link in 32bit compatibility mode. The procedure
is to move the typical hla program to \_hla then write a bash script to check
whether we are in 64 bit mode, and if so pass the appropriate flag to the
linker. This works great and I've added the script in this directory to
preserve it.
