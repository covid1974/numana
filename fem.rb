<NOTE>
@{
<M>
\newcommand{\bc}{{\bf c}}
\newcommand{\bz}{{\bf 0}}
</M>
<HEAD1>Soap film project</HEAD1>
Consider a frame like the following dipped in a soap solution.
<CIMG web="soap1.png">Frame</CIMG>
When you take it out of the solution, a thin film of soap water
will cling to it:
<CIMG web="soap2.png">Soap film</CIMG>
We want to find the shape of the film. This is an important
quetion in architecture, where a structure must be given the most
natural shape to reduce stress. 
<P/>
It is known that a soap film will always occupy the position that
minimises its elastic potential energy. In the next section we
shall see how to express this mathematically.

<HEAD2>Coordinate system</HEAD2>
We imagine an <M>xy</M>-plane under the frame:
<CIMG web="soap3.png">Coordinate system</CIMG>
If the surface is given by a function <M>u(x,y),</M> then its
elastic potential energy is given by
<D>
E(u) = \iint_R (u_x)^2 + (u_y)^2\, dxdy.
</D>
This is to be minimised subject to the boundary condition that
the <M>u(x,y)</M> must match the frame height at the boundary.
<P/>
In general, this is a difficult/impossible problem to solve
analytically. 

<HEAD2>Numerical solution</HEAD2>
To proceed numerically, one starts with a
triangulation of the base. 
<CIMG web="basis0.png">Triangulation</CIMG>
Then the aim is to find the value of <M>u(x,y)</M> at the
vertices. Let <M>c_j</M> denote the value of <M>u(x,y)</M> at the
<M>j</M>-th vertex. 
<P/>
Since the target function involves <M>u_x</M>
and <M>u_y</M>, we need to somehow approximate them using only
the values at the vertices. For this we choose a set of <B>basis
function</B>s, one for each vertex. It is constructed by "pulling
up" the vertex to a height 1, while leaving all the other
vertices at height 0. Here is one example where the vertex is not
a boundary vertex:
<CIMG web="basis1.png">A basis function</CIMG>
Here is another example, this time for a boundary vertex.
<CIMG web="basis2.png">Another basis function</CIMG>
Notice that the graph of each basis function is a plane over over
each triangle, and hence we may write a basis
function <M>\phi_j(x,y)</M> as
<D>
\phi_j(x,y) = \alpha_{ij} + \beta_{ij}x + \gamma_{ij} y \mbox{
for } (x,y)\in T_i.
</D>
for suitable numbers <M>\alpha_{ij},</M> <M>\beta_{ij}</M>
and <M>\gamma_{ij}</M>. Here <M>T_i</M>'s are the triangles of
the triangulation. Also, notice that <M>\alpha_{ij}, \beta_{ij},
\gamma_{ij}</M>'s are zero if the <M>j</M>-th vertex is not part
of <M>T_i</M>. Thus, most of these numbers are actually zero.

<P/>
Then we can approximate <M>u(x,y)</M> by 
<D>
u(x,y) = \sum_j c_j \phi_j(x,y).
</D>
So 
<D>
u_x(x,y) = \sum_j c_j\beta_{ij} \mbox{ for } (x,y)\in T_i^\circ.
</D>
Similarly for <M>u_y(x,y).</M>
<P/>
<D>
E(u) = \sum_i \iint_{T_i} (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 
  = \sum_i |T_i| \{ (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 \},
</D>
where <M>|T_i|</M> denotes the area of <M>T_i.</M>
<P/>

Thus, 
<D>
E(u) = \bc' M\bc,
</D>
where <M>M</M> is the PD matrix with <M>(j,j')</M>-th entry given
by 
<D>
m_{jj'} = \sum_i |T_i| (\beta_{ij}\beta_{ij'} + \gamma_{ij} \gamma_{ij'}).
</D>

<HEAD2>Solving</HEAD2>
Suppose that the last <M>k</M> of the <M>c_j</M>'s are
known frame heights. Partition <M>\bc</M>
as <M>(\bc_1,\bc_2).</M> Then <M>\bc_2</M> is known,
and <M>\bc_1</M> is to be chosen to minimise <M>E(u).</M>
<P/>
Let us partition <M>M</M> accordingly as
<D>
M = <MAT>M_{11} & M_{12}\\M_{21} & M_{22}</MAT>.
</D>
Then 
<D>
\bc' M\bc = <MAT>\bc_1' & \bc_2'</MAT><MAT>M_{11} &
M_{12}\\M_{21} & M_{22}</MAT> <MAT>\bc_1\\\bc_2</MAT> = 
\bc_1' M_{11}\bc_1 + 2\bc_1' M_{12}\bc_2 + \bc_2' M_{11}\bc_2.
</D>
Differentiating w.r.t. <M>\bc_1</M>, and equating to zero, we get
<D>
M_{11}\bc_1 + M_{12}\bc_2 = \bz,
</D>
or
<D>
\bc_1 = -M_{11} ^{-1} M_{12} \bc_2.
</D>
This shows that the problem always has unique solution. 


<HEAD2>Practical problem</HEAD2>
However,
there is a practical difficulty. To get a reasonable
approximation we need the number of vertices to be pretty
large. In our example, the vertices are in a rectangular array formed
by subdividing the sides of the base. If we use 100 subdivisions
in both directions, then the number of vertices is <M>101^2,</M>
of which <M>99^2=9801</M> are interior vertices. Thus, we need to
solve <M>9801</M> equations in as many unknowns! For many real
life problem we need even more vertices:
<CIMG web="camgrid.png">Many vertices are needed to capture the
nooks and corners.</CIMG>
<P/>
However, notice that <M>M_{11}</M> is an extremely sparse
matrix. Each row contains just 6 nonzero entries. So one should
use Gauss-Seidel method here. 
<P/>
The project is to solve this problem with 50 subdivisions for
each side. The base is the unit square. The boundaries are the
graphs of the functions <M>0, </M> <M>x,</M> <M>1</M>
and <M>x^3.</M> 
<COMMENT>
<J>
99^2
n=.10
(],. 10&+,. 1&|.) i.n
(],. 10&+,. (_1&|.)@(10&+)) i.n

f=: 4 :'x,y,(x*y) + (1-x)*y^3'
b=: 4 :'x,y,0'
t=: 29%~i.30
((f s)~ t) fwrite 't.obj'
((b s)~ 4%~i.5) fwrite 'b.obj'
</J>
<D>
E(u) = \int_R u_x^2 + u_y^2. 
</D>
We approximate <M>u</M> with 
<D>
u(x,y) = \sum_j c_j \phi_j(x,y),
</D>
where 
<D>
\phi_j(x,y) = \alpha_{ij} + \beta_{ij}x + \gamma_{ij} y \mbox{
for } (x,y)\in T_i.
</D>
So 
<D>
u_x(x,y) = \sum_j c_j\beta_{ij} \mbox{ for } (x,y)\in T_i^\circ.
</D>
Hence
<D>
E(u) = \sum_i \int_{T_i} (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 
  = \sum_i |T_i| \{ (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 \}.
</D>
Thus, 
<D>
E(u) = \bc' M\bc,
</D>
where <M>M</M> is the PD matrix with <M>(j,j')</M>-th entry given
by 
<D>
m_{jj'} = \sum_i |T_i| (\beta_{ij}\beta_{ij'} + \gamma_{ij} \gamma_{ij'}).
</D>
Suppose that the last <M>k</M> of the <M>c_j</M>'s are
known. Partition <M>\bc</M> as <M>(\bc_1,\bc_2).</M> Then 
for minimum <M>E(u)</M> we need 
<D>
\bc_1 = M_{11} ^{-1} M_{12} \bc_2.
</D>
Here <M>M_{11}</M> is sparse.
</COMMENT>
<DISQUSE id="fem" url="https://www.isical.ac.in/~arnabc/numana/fem.html"/>
@}
</NOTE>
