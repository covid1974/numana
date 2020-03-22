<NOTE>
@{
<M>\newcommand{\ip}[1]{\langle #1 \rangle}</M>
<TITLE>Numerical Integration</TITLE>
<UPDT>FRI JAN 17 IST 2020</UPDT>
<HEAD1>Numerical Integration</HEAD1>


<HEAD2>Newton-Cotes quadrature</HEAD2>
Quadrature means numerical integration. We have aleady learned
two quadrature techniques: trapezium rule and Simpson's rule. We
have also mentioned that both of these are special cases of
Newton-Cotes quadrature. Here we shall learn about Newton-Cotes
quadrature in general.
<P/>
Newton-Cotes quadrature of
order <M>n</M> to
approximate <M>\int_a^b f(x)\, dx</M> starts with a
regularly spaced grid 
<D>
a = x_0,~~x_1,~~...,x_n = b,
</D>
where 
<D>
x_i = a + i\times[[b-a][n]].
</D>
Then it interpolates the <M>n+1</M>
points <M>(#(x_i,f(x_i))#)</M> with a polynomial, <M>p_n(x),</M>
of degree <M>\leq n.</M> Then it approximates <M>\int_a^b f(x)\,
dx</M> with <M>\int_a^b p_n(x)\, dx.</M>
<P/>
To be precise, this is called <B>simple</B> Newton-Cotes quadrature.
There is a more popular version called <B>composite</B>
Newton-Cotes quadrature. Here we first split <M>[a,b]</M> into a
number of equal subintervals, and apply simple Newton-Cotes
quadrature to each subinterval spearately. In particular, the 1-st
order composite Newton-Cotes quadrature is the same as trapezium
rule, and the 2-nd order composite Newton-Cotes quadrature is the
same as Simpson's rule.

<HEAD3>Quick derivation</HEAD3>
In practice there is a short cut method for finding the
(simple) Newton-Cotes quadrature formula for any given <M>n,</M>
that doe not require any interpolation.  It is based on the
following two observations.
<BOX name="Observation 1">
The <M>n</M>-th order simple Newton-Cotes quadrature must give
exact result if <M>f(x)</M> is a polynomial of degree <M>\leq n.</M>
</BOX>
The proof of this is obvious. The second observation is:

<BOX name="Observation 2">The <M>n</M>-th order simple Newton-Cotes formula 
is of the form
<D>
\int_a^b f(x)\, dx\approx \alpha _0 f(x_0) + \cdots + \alpha_n f(x_n),
</D>
where the numbers <M>\alpha_0,...,\alpha_n</M> may depend on <M>a,b,n</M> but not on
<M>f.</M> 
</BOX>
<EXR>
Show that this is true by observing that <M>f[x_0,...,x_k]</M>'s are
linear combinations of <M>f(x_i)</M>'s. 
</EXR>

Once we know that <M>\alpha_i</M>'s are free of <M>f,</M> we can take special
simple polynomials of <M>f</M> to compute them. For instance, to derive
the 1-st order Newton-Cotes formula we shall take
<M>f(x)=1</M> and <M>f(x)=x.</M> The first choice will give:
<D>
b-a = \alpha_0  + \alpha_1,
</D>
while the second choice gives
<D>
(b^2-a^2)/2 =  \alpha_0 a + \alpha_1 b
</D>
Solving these two equations we get 
<D>
\alpha_0 = \alpha_1 = \frac h 2,
</D>
which gives the trapezium rule.

<COMMENT>
Show that <M>\alpha_0+\cdots +\alpha_n = nh.</M>
</COMMENT>

Similarly, we can take <M>f(x)=1,x</M> and <M>x^2</M> for Simpson's rule
to get 3 equations:
<MULTILINE>
\alpha_0+\alpha_1+\alpha_2 &  = &  b-a\\
x_0\alpha_0+x_1\alpha_1+x_2\alpha_2 &  = &  (b^2-a^2)/2\\
x_0^2\alpha_0+x_1^2\alpha_1+x_2^2\alpha_2 &  = &  (b^3-a^3)/3
</MULTILINE>
Notice that this system can be written as 
<D>
<MAT>1& 1& 1\\x_0& x_1& x_2\\x_0^2& x_1^2& x_2^2</MAT>
<MAT>\alpha_0\\\alpha_1\\\alpha_2</MAT> = 
<MAT>(b-a)\\(b^2-a^2)/2\\(b^3-a^3)/3</MAT>.
</D>
The coefficient matrix is a Vandermonde matrix, and hence is
nonsingular. It should not be difficult to check that the unique solution
is given by 
<D>
\alpha_0 = h/3,~~~\alpha_1 = 4h/3,~~~\alpha_2 = h/3.
</D> 
Passing from simple to composite Newton-Cotes quadrature formulae
is simple. If the coefficients are <M>\alpha_0,...,\alpha_n,</M>
and we are using <M>3</M> subintervals, then the coefficients
will be 
<D>
\alpha_0, \alpha_1,...,\alpha_{n-1},\fbox{<M>\alpha_n+\alpha_0</M>},\alpha_1,...,\alpha_{n-1},\fbox{<M>\alpha_n+\alpha_0</M>},\alpha_1,...,\alpha_{n-1},\alpha_n.
</D>
Note the boxed terms, where two consecutive subintervals meet.

<HEAD3>Error analysis for Newton-Cotes formulae</HEAD3>
By construction the Newton-Cotes formula of degree <M>n</M> is exact ({\em
i.e.,} involves no error) if
<M>f(x)</M> is a polynomial of degree <M>\leq n.</M> In particular, the
trapezium rule is exact if <M>f(x)</M> is linear. However, it may not be
exact for higher degree polynomials.

<EXM>
Let us apply the trapezium rule to <M>f(x) = x^2</M> for <M>x_0 = 0</M>
and <M>x_1 = 1.</M> The actual integral is
<D>
\int_0^1 x^2 dx = \frac13.
</D>
Using trapezium rule we get 
<D>
\frac12(0+1) = \frac12 \neq \frac13.
</D>
</EXM>
 
However, something different happens for Simpson's rule. Since it is
the Newton-Cotes formula for <M>n=2,</M> it is exact for polynomials of
degree <M>\leq 2.</M> However, it turns out that it is also exact for
polynomials of degree 3.

<EXM>
Let us apply Simpson's rule to <M>f(x) = x^3</M> for <I>general</I>
<M>a,b.</M> 
The actual answer is
<D>
\int_a^b x^3 dx = \frac{(b^4-a^4)}{4}.
</D>
To apply Simpson's rule we notice that <M>x_0=a,x_1=(a+b)/2,x_2=b</M> and
<M>h=(b-a)/2.</M> So Simpson's rule gives
<D>
\frac{h}{3}(x_0^3 + 4x_1^3 + x_2^3),
</D>
which is same as the exact integral (check!)
</EXM>

<HEAD3>Special case of even <M>n</M></HEAD3>
The reason behind the exactness of Simpson's rule for cubic polynomials
is shown in the diagram below.  

<CIMG web="simpcub.png">Why Simpson's rule works for cubic
polynomials</CIMG>
The two areas marked <M>+</M> and <M>-</M> are equal, and hence cancel
each other out.

This is actually a general phenomenon for Newton-Cotes formulae for
<I>even</I> <M>n.</M> They are exact if <M>f(x)</M> is a polynomial of
degree <M>\leq n+1. </M> However, if <M>n</M> is odd then it is guaranteed
to be exact only if <M>f(x)</M> is a polynomial of
degree <M>\leq n.</M> To prove this let <M>f(x)</M> be a polynomial of
degree <M>n+1.</M> Then it coincides with the (n+1)-th degree
interpolating polynomial, and hence
<D>
f(x) = f[x_0]+(x-x_0)f[x_0,x_1]+\cdots+f[x_0,...x_n](x-x_0)\cdots(x-x_n).
</D>
If we use <M>n</M>-point Newton-Cotes formula, then we integrate only the
  first <M>n</M> terms. So we miss the last term, whose integral is
<D>
f[x_0,...x_n] \int_{x_0}^{x_n} (x-x_0)\cdots(x-x_n)dx.
</D>
Since the <M>x_i</M>'s are regularly spaced, the polynomial 
<D>
(x-x_0)\cdots(x-x_n)
</D>
has a graph like the following. 
 For even <M>n</M> there are exactly <M>n/2</M> humps above and below
the <M>x</M>-axis. So by symmetry (care!) the sum of the (signed)
 areas is zero.

<CIMG web="evennc.png">The shaded areas cancel out for even <M>n</M></CIMG>

Hence the result.


<HEAD2>Gaussian quadrature</HEAD2>
So far we have been using <M>f(x)</M> only via its values at some
regularly spaced points <M>x_i</M>'s. In some cases, it may be impossible
to know <M>f(x)</M> at other points, e.g., if <M>f(x)</M> is
not known analytically but only measured by some experiment. However, in
many other cases, it may be possible to compute <M>f(x)</M> at any value
of <M>x</M> of our choice. Then one may like to choose the values
<M>x_i</M>'s carefully to improve the accuracy of the quadrature in stead
of using regularly spaced <M>x_i</M>'s. This is the main idea behind
<I>Gaussian quadrature.</I> Here we try to approximate the integral as
<D>
\int_a^b f(x) dx \approx \alpha_0 f(x_0)+\cdots+\alpha_n f(x_n),
</D>
where <I>both</I> <M>\alpha_i</M>'s and  <M>x_i</M>'s are to be chosen to
increase the accuracy of the approximation. Since we are choosing
<M>2(n+1)</M> numbers here, (as compared to only <M>(n+1)</M> in
Newton-Cotes) we would expect that Gaussian quadrature is more accurate
(i.e., exact for higher degree polynomials) than Newton-Cotes
quadrature with the same <M>n.</M> Indeed, it will be accurate
for all polynomials of degree <M>\leq 2n+1.</M> 

<P/>
Gaussian quadrature depends on the following theorem.

<THM>
Let <M>x_0,...,x_n</M> be <M>n+1</M> distinct numbers. Let <M>m\geq
1</M> be any integer. Then the following two statements are equivalent.
<OL>
<LI>There are coefficients <M>\alpha_0,...,\alpha_n</M> such that for any polynomial
     <M>f(x)</M> of degree <M>\leq 2n+1,</M> 
<D lab="(*)">
\int_a^b f(x) dx = \sum_{i=0}^n \alpha_i f(x_i).
</D> </LI>
<LI>The polynomial 
<M>
p(x) = (x-x_0)(x-x_1)\cdots(x-x_n)
</M>
satisfies
<D lab="(**)">
\int_a^b x^kp(x)dx = 0~~~\forall k=0,1,...,n.
</D></LI>
</OL>
</THM>
First notice why this theorem is useful: (*) involves
both <M>x_i</M>'s and <M>\alpha_i</M>'s. But (**) involves only
the <M>x_i</M>'s. Yet they are equivalent. Thus, this theorem
allows us to find <M>x_i</M>'s first, without worrying about <M>\alpha_i</M>'s.
<PF>
(<M>1\Rightarrow2</M>): Let <M>\alpha_0,...,\alpha_n</M>
satisfy (*) for all polynomials of degree <M>\leq
    2n+1.</M> To show (**) fix any 
<M>k \leq n.</M> 

<P/>

Then the polynomial <M>x^kp(x)</M> is of degree
<M>\leq n+(n+1)=2n+1,</M> 
since degree of <M>p(x)</M> is <M>n+1.</M> 

<P/>

Taking <M>f(x) = x^k p(x)</M> in (*) we get
<D>
\int_a^b x^kp(x)dx = \sum_{i=0}^n \alpha_i x_i^k p(x_i) = 0,
</D>
 since <M>p(x_i) = 0</M> for all <M>i=0,...,n.</M>
<P/>
 So (**) holds.

<P/>

(<M>2\Rightarrow1</M>): We are given <M>x_0,...,x_n</M> such that 
(**) holds. We are to get <M>\alpha_0,...,\alpha_n</M> such
that (*) holds for any <M>f(x)</M> of degree <M>\leq 2n+1.</M>
 
First observe that for any <M>k=0,...,n</M>
<D>
\int_a^b x^k p(x)dx = \sum_{i=0}^n \alpha_i x^k p(x_i),
</D>
since the l.h.s. vanishes by (**) and the
r.h.s. vanishes by definition of <M>p(x).</M> Thus, for the
polynomials <M>x^kp(x)</M> we get (*) without even
worring about the <M>\alpha_i</M>'s! 

<P/>

Also we need (*) to hold also for <M>f(x)=x^k</M>
for <M>k=0,...,n.</M> So as in the 
Newton-Cotes approach we get then following Vandermonde system.
<D>
<MAT>1& 1& \cdots &  1\\
     x_0& x_1& \cdots& x_n\\
     x_0^2& x_1^2& \cdots& x_n^2\\
     \vdots &  \vdots &   &  \vdots\\
     x_0^n& x_1^n& \cdots& x_n^n
</MAT><MAT>\alpha_0\\\alpha_1\\\alpha_2\\\vdots\\ \alpha_n</MAT> = 
<MAT>c_0\\c_1\\c_2\\\vdots\\c_n</MAT>,
</D>
where 
<D>
c_k = \int_a^b x^k dx = (b^{k+1}-a^{k+1})/(k+1).
</D>
The <M>x_i</M>'s being distinct, the coefficient matrix is nonsingular,
and hence this system uniquely fixes the <M>\alpha_i</M>'s.

<P/>

Thus, by construction, (*) holds for degrees <M>\leq
  n,</M> and also for the polynomials <M>x^k p(x)</M> for <M>k=0,...,n.</M> 

<P/>

This immediately implies (how?) that (*) holds for all
polynomials of degree <M>\leq 2n+1.</M></PF>


<COMMENT>


In Newton-Cotes, ask to find <M>\alpha_i</M>'s for irregularly spaced <M>x_i</M>'s.


Find the difference between the <M>n</M>-th and <M>(n+1)</M>-th
interpolant.</COMMENT>

<HEAD3>Orthogonal polynomials</HEAD3>
The above theorem provides a useful approach to Gaussian
quadrature. Consider the set of all polynomials <M>f(x)</M> defined on
<M>[a,b].</M>
Clearly, it is a vector space over <M>{\bf R}</M> under usual addition and
scalar multiplication. Define the inner product 
<D>
\langle f,g \rangle = \int_a^b f(x)g(x) dx.
</D>
Then (**) says that <M>p(x)</M> is orthogonal to all
polynomials of degree <M>\leq m-1.</M> In other words, if <M>q(x)</M> is
any polynomial with degree <M>\leq m-1,</M> then
<D>
\langle p,q \rangle = 0.
</D>
Now, we can apply Gram-Schmidt orthogonalization to the basis 
<D>
\{1,x,x^2,x^3,...\}
</D>
w.r.t. the above inner product to get an orthogonal basis:
<D>
\{p_0(x),p_1(x),p_2(x),...\}
</D>
It is easy to see that each <M>p_k(x)</M> has degree <M>k.</M>
The following theorem is an important property of these orthogonal
polynomials. 
<THM>
Each <M>p_k(x)</M> has <M>k</M> distinct, real zeros inside the open
interval <M>(a,b).</M> 
</THM>
<PF>We shall not prove this in this course.</PF>

Let <M>z_{k,0},...,z_{k,k-1}</M> be the zeros of <M>p_k(x).</M> Then
Gaussian quadrature with <M>n+1</M> points uses the following approximation:
<D>
\int_a^b f(x) dx \approx \sum_{i=0}^n \alpha_{n+1,i} f(z_{n+1,i}),
</D>
where the <M>\alpha_{n+1,i}</M>'s are obtained from the Vandermonde system
with <M>x_i = z_{n+1,i}.</M>
This is exact if <M>f(x)</M> is a polynomial of degree <M>\leq 2n.</M>

<EXM>
Let us explicitly compute <M>p_0(x),p_1(x)</M> and <M>p_2(x)</M>
using <M>a=-1</M> and <M>b=1.</M> 
Notice that we care only about the roots of the polynomials, so we shall
save ourselves the trouble of normalizing the polynomials. 

We start with 
the usual basis <D>
u_0(x) = 1,~~~u_1(x)=x,~~~u_2(x)=x^2,\ldots.
</D>
We take
<D>p_0(x) = u_0(x) = 1.</D>
Taking out the <M>p_0</M>-component from <M>u_1</M> we are left with 
<D>
p_1 = u_1 - \frac{\ip{u_1,p_0}}{\ip{p_0,p_0}} p_0 = u_1 = x,
</D>
since
<D>
\ip{u_1,p_0} =  \int_{-1}^1 x dx = 0.
</D>
To find <M>p_2</M> we similarly take out the <M>p_0</M> and
<M>p_1</M>-components from <M>u_2</M> to get
<D>
p_2 = u_2 - 
      \frac{\ip{u_2,p_0}}{\ip{p_0,p_0}} p_0 -
      \frac{\ip{u_2,p_1}}{\ip{p_1,p_1}} p_1.
</D>
After some computation this turns out to be 
<D>
p_2(x) = x^2-\frac13.
</D>
</EXM>

<EXR>
Check that <M>p_3(x) = x^3-3x/5</M> and <M>p_4(x) = x^4-6x^2/7 + 3/35.</M>
</EXR>

<J>
pm=:+//. @ (*/)
ip=: (p.&1-p.&_1) @ (0&p.. @ pm )
comp=: [ * ip % (ip~@[) 
sb=:-/@,:
ad=:+/@,:

u0=: ,1
u1=: 0 1
u2=: 0 0 1

]p0=: u0
]p1=:  (] sb p0&comp) u1
]p2=:  (] sb p0&comp ad p1&comp) u2

