<NOTE>
@{<TITLE>Numerical Integration</TITLE>
<UPDT>THU FEB 20 IST 2020</UPDT>
<HEAD1>Numerical Integration</HEAD1>
Suppose that we are given a function <M>f(x),</M> and we are to compute
<D>
\int_a^bf(x)\,dx,
</D>
where <M>a,b</M> are given numbers. One method
 is to first find an indefinite integral of <M>f(x):</M>
<D>
F(x) = \int f(x)\,dx,
</D>
and then to compute <M>F(b)-F(a).</M> This method depends on our ability to compute the
indefinite integral <M>F(x).</M> There are many situations where computing
<M>F(x)</M> is difficult or even impossible. In such cases, we resort to
<B>numerical integration</B> or <B>quadrature.</B> A numerical integration
method has the advantage that we do not need to find the indefinite
integral, but it has the disadvantage that the answer may be approximate. 
There are many different methods of numerical integration. In this page,
we shall learn two such techniques, both belonging to a family called
<B>Newton-Cotes quadrature</B>.

<HEAD2>Trapezium rule</HEAD2>
First we split <M>[a,b]</M>  into  a grid of equally spaced <M>x</M>-values, and evaluate <M>f(x) </M> at those points:
<CIMG web="trap1.png">Take a grid of <M>x</M>-values</CIMG>
Then we join the points  by line segments: 
<CIMG web="trap2.png">Continuous piecewise linear approximation</CIMG>
Each piece is a trapezium:
<CIMG web="trap3.png">This trapezium has
 area <M>[[12]](y_{k-1}+y_k)\times\delta x</M></CIMG>
We add the areas of all the trapeziums to approximate <M>\int_a^b f(x)\, dx.</M>
<BOX name="Trapezium rule">
Choose some positive integer <M>n.</M> Split the interval <M>[a,b]</M>
into <M>n</M> equal parts using the break points 
<D>x_0,x_1,...,x_n,</D> 
 where <M>x_i = a + i\delta
 x.</M>  Here <M>\delta x = [[b-a][n]].</M>
Note that <M>x_0 = a </M> and <M>x_n = b.</M>
<P/>
Next, we compute
<D>
y_i = f(x_i)\mbox{   for } i=0,1,...,n.
</D>
Then the trapezium rule is the approximation
<D>\int_a^bf(x)\,dx\approx [[\delta x][2]]\{y_0+2(y_1+\cdots+y_{n-1})+y_n\}.</D>
</BOX>


<EXM>
Compute 
<D>
\int_1^2\frac{1}{\sqrt{2\pi}} e^{-x^2/2}\,dx,
</D>
by trapezium rule using <M>n=5.</M> We split the interval <M>[1,2]</M>
into 4 equal parts and compute <M>y_i</M>'s.
<PRE>
i     y
-----------
0    0.2420
1    0.1826
2    0.1295
3    0.0863
4    0.0540
</PRE>
So by applying trapezium rule the integral is approximately 
<D>
{0.25\over2}\times[0.2420 + 2\times(0.1826+0.1295+0.0863) +0.0540] = 0.1366.
</D>
It is instructive to compare this with the actual value, which is 0.1359.
</EXM>
The following J code allows you to use a finer grid:
<J>
trap=:0.1 * 0.5 *  {.+{: + 2*+/@: }.@ }:
x=: 1+(i.11) % 10
y=: (^-x*x%2) % %: 2p1
trap y
</J>

<HEAD2>Simpson's rule</HEAD2>
<COMMENT>
f = function(x) 2+sin(x)
a = 0; b = 7*pi

para = function(i) {
  x = xlo[i:(i+2)]
  y = f(x)
  mat = cbind(rep(1,3), x, x^2)
  coef = solve(mat,y)
  
  xplot = seq(xlo[i],xlo[i+2],len=100)
  yplot = coef[1] + coef[2]*xplot + coef[3]*xplot^2
  lines(xplot,yplot,lwd=3,col='red')
}
xhi = seq(a,b,len=1000)
yhi = f(xhi)
xlo = seq(a,b,len=11)
ylo = f(xlo)

png('image/simp.png')
plot(xhi,yhi,xlab="x",ylab="y",ty='l',lwd=3)
br = seq(1,11,2)
for(i in br[-length(br)]) para(i)
segments(xlo[br],rep(0,length(br)), xlo[br],ylo[br],lty=2)
dev.off()
</COMMENT>
In trapezium rule we interpolated by straight lines, i.e.,
polynomials of degree <M>\leq 1.</M> If we use polynomials of
degree <M>\leq 2</M>, then we may expect better accuracy. To fit
such a polynomial, we need three points. So we split  the
interval into an <I>even</I> number of subintervals, and fit a parabola (i.e., 
polynomial of degree <M>\leq 2</M>) over two consecutive
subintervals, i.e., first parabola over subintervals 1 and 2, the next parabola over subintervals 3 and 4, etc.
<CIMG web="simp.png"><M>y=\sin x</M> shown in black. Parabolas
in red</CIMG>
We may work out the exact formulae for the fitted polynomials,
then integrate them, and add. But there's a simpler method.
<P/>
Focus on a single pair of consecutive subintervals,
say <M>[x_0,x_1]</M> and <M>[x_1,x_2].</M> We can see
that the answer is going to be like <M>\delta x\times(a y_0 + b y_1 + c y_2).</M> 
<HIDE lab="oops"><MSG>(Why?)</MSG><HIDDEN>
In general, the area is going to depend
on <M>x_0,x_1,x_2,y_0,y_1,y_2</M>. Now we shall perform some
simple geometric transformations of the region to guess the form
of this function:
<UL><LI>First, translating
the <M>x_i</M>'s by a fixed amount (keping the <M>y_i</M>'s
fixed) is not going to change the area. So the area depends
on <M>x_i</M>'s only through <M>\delta x.</M></LI>
<LI>If the region is stretched horizontally by some factor
(keeping the vertical direction unaffected), then the area also
gets multiplied by the same factor. So <M>\delta x</M> must
occur as a multiplicative factor. Thus, the area must be of the
form <M>\delta x\times</M>some function of the <M>y_i</M>'s.</LI>
<LI>If the region is stretched vertically by some factor, the
area gets multipled by the same factor. So the area must be of
the form <M>\delta x\times (ay_0+by_1+cy_2),</M> for some
constants <M>a,b,c.</M>
</LI>
</UL>
</HIDDEN></HIDE>
<P/>

