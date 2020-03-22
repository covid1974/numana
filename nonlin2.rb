<NOTE>
@{
<M>
\newcommand{\bf}{{\bf f}}
\newcommand{\bx}{{\bf x}}
\newcommand{\by}{{\bf y}}
\newcommand{\bz}{{\bf 0}}</M>
<TITLE>Nonlinear equations</TITLE>
<UPDT>SUN MAR 22 IST 2020</UPDT>


<HEAD1>Fixed-point iteration</HEAD1>
A value <M>a</M> is called a fixed point of a function <M>f(x)</M> if
<M>f(a) = a.</M> Finding the fixed point of <M>f(x)</M> is the same as
finding a zero of <M>f(x)-x.</M> One simple way to compute a fixed point
of <M>f(x)</M> is to start with some initial guess <M>x_0</M> and then to
iterate 
<D>
x_{k+1} = f(x_k).
</D>
However, this is not guaranteed to converge. 
<EXM>
Let us try to solve the equation 
<D>
x = \cos(x).
</D>
We start with the initial guess
 <M>x_0=1.</M>
Here are the values of a few iteration:
<PRE>
k       x_k     cos(x_k)
-------------------------
  2   1.00000   0.54030
  3   0.54030   0.85755
  4   0.85755   0.65429
  5   0.65429   0.79348
  6   0.79348   0.70137
  7   0.70137   0.76396
  8   0.76396   0.72210
  9   0.72210   0.75042
  10   0.75042   0.73140
  11   0.73140   0.74424
  12   0.74424   0.73560
  13   0.73560   0.74143
  14   0.74143   0.73751
  15   0.73751   0.74015
  16   0.74015   0.73837
  17   0.73837   0.73957
  18   0.73957   0.73876
  19   0.73876   0.73930
  20   0.73930   0.73894
</PRE>
</EXM>
It is instructive to see the iterations graphically. A fixed
point of <M>f(x)</M> means a point where the graph of <M>f(x)</M>
meets the <M>y=x</M> line. The fixed point iterations above may
be visualised as the following "cobweb diagram" (the blue line is
the graph of <M>\cos x,</M> the red diagonal is the <M>y=x</M>
line).
<CIMG web="cobweb1.png"> Cobweb Diagram</CIMG>
The following code snippet produces this.
<J>
fp1=: (],f),:(f,f)
fp=: ],fp1 @ {. @ {:
f=: cos
x=: (i.100) % 99
plot x ; f x
pd x ; x
pd ;/ |: fp^:20 (1 2 $ 1 0)
pd'show'
</J>
<P/>

The next example shows a case where the fixed point iteration does not
converge.

<EXM>
Let us apply the fixed point iteration to solve <M>x = f(x)=x^2.</M> If we
start from <M>|x_0|>1,</M> the sequence <M>\{x_k\}</M> defined by 
<D>
x_k = x_{k-1}^2
</D> 
diverges to infinity. If, however, <M>|x_0|< 1</M> then the sequence
converges to the fixed point <M>0.</M> To converge to the fixed point 1,
you need to start with <M>x_0=\pm1.</M>
</EXM>

Notice that the iteration <M>x_{k+1} = f(x_k)</M> does not make sense if
<M>f(x_k)</M> falls outside the domain of <M>f,</M> since then we cannot
compute <M>x_{k+2} = f(x_{k+1})</M> in the next step. So we need to make
the following assumptions:
<OL>
<LI>There is an interval <M>[a,b]</M> such that <M>f(x)</M> maps <M>[a,b]
</M> into <M>[a,b],</M></LI>
<LI><M>f(x)</M> is continuous over <M>[a,b]</M></LI>
<LI><M>x_0\in[a,b].</M></LI>
</OL>

<THM>
The above conditions guarantee that <M>f(x)</M> has at least one fixed
point in <M>[a,b].</M>
</THM>
<PF>
If <M>f(a)=a</M> or <M>f(b)=b,</M> we are done. Otherwise, 
<M>f(a)?a</M> and <M>f(b)< b.</M> Let the points <M>(a,f(a))</M> and
<M>(b,f(b))</M> be denoted by <M>A</M> and <M>B,</M> respectively. Then
the graph of <M>f(x)</M> is a continuous curve from <M>A</M> to <M>B,</M>
and hence it must intersect the diagonal at least once. Any such
intersection is a fixed point of <M>f(x).</M> 
<CIMG web="fixed.png">A continuous curve from <M>A</M> to <M>B</M> must cross the diagonal</CIMG>
</PF>

The following theorem gives  a sufficient condition for the fixed point
iteration to converge. 

<THM>
Let <M>f(x)</M> satisfy the conditions above. We further assume that
<M>f(x)</M> is differentiable over <M>[a,b]</M> and
<M>|f'(x)| \leq K</M> for <M>x\in[a,b]</M> for some <M>K<1.</M> Then <M>f(x)</M> has 
exactly one fixed point in <M>[a,b],</M> and the iteration  converges to
this point.
</THM>
<PF>
We already know that <M>f(x)</M> has at least one fixed point in
<M>[a,b].</M> Let it have at least two fixed points <M>\xi</M> and
<M>\eta</M> in <M>[a,b],</M> if possible. Define <M>g(x) = f(x)-x.</M>
Then <M>g(\xi) = g(\eta)=0.</M> So, by Rolle's theorem, <M>g'</M> must
vanish for some point <M>\theta</M> in <M>(\xi,\eta).</M> Hence, 
<D>
g'(\theta) = f'(\theta)-1=0,
</D>
which is impossible since <M>|f'(x)| <  1</M> for all <M>x\in[a,b].</M>
This proves that <M>f(x)</M> has exactly one fixed point in <M>[a,b].</M>

<P/>

Let this unique fixed point be denoted by <M>\xi.</M>
We want to show that <M>x_n\rightarrow \xi</M> as <M>n\rightarrow\infty.</M>
Define <M>e_n = x_n-\xi.</M> 
Then 
<MULTILINE>
e_{n+1} &  = &  x_{n+1}-\xi\\
&  = &  f(x_n)-f(\xi)\\
&  = &  f'(\lambda)(x_n-\xi),
</MULTILINE>
for some <M>\lambda</M> between <M>x_n</M> and <M>\xi,</M> by the mean
value theorem. Thus,
<D>
e_{n+1} = f'(\lambda) e_n\leq K|e_n|.
</D>
Using this repeatedly,
<D>
|e_n| \leq K^n |e_0| \rightarrow 0 \mbox{ as } n\rightarrow\infty,
</D>
completing the proof.
</PF>

<HEAD2>Checking convergence</HEAD2>
Here we shall take a second look at numerical methods to solve
equations of the form
<D>
f(x)=0,
</D>
that we cannot easily solve analytically.
<P/>
A typical numerical method (like the Newton-Raphson method) is iterative in nature, i.e., it generates
a sequence <M>x_0,x_1,x_2,...</M> that (hopefully) converges to a
root of the equation. In the first part of the course, we have
deliberately avoided the question: How to check for convergence?
We have just used the naive approach of stopping whenever two
successive iterates are "close enough". Here  we provide a longer list:
<OL>
<LI>We can  stop if  <M>|f(x_n)|< \eta,</M> where <M>\eta</M> is 
a prespecified tolerance in the <M>f</M>-space.</LI>
<LI> Often we use the stopping criterion
<M>|x_n-x_{n-1}|< \epsilon,</M> where <M>\epsilon </M>
is a prespecified tolerance in the <M>x</M>-space. This is very
popular because it is easy to compute. This is what we have been
using so far. While it often works well in practice, it is really not a
guarantee that <M>x_n</M> is near the true root <M>\xi</M> or <M>f(x_n)</M> is near
0. If you are using this stopping criterion then it is a wise thing to
separately check that <M>f(x_n)</M> is indeed close to zero.</LI>
<LI>Usually, it is better to use the criterion <M>|[|
[[x_n-x_{n-1}][x_{n-1}]] |]| < \epsilon,</M>
where <M>\epsilon </M> is some specified relative tolerance.</LI>
<LI>We must keep a provision to deal with divergent (or very slowly
convergent) sequences. So we must stop if <M>n\geq n_{max},</M> where
<M>n_{max}</M> is some prespecified maximum number of iteration. If this
number is reached, we should output a ``No convergence''
message. 
</LI>
</OL>
Thus, a typical iterative algorithm to solve <M>f(x)=0</M> may need three
convergence checking inputs from the user: <M>\epsilon, \eta</M> and
<M>n_{max}.</M> Of these, <M>n_{max}</M> and at least one of
<M>\epsilon</M> and <M>\eta</M> must be present. 

<P/>
<B>Always treat iterative method outputs with suspicion!</B> The
reason is simple: 
<Q>
<ALERT/>
The convergence behaviour of an infinite
sequence is not affected by only finitely many terms. Yet a
computer can check only finitely many terms to determine convergence.
</Q>
The
following example is meant to scare you. 

<EXM>
A foolish guy is trying to find the sum <M>\sum_1^\infty
[[1n]].</M> He is using the iterative method:
<D>
s_n = s_{n-1} + [[1n]]\mbox{ for } n\in\nn
</D>
starting with <M>s_0 = 0.</M> He is using <M>\epsilon =
0.000001.</M> What is the result?
<SOLN/>
He tests <M>|s_n-s_{n-1}| < \epsilon,</M> i.e., <M>[[1n]] <
\epsilon,</M> which occurs for <M>n=1+10^7.</M> 
<P/>
So this fellow will find a finite limit of this divergent
sequence.
<J>
+/% 1+i.1+1e7
</J>
The answer is 16.6953. Wow!
</EXM>

Before you lose all faith in iterative methods, however, do please try
the next exercise:

<EXR>
We know <M>\sum[[1][n^2]] = [[\pi^2][6]].</M> Use the iteration
<D>
s_n = s_{n-1} + [[1][n^2]]\mbox{ for } n\in\nn
</D>
starting with <M>s_0 = 0.</M> Use the same <M>\epsilon </M> as
before. How close are you getting to <M>[[\pi^2][6]]</M>
<HINT>
<J>
+/% *~1+i.1+1e7
</J>
</HINT></EXR>

<HEAD2>Rate of convergence</HEAD2>
So far we have seen that fixed point iteration converges under certain
conditions. The next question is `How fast does it converge?' To quantify
rate of convergence we need the following definition.

<DEFN>
Suppose that we have generated the sequence <M>\{x_n\}</M> by the fixed
point iteration that converges to a fixed point <M>\xi.</M> Define <M>e_n
= x_n-\xi.</M> We shall assume that <M>e_n\neq 0 </M> for all <M>n.</M>
We say that the fixed point iteration converges <I>with rate <M>p</M></I> if
<D>
\lim_{n\rightarrow\infty}\left|\frac{e_n}{e_{n-1}^p}\right|
</D>
is finite and nonzero.
</DEFN>
The assumption  that <M>e_n</M>'s are all nonzero is actually a trivial
one, since if <M>e_n=0</M> for some <M>n</M> then  <M>e_k=0</M> for
all <M>k\geq n.</M> In this  case we have exactly found the answer, and so we
shall not care about the rate of convergence.

<THM>
Let <M>f</M> be a continuously differentiable function with <M>|f'(x)| <  1</M> for <M>x\in[a,b].</M> Let <M>\xi</M> be the
unique  fixed point of <M>f(x)</M> in <M>[a,b].</M> If
<M>f'(\xi)\neq0,</M> then the rate of convergence is linear.
</THM>
<PF>
It is easy to see that 
<D>
\lim_{n\rightarrow\infty}\left|\frac{e_n}{e_{n-1}}\right| = |f'(\xi)|.
</D>
</PF>

<THM>
Let Let <M>f</M> be twice continuously differentiable function with <M>|f'(x)| <  1</M> for <M>x\in[a,b].</M> Let <M>\xi</M> be the
unique  fixed point of <M>f(x)</M> in <M>[a,b].</M> If
<M>f'(\xi)=0,</M> and <M>f''(\xi)\neq0</M> then the rate of convergence is quadratic.
</THM>
<PF>
We have for some <M>\lambda_n</M> between <M>\xi</M>
and <M>x_n,</M> 
<MULTILINE>
f(x_n) 
& =&  f(\xi) + f'(\xi)(x_n-\xi) + \frac{f''(\lambda_n)}{2!}(x_n-\xi)^2\\
& =&  f(\xi)+ \frac{f''(\lambda_n)}{2!}(x_n-\xi)^2.
</MULTILINE>

So 
<D>
e_{n+1} = x_{n+1}-\xi = f(x_n)-f(\xi) =  \frac{f''(\lambda_n)}{2!}e_n^2.
</D>

Taking limit as <M>n\to\infty</M> and using the continuity
of <M>f''</M> we have
<D>
\left|\frac{e_{n+1}}{e_n^2}\right| \to  \frac{f''(\xi)}{2}
</D>
completing the proof.
</PF>

<HEAD2>Convergence rate of Newton-Raphson</HEAD2>
To solve <M>g(x)=0,</M> the Newton-Raphson iteration is 
<D>
x_{n+1} = x_n-\frac{g(x_n)}{g'(x_n)}.
</D>
This is a fixed point iteration <M>x_{n+1} = f(x_n),</M> where
<D>
f(x) = x-\frac{g(x)}{g'(x)}.
</D>
Let <M>\xi</M> be a zero of <M>g(x)</M> where the iteration
converges. Assume that <M>g'(\xi)\neq0.</M> Then 
<D>
f'(\xi) = 1-\frac{(g'(\xi))^2-g(\xi)g''(\xi)}{(g'(\xi))^2} = 0.
</D>
However, if <M>g'(\xi)=0,</M> then the Newton-Raphson iteration converges
only linearly.

<HEAD1>Combining Newton-Raphson and bisection methods</HEAD1>
We have learned about the Newton-Raphson and bisection methods in
the first part of the course. The Newton-Raphson method converges
fast, but requires the derivative. The bisection method converges
slowly, does not require the derivative to exist (needs only
continuity), and requires two initial points, <M>x_0</M>
and <M>x_1,</M> suchthat <M>f(x_0)</M> and <M>f(x_1)</M> have
opposite signs.

<P/>
It is possible to merge these two methods into a single method
that tries to balance to the good properties of both, while
avoiding their disdvantages. The method has two variants: you
call it <B>Regula Falsi</B> when you consider as a faster alternative to
the bisection method, and call it the <B>secant method</B> when you
consider at a derivative-free version of the Newton-Raphson method.
<HEAD2>Regula falsi</HEAD2>
This method is a close kin of the bisection method. Here also we start
with an interval <M>(l_0,r_0)</M> such that <M>f(l_0)</M> and
<M>f(r_0)</M> have opposite signs. However, unlike the bisection method,
here we define <M>m_k</M> as the value of <M>x</M> where the line joining 
<M>(l_k,f(l_k))</M> and <M>(r_k,f(r_k))</M> intersects the <M>x</M>-axis. 

<CIMG web="regfal.png">Regula falsi</CIMG>
<HEAD2>Secant method</HEAD2>
Here we shall approximate <M>f(x)</M> locally using a straight
line. Suppose that we know that <M>f(x_0)=y_0</M> and <M>f(x_1)=y_1.</M>
We shall join the points <M>(x_0,y_0)</M> and <M>(x_1,y_1)</M> with a
straight line and see where it hits the <M>x</M>-axis. The value of
<M>x</M> where the line hits the <M>x</M>-axis will be called <M>x_2.</M>
In general, if <M>L_i</M> denotes the straight line joining
<M>(x_{i-1},y_{i-1})</M> and <M>(x_{i},y_{i})</M> then <M>x_{i+1}</M> is
defined as the value of <M>x</M> where <M>L_i</M> hits the
<M>x</M>-axis. (If <M>L_i</M> happens to be parallel to the <M>x</M>-axis,
the algorithm stops with the message ``Failure.'') 
<CIMG web="secant.png">Secant method</CIMG>

We proceed like this until  convergence.

<EXM>
Let us apply this method to solve <M>\cos(x)=x.</M> We shall take
<M>x_0=0</M> and <M>x_1 = 0.5.</M> 

<PRE>
k    x_k
2  0.8033194
3  0.7353735
4  0.7390341
5  0.7390852
6  0.7390851
7  0.7390851
</PRE>
So the answer is 0.739085 up to 6 decimal places.
</EXM>

<J>
rf=: monad :'y,(],f)+/({: y) * 1, -%/-/_2{.y'
f=:]-cos
rf^:10 (],.f) 0 0.5
</J>

<HEAD1>Polynomial roots</HEAD1>
Finding the roots of a polynomial is important in different branches of
science. It is a special case of solving nonlinear equations. However, it
has one difference from the functions discussed so far, namely, a
polynomial may have complex roots. We shall first see how we can apply
Newton-Raphson method to find a real root of a polynomial starting from an
initial approximation. Later we shall attack the problem of finding
complex roots of polynomials. 

Let <M>f(x)</M> be the polynomial whose root we want to find. Let
<M>x_0</M> be an initial approximation to the root. Then the
Newton-Raphson iteration is 
<D>
x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}.
</D>
This is just the general Newton-Raphson iteration, nothing special about
polynomials. The fact that <M>f(x)</M> is a polynomial makes the
computation of <M>f'(x)</M> simple, as we show next.

<HEAD2>Horner's method to compute, differentiate and deflate a polynomial</HEAD2>
<HEAD3>Computing</HEAD3>
Suppose that <M>f(x) = a_0+a_1x+a_2x^2+\cdots+a_nx^n.</M> Then
Horner's method is to to compute it in a nested form, so that we
do not have to compute each power of <M>x</M> from scratch (e.g.,
if we have already computed <M>x^2</M>, we can compute <M>x^3</M>
as <M>x^2\times x,</M> instead of <M>x\times x\times x</M>). Here
is an example.

<EXM>
Express <M>1+3x-4x^2+10x^3</M> in Horner's form.
<SOLN/>
<M>1+x(3+x(-4+x(10))).</M>
</EXM>
The general scheme to compute <M>f(x) =
a_0+a_1x+a_2x^2+\cdots+a_nx^n</M> is
<MULTILINE>
b_n &  = &  a_n\\
b_i &  = &  a_i + b_{i+1}x \quad\mbox{ for } i=n-1,...,0.
</MULTILINE>
The required value of the polynomial is <M>b_0.</M>

<HEAD3>Differentiating</HEAD3>
We can use Horner's method to differentiate a
polynomial <M>f(x),</M> because <M>f'(x)</M> is
again a polynomial. So  we can compute it by Horner's method:
<MULTILINE>
c_{n-1} &  = &  na_n\\
c_i &  = &  ia_i + c_{i+1}x \quad \mbox{ for } i=n-2,...,0.
</MULTILINE>
At the end of the iteration <M>c_0</M> stores the required value of
<M>f'(x).</M>

<HEAD2>Deflating a polynomial by Horner's method</HEAD2>
Suppose that we have found one zero, <M>\alpha,</M> of a polynomial, <M>f(x).</M>
Then <M>(x-\alpha)</M> is a factor of <M>f(x).</M> 
To find the other roots of the polynomial we need to divide <M>f(x)</M> by 
<M>(x-\alpha)</M> to get a polynomial of degree one less than that of
<M>f(x).</M>
This is called <I>deflating</I> the polynomial by
<M>\alpha.</M> The <M>b_i</M>'s of Horner's method can be used to compute
the deflated polynomial. The following theorem is the key to this method.

<THM>
Let <M>f(x) = a_0+a_1x+a_2x^2+\cdots+a_nx^n</M> be a polynomial. Consider
the Horner's iteration scheme to evaluate it at <M>x=\alpha:</M>
<MULTILINE>
b_n &  = &  a_n\\
b_i &  = &  a_i + b_{i+1}\alpha \quad\mbox{ for } i=n-1,...,0.
</MULTILINE>
Define <M>g(x) = b_1+b_2x+b_3x^2+\cdots+b_nx^{n-1}.</M>
Then 
<D>
f(x) = b_0 + (x-\alpha) g(x).
</D>
</THM> 
<PF>Direct computation.</PF>

This theorem has two implications. First, putting <M>x=\alpha</M> in
the theorem we get <M>f(\alpha)=b_0,</M> which is the output of
Horner's method. Second, if <M>\alpha</M> is
a root of <M>f(x)</M> then <M>g(x)</M> is the deflated polynomial
<M>f(x)/(x-\alpha).</M> 

<EXM>
Let us apply this method to deflate the polynomial 
<D>
f(x) = (x-1)(x-2)^2 = -4+8x-5x^2+x^3
</D>
at the root <M>x=2.</M>
Here
<MULTILINE>
b_3 &  = &  1\\
b_2 &  = &  -5+2\times1 = -3\\
b_1 &  = &  8+2\times(-3) = 2\\
b_0 &  = &  -4+2\times2 = 0.
</MULTILINE>
Since <M>b_0=0</M> we know that <M>2</M> is a root of the polynomial. The
deflated polynomial is 
<D>
b_1+b_2x+b_3x^2 = 2-3x+x^2.
</D>
</EXM>

<HEAD2>Finding complex roots</HEAD2>
Newton-Raphson iteration has the property that if we start with a real
<M>x_0</M> and <M>f(x)</M> is a real polynomial ({\em i.e.,} the
coefficients of <M>f(x)</M> are all real numbers,) then all the
<M>x_n</M>'s are real numbers as well. So we cannot find complex roots
using Newton-Raphson method if we start from a real initial
value. However, it is possible to find complex roots of a polynomial by
Newton-Raphson method if we start from a complex <M>x_0.</M> In fact, we
can even deal with complex polynomials (where we allow the coefficients to
be complex as well.) Horner's algorithm for evaluating, differentiating
and deflating works even for complex polynomials.

<EXM>
Let us apply the complex Newton-Raphson method to find a root of <M>f(x) =
x^2+1</M> starting from <M>x_0 = 1+i.</M> The iteration is
<D>
x_{n+1} = x_n - \frac{x_n^2+1}{2x_n} = \frac{1}{2}\left(x_n-\frac{1}{x_n}\right).
</D> 
Here are the values of <M>x_n:</M>

<PRE>
n   x_n
--------------------------
0   1+i
1   0.25+0.75i
2   -0.075+0.975i
3   0.001715686+0.997304i
4   -4.641846e-06+1.000002i
5   -1.002868e-11+1i
6   8.463657e-23+1i
7   i
</PRE>
</EXM>

<HEAD2>Muller's method</HEAD2>
This is another method for finding the complex roots of a polynomial.
It has a number of advantages:
<OL>
<LI>Fast convergence.</LI>
<LI>Relatively insensitive to the choice of initial values. So we can
afford to start with rather crude initial approximations. </LI>
<LI> Unlike Newton-Raphson method, here we do not need to compute the
derivative of the function.</LI>
<LI>This method can find complex roots even if the initial values are
real numbers.</LI>
<LI>Just like Newton-Raphson method, this method can also be applied to
find complex roots of nonlinear functions other than polynomials.</LI>
</OL>

<CIMG web="muller.png">Muller's method</CIMG>

Muller's method is a direct generalization of the secant method. In secant
method we approximate <M>f(x)</M> by linear interpolation. In Muller's
method we use quadratic interpolation, {\em i.e.,} we fit a parabola. In
secant method we need <M>x_{n-1}</M> and <M>x_n</M> to find
<M>x_{n+1}.</M> In Muller's method we need <I>three</I> points
<M>x_{n-2}, x_{n-1}</M> and <M>x_n</M> to compute <M>x_{n+1}.</M> A
parabola is a quadratic polynomial, and so has two roots (may be just one
repeated root,) and the roots may be complex. We take <M>x_{n+1}</M> to be the root that is
closer to <M>x_n.</M> The iteration needs three values <M>x_0,x_1</M> and
<M>x_2</M> to start. Since the algorithm converges fast even from remote
initial values, one can as well take <M>x_0=-1, x_1=0, x_2=1.</M>  Once a
root is found, we can deflate the polynomial by the root, and then again
apply Muller's method with the same three initial values.

Here are some important points that may help you to implement Muller's
method:
<OL>
<LI>Suppose that you already have <M>x_{n-2},x_{n-1}</M> and <M>x_n,</M>
and you are about to compute <M>x_{n+1}.</M> For this you have to find the interpolating
parabola <M>p(x)</M> through the three points
<D>
(x_{n-2},y_{n-2}), (x_{n-1},y_{n-1}) \mbox{ and } (x_{n},y_{n}),
</D>
where <M>y_i = f(x_i).</M> Then you need to find the two roots of <M>p(x)</M> by
the usual formula for quadratic polynomials, and pick the root closer to
<M>x_n.</M> Since you have to compute the distance of the roots from
<M>x_n</M> it is wiser to express <M>p(x)</M> in terms of powers of
<M>(x-x_n)</M> rather than powers of <M>x.</M> You may check that 
<D>
p(x) = A(x-x_n)^2 + B(x-x_n) + C,
</D>
where
<MULTILINE>
A &  = &  \frac{(y_{n-2}-y_n)(x_{n-1}-x_n)-(y_{n-1}-y_n)(x_{n-2}-x_n)}
                     {(x_{n-2}-x_n) (x_{n-1}-x_n) (x_{n-2}-x_{n-1})}\\
B &  = &  \frac{(y_{n-1}-y_n)(x_{n-2}-x_n)^2 -
                      (y_{n-2}-y_n)(x_{n-1}-x_n)^2}
                     {(x_{n-2}-x_n) (x_{n-1}-x_n) (x_{n-2}-x_{n-1})}\\
C &  = &  y_n.
</MULTILINE>
Notice that the denominators are the same for both <M>A</M> and <M>B.</M>
So do not compute it twice.</LI>
<LI>Though we are talking about the interpolating <I>parabola</I>, actually
the interpolating polynomial has degree <I>less than</I> or equal to 2. So
you have to remember about the two boundary cases: when <M>p(x)</M> is of
degree 1, in which case it has just one root; and when <M>p(x)</M> has
degree 0, in which case you have no choice but to stop with a ``Failure''
message. </LI>
</OL>

<HEAD2>Real root isolation</HEAD2>
<B>Real root isolation</B> means identifying one interval per
distinct root of a polynomial such that there is no other root
inside that interval. This is generally used as a first step
before launching more precise methods (e.g., Newton-Raphson) to
pin point the roots.
<P/>
There are various methods to perform real root isolation. We
shall discuss the method using Sturm's sequence of a polynomial. 
The method works for polynomials that have no repeated root. Such
polynomials are also called <B>squarefree</B>.
<P/>
Let's start with an example. 

<EXM>
Suppose that we start with the polynomial 
<D>
p(x) = 8 + 22x + 21 x^2 + 24 x^3 + 13 x^4 + 2x^5. 
</D>
We shall now start creating a sequence of polynomials, called
the <B>Sturm's sequence</B>. The sequence starts
with <M>p_0(x),</M> which is always <M>p(x),</M> itself.
<P/>
The next polynomial, <M>p_1(x)</M> is always <M>p'(x).</M> Thus,
here 
<D>
p_1(x) = 22 + 42 x + 72 x + 52 x^3 + 10x^4. 
</D>
Soon it will become bothersome to write all the powers
of <M>x.</M> So it is better to write the polynomials as a list
of coefficients (in increasing powers of <M>x</M>). The first two
polynomials are then
<MULTILINE>
8 ~&~ 22 ~&~ 21 ~&~ 24 ~&~ 13 ~&~ 2\\
22 ~&~  42 ~&~ 72 ~&~ 52 ~&~ 10
</MULTILINE>
After this, the sequence proceeds like this: 
<Q><M>p_k = </M> negative of
the remainder of <M>p_{k-2}</M> divided by <M>p_{k-1}.</M></Q>
 Thus,
here 
<MULTILINE>
8 ~&~ 22 ~&~ 21 ~&~ 24 ~&~ 13 ~&~ 2\\\hline\\
22 ~&~  42 ~&~ 72 ~&~ 52 ~&~ 10\\\hline\\
-2.28 ~&~ -6.68 ~&~ 6.12 ~&~ 3.92\\\hline\\
-43.1643 ~&~ -109.824 ~&~ -32.2314\\\hline\\
-7.41164 ~&~ -12.729\\\hline\\
-9.85481
</MULTILINE>
We stop once we reach a nonzero constant polynomial (we are bound
to reach one such). 
</EXM>

<J>
f=:4 : 'y- (((#y)-#x)#0),x * (({:y) % {:x)'
s=:3 : '(>: (0=y) i: 0) {. y'
r=:s@f ^: (#@[ <: #@])
rm=:r^:_

p0=: 8  22 21 24 13 2
]p1=:  p.. p0
]p2=: - p1 rm p0
]p3=: - p2 rm p1
]p4=: - p3 rm p2
]p5=: - p4 rm p3
</J>


Next, we take some value of <M>x,</M> which is not a root
of <M>p(x).</M> We evaluate all the
polynomials there. We count the total number of sign changes in
the resulting requence of numbers (<M>0</M> may be counted as
either <M>+</M> or <M>-</M> or may be ignored, the answer will
not change). 
Call this <M>\sigma(x).</M> For example, in our example, the
sequence of values at <M>x=0</M> is
<D>
8, 22, -2.28, -43.1643, -7.41164, -9.85481.
</D> 
The sequence of signs is
<D>
+ + - - - -.
</D>
There is just a single sign change. So <M>\sigma(0) = 1.</M>

<CIMG web="sturm2.png">Sturm's sequence with <M>\sigma</M> values</CIMG>
<THM name="Sturm's theorem">
Let <M>a<b\in\rr</M> be two numbers that are not zeros
of <M>p(x).</M> Then <M>\sigma(a)-\sigma(b)</M> is the number of
real roots of <M>p(x)</M> in the interval <M>(a,b).</M>
</THM>

Before we see its proof. Let's put it to action. 

<EXM>
Find the number of real roots of the polynomial from the last
example in <M>(-10,0.9).</M>
<SOLN/>
If we evaluate all the polynomials at <M>x=-10</M> we shall get 
<D>
-92112,~~ 54802,~~ -3243.48,~~ -2168.06,~~ 119.878,~~ -9.85481.
</D>
Since the first number is nonzero, <M>-10</M> is not a zero
of <M>p(x).</M> The signs are 
<D>
-+--+-
</D>
There are 4 sign changes. In other words, <M>\sigma(-10)=4.</M> Next, we evaluate at <M>x=0.9</M> to get 
<D>
72.0163,~~ 162.589,~~ -0.47712,~~ -168.113,~~ -18.8677,~~ -9.85481
</D>
with signs
<D>
++----.
</D>
So <M>\sigma(0.9) = 1.</M>

<P/>
Thus, we conclude that there are <M>\sigma(-10)-\sigma(0.9) = 4-1
= 3</M> roots of <M>p(x)</M> in <M>(-10,0.9).</M>
</EXM>
We can keep on halving the interval until we get small intervals,
over each of which <M>\sigma</M> changes by exactly 1. Each of
these intervals, then is guaranteed to contain exactly one root.
<P/>

Here are some J
snippets to help you.

<J>
st=:p0,p1,p2,p3,p4,:p5
st p. _10 
* st p. _10
c=:+/@:(}.~:}:)@:*
</J>

<HEAD3>Proof</HEAD3>
The proof of the Sturm's theorem uses certain properties of the
Sturm's sequence that is visible from a plot:
<CIMG web="sturm.png">Sturm's sequence</CIMG>
<HIDE lab="how"><MSG>[Creating the plot in J]</MSG><HIDDEN>

<J>
f0=: p0 & p.
f1=: p1 & p.
f2=: p2 & p.
f3=: p3 & p.
f4=: p4 & p.
f5=: p5 & p.
x =: _0.7+200%~i.100
plot (]; f0,f1,f2,f3,f4,:f5) x
</J>
</HIDDEN></HIDE>

<P/>
The properties:
<OL>
<LI>Whenever <M>p_k</M> vanishes, <M>p_{k-1}</M>
and <M>p_{k+1}</M> (if they exist) are nonzero, and negatives of
each other. In particular, two consecutive polynomials cannot
have a common zero.
<Q><B>Proof idea:</B> <M>p_0</M> and <M>p_1</M> cannot have any
common zero because <M>p_0</M> is squarefree. <M>p_2</M> is
negative of the remainder of <M>p_0</M> divided by <M>p_1</M>,
i.e., <M>p_2</M> is like <M>-(p_0-</M>some multiple
of <M>p_1).</M> When <M>p_1=0,</M> we have <M>p_2 = -p_0.</M></Q>
</LI>
<LI>The last polynomial is a nonzero constant.
<Q><B>Proof idea:</B> By the construction, it cannot be zero.
<P/>
Can <M>p_n</M> be non-constant? No, because
then <M>p_n</M> must have at least one root (possibly complex),
and also it divides <M>p_{n-1}</M> (else the sequence would have
continued further). So at that zero of <M>p_n</M> is shared
by <M>p_{n-1},</M> leading to a
contradiction.</Q>
</LI>
</OL>
Now consider the function <M>\sigma(\cdot).</M> It is a step
function taking only integer values. 


<P/>

<B>FACT:</B> A jump can occur only at
the zeroes of <M>p_0</M>.
<P/>
<B>Proof:</B> Let <M>c</M> be a number that is <I>not</I> a zero
of <M>p_0.</M> It may be a zero for some or none of the
other <M>p_k</M>'s. If it is not a zero of any of
the <M>p_k</M>'s then the sign sequence does not change, and
so <M>\sigma</M> has no jump. If <M>c</M> is a zero of
some <M>p_k,</M> then look at the sign sequence
around <M>k</M>-th term: it must be like <M>-*+</M>
or <M>+*-</M>. Any such pattern must contribute exactly one sign
change, irrespective of the value of <M>*</M>. [QED}

<P/>

<B>FACT:</B> At each
zero of <M>p_0</M>, the <M>\sigma </M> function must jump down by
an amount 1. 
<P/>
<B>Proof:</B> Let <M>c</M> be a zero <M>p_0.</M> So it changes
sign there (since it is squarefree). There are two possible
cases: 
<CIMG web="cases.png">The two cases</CIMG>
In both cases the number of sign changes goes down by one, because
following the same argument
as in the last proof, the other <M>p_k</M>'s cannot contribute to
the sign change. Hence the result. [QED]

<P/>

Sturm's theorem is now an immediate consequence.

<HEAD2>How Matlab does it</HEAD2>
Matlab has a function called <CODE>roots</CODE> that finds all the roots of
a polynomial. For instance, to find the roots of the polynomial <M>1+2x+3x^2</M> you
issue the command 
<Q><CODE>roots([3 2 1])</CODE></Q> Matlab's algorithm works as
follows.

To compute all the roots
(including the complex ones) of a polynomial
<D>
a_0+a_1x+a_2x^2+\cdots+a_nx^n,
</D>
with <M>a_n\neq 0,</M> 
Matlab first forms its
{\em companion matrix}
<D>
<MAT>
-\frac{a_{n-1}}{a_n} &  \cdots & &  \cdots&  -\frac{a_{0}}{a_n}\\
 &  1 &  &  0 \\
 &   &  \ddots \\
&  0 &  &  1\\
&  &  &  &  -1
</MAT>
</D>
 The companion matrix has the given polynomial as
its characteristic polynomial (Check!) Now Matlab applies a suitable
eigenvalue finding algorithm 
to this matrix.


<DISQUSE id="nonlin2" url="https://www.isical.ac.in/~arnabc/numana/nonlin2.html"/>
@}
</NOTE>