p. p0
p. p1
p. p2
</J>
<EXM>
People have computed the zeros of <M>p_k(x)</M>'s and the corresponding
<M>\alpha_i</M>'s and published the values as tables. Here are the values
for <M>k=5.</M> 
<PRE>
i   z_{5,i}   alpha_{5,i}
---------------------------
0   0.00000000   0.56888889
1   0.53846931   0.47862867
2   -0.53846931   0.47862867
3   0.90617985   0.23692689
4   -0.90617985   0.23692689
</PRE>
Thus, if we want to integrate <M>f(x)=1/(x+3),</M> we shall compute as
follows.
<PRE>
i   f(z_{5,i})   alpha_{5,i} f(z_{5,i})
---------------------------------------
0   0.33333333   0.18962962
1   0.28260808   0.13526433
2   0.40625128   0.19444351
3   0.25600460   0.06065437
4   0.47759593   0.11315529
----------------------------
Total   =        0.69314712
</PRE>
Thus, we estimate
<D>
\int_{-1}^1 \frac{dx}{x+3} \approx 0.69314712.
</D>
</EXM>

<HEAD3>More general Gaussian quadrature</HEAD3> 
In fact, Gaussian quadrature is even more ambitious. It tries to choose
<M>\alpha_i</M>'s and <M>x_i</M>'s in a way that the formula is exact for
functions of the form 
<D>
f(x) = w(x) p(x),
</D>
where <M>w(x)</M> is some given positive function (called the <I>weight
function</I>) and <M>p(x)</M> is a polynomial of some suitable degree. The
optimal choice of <M>\alpha_i</M>'s and <M>x_i</M>'s will depend on the
particular weight function used. Depending on the choice of the weight
function we have different forms of Gaussian quadrature, e.g.,
Gauss-Legendre, Gauss-Laguerre etc. So far we have been working with the
weight function <M>w(x)\equiv 1.</M> If we further choose (without loss of
generality) <M>a=-1</M> and <M>b=1</M> then the resulting orthogonal
polynomials are called Legendre polynomials, and the corresponding Gaussian
quadrature formula is called Gauss-Legendre formula. 