If our integrand were indeed a polynomial of degree <M>\leq
2</M>, then this should give us the exact answer. In particular,
this should give us the exact answer if the integrand
were <M>1</M> or <M>x</M> or <M>x^2.</M> This will give us three
equations in three unknowns. Solving them you'll get <M>a = c=[[13]]</M> and <M>b=[[43]].</M>
<P/>

<BOX name="Simpson's rule">
As in trapezium rule we need to subdivide the interval <M>[a,b]</M> into
<M>n</M> equal parts. But for Simpson's rule <M>n</M> needs to be an even
number, say <M>2k.</M> Evaluate <M>f(x)</M> at the subdivision points to get
<D>
y_0,y_1,...,y_{2k}.
</D> 
But now use the following formula
<MULTILINE>
\int_a^bf(x)\,dx &  \approx &  \frac{\delta x}{3}\left[(y_0+y_{2k})\right.\\
                         & &   + 2(y_2+y_4+\cdots+y_{2(k-1)}) \\
  & &  + \left. 4(y_1+y_3+\cdots+y_{2k-1} )\right]. 
</MULTILINE>
</BOX>

<EXM>
Now let us compute the integral from the last example using Simpson's
rule. We shall again use <M>n=4.</M> This time the value is
<MULTILINE>
\frac{0.25}{3}\times\left[\right.  \times  (0.2420+0.0540)\\
 &  + & \left.2\times(0.1295) + 
 4\times(0.1826 + 0.0863)\right] = 0.1359,
