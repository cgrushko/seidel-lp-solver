This is Mike Hohmeyer's C implementation of R. Seidel's algorithm for solving LPs
(linear programs.)

Relevant paper:
Seidel, R. (1991), "Small-dimensional linear programming and convex hulls made easy", Discrete & Computational Geometry 6 (1): 423–434, doi:10.1007/BF02574699

Originally Downloaded from:
http://www.cs.sunysb.edu/~algorith/implement/linprog/implement.shtml

This version on GitHub:
https://github.com/cgrushko/seidel-lp-solver

Original documentation
======================

if you make "do_lp" and "randp" you can run the
following test.

./randp 3 100 | ./do_lp

randp generates 100 random planes tangent to the hyperboloid
in 3 dimensions centered at the origin with z as an axis of
symmetry. Randp puts that on standard output. do_lp reads that and
feeds it to the routine linprog, which solves the problem.
If you look into do_lp.c you can observe how to call linprog.

Documentation is still rather sketchy so any questions can
be directed to hohmeyer@icemcfd.com

If you want to attempt to make this double precision, pay special
attention to the value EPS defined in tol.h which should be
the smallest number so that 1.0 + EPS  > 1.0