We can choose <M>w(x),a</M> and <M>b</M> to suit particular needs. The
choice can be quite general (including <M>a=-\infty</M> and/or
<M>b=\infty.</M>) The only restrictions are: 
<OL>
<LI><M>w(x) >0~~~\forall x\in (a,b)</M> (In fact, we can allow
<M>w(x)</M> to be zero at finitely many points.)</LI>
<LI>The integral 
<D>
c_k := \int_a^b w(x) x^k dx
</D>
must be finite for all <M>k.</M></LI>
</OL>

These two conditions guarantee that we can define the inner product
<D>
\langle f,g \rangle = \int_a^b w(x) f(x)g(x) dx.
</D>

As before we can apply Gram-Schmidt orthogonalization to the basis 
<D>
\{1,x,x^2,x^3,...\}
</D>
w.r.t. the above inner product to get an orthogonal basis:
<D>
\{p_0(x),p_1(x),p_2(x),...\}
</D>
It is easy to see that each <M>p_k(x)</M> has degree <M>k.</M>
The following theorem is a generalization of the last theorem.

<THM>
Each <M>p_k(x)</M> has <M>k</M> distinct, real zeros inside the open
interval <M>(a,b).</M> 
</THM>
<PF>We shall not prove this in this course.</PF>

Once we choose <M>w(x), a</M> and <M>b,</M> we have the corresponding
Gaussian quadrature formula:
<D>
\int_a^b w(x) f(x) dx \approx \sum_{i=0}^n \alpha_{n+1,i} f(z_{n+1,i}), 
</D>
where <M>z_{n+1,0},...,z_{n+1,n}</M> are the zeros of <M>p_{n+1}(x)</M> and the
<M>\alpha_{n+1,i}</M>'s are obtained from
<D>
<MAT>1& 1& \cdots &  1\\
     x_0& x_1& \cdots& x_n\\
     x_0^2& x_1^2& \cdots& x_n^2\\
     \vdots &  \vdots &   &  \vdots\\
     x_0^n& x_1^n& \cdots& x_n^n
