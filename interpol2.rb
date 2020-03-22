<NOTE>
@{
<M>\newcommand{\y}{\mathbf y}
\newcommand{\bb}{\mathbf b}
\newcommand{\xx}{\mathbf x}
\newcommand{\PP}{\mathbf P}
\newcommand{\RR}{\mathbf R}</M>
<TITLE>Interpolation</TITLE>
<UPDT>FRI JAN 17 IST 2020</UPDT>


<HEAD1>Different representations of polynomials</HEAD1>
A polynomial may be expressed in different forms. Some are useful for
algebraic manipulation, while some are useful for efficient
computation. We already know two forms: the coefficient form, and the
leading-coefficient-and-roots form. In the coefficient form we express a
polynomial as
<D>
a_0 + a_1x + a_2x^2 + \cdots + a_nx^n.
</D>
In the leading-coefficient-and-roots form we write it as
<D>
a(x-\alpha_1)(x-\alpha_2)\times\cdots(x - \alpha_n),
</D>
where <M>a</M> is the leading coefficient (<I> i.e.,</I> the coefficient of
the highest power of <M>x</M>) and the <M>\alpha _i</M>'s are the roots of
the polynomial. Other than these we shall learn about two more
representations of polynomials: <OL>
<LI/>Horner's form (or nested multiplication form)
<LI/>Bernstein's form (or Bezier form)
</OL>
<HEAD2>Horner's form</HEAD2>
Consider the polynomial
<D>
a_0 + a_1x + a_2x^2 + a_3x^3 + a_4x^4.
</D>
If you compute this naively by computing each power separately then it
needs <M>O(n^2)</M> multiplications (here <M>n=4.</M>) 
However, this is wasteful since to
compute <M>x^n</M> by multiplying <M>x</M> with itself <M>n</M> times, you
are already computing all the lower powers of <M>x</M> as well. To avoid
recomputing powers, rewrite the polynomial as
<D>
a_0 + x(a_1+x(a_2+x(a_3 + xa_4))).
</D>
This is called <I>Horner's form</I> or <I>nested multiplication form.</I>
Horner's scheme to compute an <M>n</M>-degree polynomial is to start with 
<M>b_n = a_n.</M> and recursively compute
<D>
b_i = a_i + b_{i+1}x.
</D>
<M>b_0</M> is the required value.
This method uses only <M>O(n)</M> multiplication.

<COMMENT>
Let <M>x_0</M> be any number. Divide <M>f(x)</M> by <M>(x-x_0)</M> to get
quotient <M>q(x)</M> and remainder <M>R,</M> <I> i.e.,</I>
<D>
f(x) = (x-x_0)q(x) + R.
</D>
Then show that
<MULTILINE>
R &  = &  b_0\\
q(x) &  = &  b_n x^{n-1} + \cdots b_1.
</MULTILINE>
</COMMENT>

<HEAD2>Bernstein form</HEAD2>
Consider the set <M>P_n</M> of all polynomials of degree less than or equal to
<M>n.</M> This set is a vector space. 

<EXR>
Show that the set <M>\{1,x,x^2,...,x^n\}</M> is a basis of this vector space.
</EXR>

<EXR>
Consider the polynomial
<D>
B_{n,k} = {n \choose k} x^k(1-x)^{n-k},
</D> 
for <M>0\leq k \leq n.</M> These are called <I>Bernstein polynomials.</I>
Show that 
<D>
\{B_{n,0},...,B_{n,n}\}
</D>
is a basis for <M>P_n.</M> [Hint: Use the fact that <M>x^i</M> divides
<M>B_{n,j}</M> iff <M>i< j.</M>]
</EXR>

By virtue of this exercise any polynomial of degree less than or equal to
<M>n</M> can be uniquely expressed as
<D>
\sum_{k=0}^n \beta_k B_{n,k}.
</D>
This is called Bernstein's form. You may be wondering why one should be
interested in this form. There are at least two reasons. Originally
Bernstein had used this representation to prove the following famous
theorem, called Weierstrass' approximation theorem:

<THM>
Let <M>f(x)</M> be any continuous function defined on <M>[a,b].</M> Let
<M>\epsilon > 0</M> be any number. Then there is a polynomial <M>p(x)</M>
such that 
<D>
|p(x)-f(x)| <  \epsilon ~~~\forall x\in[a,b].
</D>
</THM>

Thus, we can approximate any continuous function with a polynomial on a
closed, bounded interval with as much  accuracy as we want.

A second application of the Bernstein representation is in computer
graphics. It was due to a French engineer caller Bezier. So sometimes
a polynomial in Bernstein form is called a Bezier curve. The coefficients
of a polynomial determine its shape, but the relation between the shape
and the coefficients is not an intuitive one. However, the control points
allow much more intuitive control on the shape of the curve. To show this
we shall work with parametric cubic Bezier curves:
<D>
\xx(t) = (1-t)^3 \PP_0 + 3t(1-t)^2\PP_1 + 3t^2(1-t)\PP_2 + t^3\PP_3,~~~t\in[0,1].
</D>
Here <M>\xx(t) = (x(t),y(t)),</M> and <M>\PP_i\in\RR^2</M> are the control points.

<EXR>
Show that the curve passes through the two extreme control points,
<M>\PP_0</M> and <M>\PP_3.</M> Also show that the lines <M>\PP_0\PP_1</M>
and <M>\PP_2\PP_3</M> are tangents to the curve at <M>\PP_0</M> and
<M>\PP_3,</M> respectively.
</EXR>

Thus, as <M>t</M> goes from 0 to 1, the curve starts from <M>\PP_0</M> and
goes in the direction of <M>\PP_1,</M> and finally comes to <M>\PP_3</M>
from the direction of <M>\PP_2.</M> The length of <M>\PP_0\PP_1</M>
controls how strongly <M>\PP_1</M> ``attracts'' the curve toward
itself. Similarly, the length of <M>\PP_2\PP_3</M> determines the
attraction of <M>\PP_2.</M> In this way, <M>\PP_i</M>'s intuitively ``control'' the
shape of the curve. Bezier had first used them to design automobile
bodies. Now they are used in almost every computer graphics applications
requiring smooth curves. All standard softwares have provision to draw
parametric cubic Bezier curves.


<HEAD1>Splines</HEAD1>
<DEFN>A <I><M>k</M>-degree spline curve</I> is a piecewise polynomial
function where <OL>
<LI/>each piece is of degree at most <M>k,</M>
<LI/>the curve is <M>k-1</M> times continuously differentiable. 
</OL>
The most popular form of spline curve has degree 3. It is also called
a <I>cubic spline.</I> 
</DEFN>

Splines have various uses that can be classified in two classes:
interpolating and smoothing. We shall not discuss smoothing splines here. 
Given <M>n+1</M> points
<D>
(x_0,y_0),...,(x_n,y_n),
</D>
an <I>interpolating spline of degree <M>k</M></I> is a spline function
<M>f(x)</M> such that 
<M>f(x_i) = y_i</M> for all <M>i.</M> Between any two successive <M>x_i</M>'s
<M>f(x)</M> is a polynomial of degree (at most) <M>k.</M> The polynomials
need to be chosen so that 
they ``smoothly match'' at the <M>x_i</M>'s making <M>f(x)</M> have
a continuous <M>(k-1)</M>-th derivative. The <M>x_i</M>'s are called the
<I>knots</I> of the spline curve. In what follows we shall assume 
that <M>x_i</M>'s are equispaced with 
<D>
x_i = x_0 + i\delta
</D>

First we shall parametrize the <M>x</M>-values between two successive
knots by <M>t</M> going from 0 to 1. There are <M>n</M> intervals between 
the <M>x_i</M>'s. We shall call <M>[x_i,x_{i+1}]</M> the <M>i</M>-th
interval. The polynomial over the <M>i</M>-th
interval will be denoted by <M>f_i(x).</M> Over the <M>i</M>-th
interval define <M>t \equiv t(x) = (x-x_i)/\delta.</M> 
Then we can write <M>f_i(x)</M> as a polynomial in <M>t</M> as
<D>
f_i(x) = a_i + b_i t + c_i t^2 + d_i t^3~~~\mbox{ for } t\in [0,1],
</D>
where <M>i=0,...,n-1.</M>
We have three sets of conditions on the coefficients: 
<OL>
<LI>
<M>f(x)</M> must
match <M>y_i</M>'s at the knots,
</LI>
<LI> <M>f'(x)</M> must match at the knots,
</LI><LI>
<M>f''(x)</M> must match at the knots. 
</LI></OL>
Notice that 
<MULTILINE>
f_i'(x) & =&  \frac{1}{\delta} (b_i + 2c_i t + 3d_i t^2)\\ 
f_i''(x) & =&  \frac{1}{\delta^2} (2c_i + 6d_i t). 
</MULTILINE>

So for <M>i=0,...,n-1,</M>
<MULTILINE>
f_i'(x_i) & =&  \frac{b_i}{\delta} \\
f_i'(x_{i+1}) & =&  \frac{1}{\delta} (b_i + 2c_i + 3d_i)\\ 
f_i''(x_i) & =&  \frac{2c_i}{\delta^2} \\ 
f_i''(x_{i+1}) & =&  \frac{1}{\delta^2} (2c_i + 6d_i).
</MULTILINE>

The first set gives rise to the following
equations:
<MULTILINE>
y_i &  = &  a_i,\\
y_{i+1} &  = &  a_i+b_i+c_i+d_i,
</MULTILINE>
for <M>i=0,...,n-1.</M>
Let us denote <M>f'(x_i)</M> by <M>D_i.</M> Then the second set of
conditions produce:
<MULTILINE>
D_i &  = &  \frac{b_i}{\delta},\\
D_{i+1} &  = &  \frac{b_i+2c_i+3d_i}{\delta},
</MULTILINE>
for <M>i=0,...,n-1.</M>
Before we take a look at the third set of conditions, let us use the above
equations to express <M>a_i,b_i,c_i</M> and <M>d_i</M> in terms of
<M>y_i</M>'s and <M>D_i's:</M>
<MULTILINE>
a_i &  = &  y_i\\
b_i &  = &  \delta D_i\\
c_i &  = &  3(y_{i+1}-y_i) + \delta(D_i-D_{i+1})\\
d_i &  = &  \delta(D_{i+1}-D_i)+ 2(y_i-y_{i+1}). 
</MULTILINE>
for <M>i=0,...,n-1.</M>

Thus, the problem of finding suitable <M>a_i,b_i,c_i</M> and
<M>d_i</M>'s is now reduced to finding suitable <M>D_i</M>'s. For this we
turn to the third set of conditions (matching of second derivatives.) At
the interior points (<I> i.e.,</I> <M>x_1,...,x_{n-1}</M>) we need
<D>
f_{i-1}''(1) = f_i''(0)
</D>
for <M>i=0,...,n-1.</M>
This means 
<D>
2c_{i-1}+6d_{i-1} = 2c_i
</D>
for <M>i=0,...,n-1.</M>
Writing <M>c</M>'s and <M>d</M>'s in terms of <M>D_i</M>'s and
<M>y_i</M>'s we get
<D>
D_{i-1} + 4 D_i + D_{i+1} = 3(y_{i+1}-y_{i-1})~~~\mbox{ for } i=1,...,n-1.
</D>
This gives <M>n-1</M> equations for the <M>n+1</M> unknowns,
<M>D_0,...,D_n.</M> If we put the following two conditions at <M>x_0</M>
and <M>x_n:</M> 
<MULTILINE>
f''(x_0)&  =&  0\\
f''(x_n)&  =&  0, 
</MULTILINE>
then the resulting spline is called <I>natural spline.</I> Note that
these two conditions translate into the following two equations involving
<M>D_i</M>'s:
<MULTILINE>
2D_0+D_1 &  = &  3(y_1-y_0)\\
D_{n-1}+2D_n &  = &  3(y_n-y_{n-1}).
</MULTILINE>
So we get the following tridiagonal system:
<D>
<MAT>
2 &  1\\
1&  4 &  1\\
& 1&  4 &  1\\
& & 1&  4 &  1\\
& & \ddots&  \ddots &  \ddots\\
& & & 1&  4 &  1\\
& & & &  1 &  2
</MAT><MAT>D_0\\D_1\\D_2\\D_3\\\vdots\\D_{n-1}\\D_n</MAT>
= 3<MAT>y_1-y_0\\y_2-y_0\\y_3-y_1\\y_4-y_2\\
\vdots\\y_n-y_{n-2}\\y_n-y_{n-1}</MAT>.
</D>

<EXR ref="" paper="" marks="">
Some authors derive cubic splines in a different way. They denote
<M>f''(x_i)</M> by <M>S_i,</M> say, and express <M>a_i,b_i,c_i</M> and
<M>d_i</M> in terms of <M>y_i</M>'s and <M>S_i</M>'s. Then they derive a
system of equations for the <M>S_i</M>'s. Follow this process and check
that you get a tridiagonal system for the <M>S_i</M>'s.
</EXR>

<EXR ref="" paper="" marks="">
While deriving the equations for <M>D_i</M>'s we first had only <M>n-1</M>
equations for <M>n+1</M> unknowns. To get <M>n+1</M> equations We
introduced two extra conditions: <M>f''(x_0) = 0</M> and <M>f''(x_n) =
0.</M> Sometimes one uses other conditions like: <M>f(x_0) = f(x_n)</M>
and <M>f'(x_0) = f'(x_n).</M> Derive a system of equations for
<M>D_i</M>'s in this case. Why should people be interested in
these two conditions? 
</EXR>

<DISQUSE id="interpol2"
url="https://www.isical.ac.in/~arnabc/numana/interpol2.html"/>
@}
</NOTE>