</MULTILINE>

which is correct up to 4 decimal places. Notice how Simpson's rule gives
more accurate value here than the trapezium rule, though we have used
the same <M>n</M> in both methods.
</EXM>

<J>
x=: 1+(i.11) % 10
y=: (^-x*x%2) % %: 2p1
ev=:2 4 6 8
od=:1 3 5 7 9
0.1* (%3) * (+/0 10{ y) + (2*+/ ev{y) + 4*+/od{y
</J>

<HEAD1>Monte Carlo integration</HEAD1>
This is a rather different approach that is conceptually very
simple. Here we consider a definite integration problem as a
problem of finding the area of a region. The approach is best
explained by an example. 

<EXM>
Suppose that we want to find the value of <M>\pi.</M> We consider
this as the problem of finding the area of a unit circle. First,
we bound the circle in a simpler region, say a square, as shown
below. 
<CIMG web="cinsq1.png">Circle in square</CIMG>
Now pretend that this square is a target board for dart throwing,
and a child is throwing darts randomly at the board in a way that
each point is as likely to be hit as any other point. Then the
chance of a random dart landing in any given region is
the area of that region divided by the area of the square (which
is <M>(1+1)^2 = 4</M>). 
A typical throw of 16 darts may produce a result like this:
<CIMG web="cinsq2.png">16 random throws</CIMG>
Here the event "hitting the circle" has occured for 10 out of 16
cases, so the sample proportion is <M>p_{16}=[[10][16]] =
[[58]].</M> By laws of large numbers, we expect
<D>
[[\pi4]]\approx [[58]],
</D>
or <M>\pi\approx 2.5.</M> This is of course a rather poor
approximation, but the accuracy improves with increasing number
of throws. As "randomly dart-throwing children" may not be easily
available, we shall employ a computer for that purpose. We set up
a coordinate system as follows. 
<CIMG web="cinsq3.png">Coordinate system</CIMG>
A random dart hit is now <M>(X,Y),</M> where <M>X,Y</M> are
independent <M>Unif(0,1)</M> random variables. Checking if the
dart has hit the disc is simply checking whether <M>X^2+Y^2 <
1.</M> The following J code implements the idea.
<J>
p=: _1+2*? 2 1000 $ 0
in=:1>+/*~ p
'dot; pensize 3' plot ;/|: in # |:p
0.004*+/in
</J>
</EXM>

We shall now use the idea to approximate an integral of the
form <M>\int_a^b f(x)\, dx.</M> Since we shall be approximating
integrls using probabilities, we have to make sure that <M>f</M>
does not change sign in the interval <M>[a,b].</M> Let's assume
that <M>f(x)\geq 0</M> over the entire interval. Let <M>M>0</M> be
some known upper bound for <M>f.</M> Then the graph may be put
inside a rectangle as follows:
<CIMG web="ginrc1.png">Graph in rectangle</CIMG> 
Again we throw darts randomly at the rectangle and find the
proportion of darts hitting the shaded region. Mathematically, we
generate <M>X,Y</M> independently with <M>X\sim Unif(a,b)</M>
and <M>Y\sim Unif(0,M).</M> Then we check the proportion of cases
for which <M>Y < f(X).</M> The following J code snippet
implements this idea for <M>f(x) = x^2</M> over <M>[0,1]</M> with
upper bound <M>B=1.5.</M> 
<J>
x=: ? 1000 $ 0
y=: 1.5 * ? 1000 $ 0
0.0015 * +/ y < x*x
</J>
This technique may be used to approximate the area of any region
that may be bounded in a box and for which we may test
containment. It easily extends to higher dimensions (volume,
hypervolume etc). 

<P/>

<DISQUSE id="numint1" url="https://www.isical.ac.in~/arnabc/numana/numint1.html"/>
@}
</NOTE>