</MAT><MAT>\alpha_{n+1,0}\\\alpha_{n+1,1}\\\alpha_{n+1,2}\\\vdots\\ \alpha_{n+1,n}</MAT> = 
<MAT>c_0\\c_1\\c_2\\\cdots\\c_n</MAT>,
</D>
where 
<D>
c_k = \int_a^b x^k w(x) dx.
</D>
This formula is exact if <M>f(x)</M> is a polynomial of degree <M>\leq
2n.</M>

<HEAD3>Standard weights</HEAD3>
Certain choices of weights are more popular than others. Here is an
incomplete list.

<TABLE>
<TR><TH>Name</TH>   <TH><M>w(x)</M></TH>   <TH><M>(a,b)</M></TH></TR>
<TR><TD>Gauss-Legendre </TD><TD>  <M>1</M> </TD><TD>  <M>(-1,1)</M> </TD></TR>
<TR><TD>Gauss-Laguerre </TD><TD>  <M>e^{-x}</M> </TD><TD>  <M>(0,\infty)</M></TD></TR>
<TR><TD>Gauss-Hermite </TD><TD>  <M>e^{-x^2}</M> </TD><TD>  <M>(-\infty,\infty)</M></TD></TR>
<TR><TD>Gauss-Chebyshev </TD><TD>  <M>1/\sqrt{1-x^2}</M> </TD><TD>  <M>(-1,1)</M> </TD></TR>
</TABLE>

Standard tables are available for <M>z_{k,i}</M>'s and
<M>\alpha_{n,i}</M>'s for these cases. Here are some of these.

<TABLE caption="Gauss-Laguerre">
<TR><TH><M>i</M> </TH><TH>  <M>z_{5,i}</M> </TH><TH>  <M>\alpha_{5,i}</M></TH></TR>
<TR><TD><M>0</M> </TD><TD>  <M>0.263560319718</M> </TD><TD>  <M>0.521755610583</M></TD></TR>
<TR><TD><M>1</M> </TD><TD>  <M>1.413403059107</M> </TD><TD>  <M>0.398666811083</M></TD></TR>
<TR><TD><M>2</M> </TD><TD>  <M>3.596425771041</M> </TD><TD>  <M>0.759424496817e-1</M></TD></TR>
<TR><TD><M>3</M> </TD><TD>  <M>7.085810005859</M> </TD><TD>  <M>0.361175867992e-2</M></TD></TR>
<TR><TD><M>4</M> </TD><TD>  <M>12.640800844276</M> </TD><TD>  <M>0.233699723858e-4</M></TD></TR>
</TABLE>

For Gauss-Chebyshev there are simple closed-form formulae for
<M>z_{k,i}</M>'s and <M>\alpha_{k,i}</M>'s:
<D>
z_{k,i} = \cos\frac{(2i+1)\pi}{2k},~~~\alpha_{k,i} = \frac{\pi}{k}. 
</D>

Here is the table for Gauss-Hermite.

<TABLE caption="Gauss-Hermite">
<TR><TD><M>i</M> </TD><TD>  <M>z_{5,i}</M> </TD><TD>  <M>\alpha_{5,i}</M></TD></TR>
<TR><TD><M>0,1</M> </TD><TD>  <M>\pm2.0201828705</M> </TD><TD>  <M>0.0199532421</M></TD></TR>
<TR><TD><M>2,3</M> </TD><TD>  <M>\pm0.9585724646</M> </TD><TD>  <M>0.3936193232</M></TD></TR>
<TR><TD><M>4</M> </TD><TD>  <M>     0.0000000000</M> </TD><TD>  <M>0.9453087205</M></TD></TR>
</TABLE>
<DISQUSE id="numint2" url="https://www.isical.ac.in/~arnabc/numana/numint2.html"/>
@}
</NOTE>
