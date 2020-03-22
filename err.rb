<NOTE>
@{
<M>\newcommand{\dig}{\underline{\quad}~~}</M>
<TITLE>Error analysis</TITLE>
<UPDT>SAT JAN 18 IST 2020</UPDT>
<HEAD1>Error analysis</HEAD1>
This page is going to shake your belief in digital computers. 
Let's start with a shocking example due to Hilbert.
<P/>

<EXM>We
all know that a real symmetric nonsingular matrix has a symmetric
inverse. Consider the <M>10\times 10</M> matrix with entries
<D>
a_{ij} = [[1][i+j]]\quad i,j=1,...,10.
</D>
Clearly, it is a real symmetric matrix. It is also
nonsingular (though it may  not be immediately obvious). Compute
its inverse using Gauss-Jordan method.
<SOLN/>
<J>
]h=:%+/~ 1+i.10
]%. h
</J>
Is it (even approximately) symmetric? 
</EXM> 

Once a student of ISI sent me an worried email about an
inexplicable behaviour of R. The next example is based on his email.

<EXM>
<R>
x = 1:100
i = 57/41 * 41
i
x[i]
x[57]
</R>
</EXM>
While such extreme examples are rare in practice, their existence makes
us worry about the accuracy of numerical methods.
<P/>
Other than programming bugs, there are two main reasons behind
errors in a numerical method:
<UL>
<LI>approximations used in the algorithm (e.g., approximating a
function by its tangent at a point),</LI>
<LI>inability of the computer to store real numbers exactly.</LI>
</UL>
In this page we shall focus our attention on this second point. 
We shall need to understand first how computers store number.

<HEAD1>Fixed point and floating point</HEAD1>
Generally computers use two methods to store and process numbers: <I>fixed
point</I> and <I>floating point.</I> In either method we have to first
choose a <I>radix</I> or <I>base</I> with respect to which the numbers
will be represented. In most computers (including IBM PCs and Sun) the
radix is 2 ({\em i.e.,} binary), in some machines 4 or 8 or even 16 is
used as the radix. There is a computer in Russia that uses 3 as its
radix. Most calculators use 10 as their radix. In this note we shall
mostly use 10 as the radix, because we, human beings, are more used to
the decimal system than the binary system.

<HEAD2>Fixed point</HEAD2>
Here we have a  number of digits and the decimal point is <I>fixed</I>
in one place. For instance, we may use 4 digits and fix the decimal place
between the second and third digits, like this:

<D>
\pm\dig\dig\bullet~~\dig\dig
</D>
We write <M>-3.4</M> as <M>-03.40</M> in this system. The number <M>-345</M> cannot
be represented in this system, nor the number <M>0.0001.</M> In the
first case we have a <I>fixed overflow</I> and in the second a <I>fixed
underflow.</I> Note that the prefixes over- and under- depend on the
absolute value of the number, and not on its sign.
Clearly, we can represent exactly <M>2\times10^4-1 =
19999</M> distinct numbers in this way (why did we subtract 1?). Notice
that these 19999 numbers are all equispaced in the number line at
intervals of <M>0.01.</M> 

<P/>

In fixed point arithmetic, we first try to perform the arithmetic as
usual. If the answer can be represented in the fixed point system, then we
output the result. Otherwise, we produce an overflow or underflow error,
as appropriate. For instance, <M>02.30\times00.10 = 00.23,</M> but 
<M>02.30\times00.01</M> produces fixed underflow.

<P/>

Thus, a fixed point arithmetic operation either produces the correct answer or
produces an error message. It never gives <I>approximate</I> answers. Most
general purpose computers allow only one type of fixed point numbers,
namely, integers. Here the (binary) point is fixed at the rightmost end,
like this:
<D>
\pm\dig\dig\dig\dig\bullet
</D> 
Actually, integers usually come in more than one flavours, depending on the
number of digits used. In C, for instance, we have <CODE>int</CODE>
<CODE>short</CODE> and <CODE>long</CODE>. Special purpose computers (like
the computer chip inside mobile phones) use fixed point numbers where the
point is somewhere in between. 

<P/>
A fixed point system is characterised by 3 things: the radix, the number
of digits and the location of the point.

 
<HEAD2>Floating point</HEAD2>
Here we do not hold the point fixed in one place, rather we let it
<I>float.</I> For example, if we make the decimal point "float"
just before the leftmost nonzero digit, then we shall
convert all the numbers <M>-234</M>, <M>-23.4</M> and <M>-0.0000234</M> to <M>0.234.</M>
<P/>
In the floating point representation the numbers are expressed
like
<MULTILINE>
-234 & = & -0.234 \times 10^3,\\
-23.4 & = & -0.234 \times 10^2,\\
-0.0000234 & = & -0.234 \times 10^{-4}.
</MULTILINE>
The following line shows the 4 different parts of the floating
point representation:
<CIMG web="fp.png">Parts of the floating point
representation</CIMG>
These 4 parts are:
<UL>
<LI>the sign (red minus above)</LI>
<LI> a radix  (the green 10 above).</LI>
<LI> the mantissa (the blue 234)</LI>
<LI>the exponent (the purple <M>-4</M>)</LI>
</UL>
A typical floating point system uses radix <M>2</M> (though
calculators use 10). A number <M>m</M> of digits is allocated to
store the mantissa. Similarly, a number <M>e</M> of digits are
allocated for storing the exponent. A single bit stores the sign.
<P/>

 Thus, if the radix is is <M>r=10</M> and 
<M>m=4,e=2</M> the number 
<M>2.34</M> is stored with mantissa <M>2340</M> and exponent <M>01.</M>
Similarly, the number <M>0.00234</M> has mantissa <M>2340</M> and exponent
<M>-03.</M> The mantissa always starts with a nonzero digit (unless the
number is zero.) If a number has mantissa <M>M</M> and exponent <M>E</M>
then it is <M>Mr^{E}.</M>

<EXM> How many distinct numbers can be stored using
<M>m</M> mantissa digits and <M>e</M> exponent digits if the radix is
<M>r?</M><SOLN/>
 It is   
<D>
4\times (r^{m+e} - r^e+1).
</D>
It is because, there are <M>r^{m+e}</M> possible digit patterns, of which
<M>r^e</M> correspond to 0, and hence contribute only one distinct
number. The multiplier 4 is because both the mantissa and the exponent can
be positive or negative.
</EXM>

Notice that to store a floating point number we need space for <M>m+e</M>
digits and two signs. To store a fixed point number with <M>k</M> digits
we need space for the <M>k</M> digits plus one sign. If <M>r=2</M> then
each sign takes the space of one digit. Thus, if we have space for <M>L</M> digits
then we can exactly represent either <M>2^{L}-1</M> fixed point numbers, or  
<M>2^L-2^e+1</M> floating point numbers. Thus, we can represent fewer
floating point numbers exactly if <M>e>1.</M> However, there is one great
advantage of floating point numbers: they cover a much wider range. If
<M>r=10,m=3,e=2</M> the smallest positive number that can be represented
exactly is <M>10^{-99}</M> while the largest is <M>999\times10^{99}.</M>
Using <M>r=10,k=m+e=5,</M> the corresponding minimum and maximum are
<M>\{10^{-5},0.99999\}</M> if the point is at the left extreme, and
<M>\{1,99999\}</M> if the point is at the right extreme. 

<P/>

Also, the numbers
that can be represented exactly in floating point are not regularly spaced
like their fixed point counterparts. The numbers close to zero are densely
spaced, while the numbers with large magnitudes are sparse. This irregular
spacing is in a sense compatible with the way we, human beings, perceive
numbers. When talking about large numbers we tend to ignore large errors,
while for small numbers even slight errors count. In other words, we are
more interested in <I>relative errors</I> than <I>absolute errors.</I> 
A person who hardly minds if an air fare increases by Rs 100, is often
greatly annoyed to pay an extra Rs 5 for a dozen bananas!

<P/>

This similarity of floating point numbers with our love for relative
errors makes floating point numbers ideal for approximation. This is done
in two standard ways. The more popular way (used by IBM PCs and Sun) is
called <I>rounding towards zero.</I> If a number cannot be represented
exactly in a floating point format, then approximate it by the number
nearest to it towards zero. The other method is called <I>truncation.</I>
Here we just chop off the part of the mantissa that we cannot store.

<P/>

This is done only for the mantissa. If the exponent turns out to be too
large, then we have a <I>floating overflow.</I> Note that we do not have a
floating underflow. If the exponent is too small, the number is
approximated by zero.
 
<HEAD2>Trash digits</HEAD2>
Suppose that we have measured a length up to the nearest
centimetre and are reporting the length in metres. A typical
number could be 2.23. Had we measured it up to the nearest
millimetre, then the answer could have been 2.231. Thus, we human
beings usually report as many decimal places as we are sure
about. As a result, 2.230 and 2.23 have a difference. In the second
case, we have measured up to the nearest millimetre, and in the
first case only up to nearest centimetre.
<P/>
A computer, however, does not follow this norm. It allocates a
fixed number of digits and fills up unnecessary digits with 0's. 
Thus, both 2.23 and 2.230 will be stored as 2.23000, if the
computer is using 6 digits. In the first case, the last three 0's
are just trash, and in the second case, the last two 0's are
trash.

<P/>
Trash digits may be nonzero also. For example, if you halve the
length, then in both the cases you'll get 1.11500. The last two
0's are of course trash. But even the 5 is trash in the first case.

<P/>
The concept of trash digits is present in both fixed point and
floating point representations.

<HEAD2>Significant digits</HEAD2>
Consider the numbers 23.406 and 0.000023456. In both these
numbers the significant digits are 2,3,4,0,6. These are the
numbers in the decimal (or binary) expansion <B>starting with
the leftmost nonzero digit</B>. If you want
to report these two numbers up to 5 decimal places, then you'll
write 23.40600 and 0.00002, respectively. But if you report them
up to 5 significant digits, then you'll write 23.406 and 0.000023406.
<P/>
A digit may be both significant as well as trash. In the length
halving example, we had 1.11500. If we had measured up to the
nearest centimetre, then the result is correct only up to 3
significant digits (the trailing 500 being trash).

<HEAD2>Arithmetic operations</HEAD2>

As we have already pointed out both fixed point and floating
point representations can accommodate only finitely many
numbers. It is quite possible where performing some arithmetic
operation (addition, multiplication etc), the inputs are
representable, but the output is not. For fixed point
representations, the computer prints an error message in this
case. But, for floating point representations, the computer
produces approximate answers. We shall discuss the process for
addition and subtraction first.

<HEAD3>Addition and subtraction</HEAD3>

<EXM>
Suppose that we want to add 23.4 with 0.0234 where both are
represented in the <M>(r=10,m=4,e=2)</M> format:
<MULTILINE>
23.4 & = & 0.234\times 10^{2}\\
0.0234 & = & 0.234\times 10^{-2}
</MULTILINE>
These will be stored like:
<CIMG web="fpad1.png"></CIMG>
While adding, the smaller exponent will be increased until it
equals the larger exponent:
<D>
0.234\times 10^{-2} = 0.000234\times 10^{2}.
</D>
This is stored like:
<CIMG web="fpad2.png"></CIMG>
Notice how the trailing 3 and 4 have been swept out. So we now
have 
<D>
0.0002\times 10^{2}.
</D>
This is where the error enters. 
 Finally, the computer adds the two stored mantissas to get 
<D>
(0.2340 + 0.0002)\times10^2 = 0.2342\times 10^2,
</D>
which is stored as:
<CIMG web="fpad3.png"></CIMG>
</EXM>
This example should make one thing clear:
<Q>
<ALERT/> If a small number is added (or subtracted) from a large number,
then the small number suffers loss of digits.
</Q>
This should also show that the digital addition function is not
associative: Subtracting lots of small numbers from a large
number one at a time produces different result from subtracting
the sum of the small numbers from the large number.

<P/>
Here is an example that will show another pitfall.

<EXM>
We want to subtract 0.23456354 from 0.23456367. We are using
radix 10 <M>e=2</M> and and <M>m=8,</M> which is large enough to hold these
numbers exactly:
<CIMG web="fpsb1.png"></CIMG>
 The exact subtraction produces 0.00000013.

<P/>
Now, while storing in floating point representation, the decimal
point will float to the left of the first nonzero digit to
produce
<D>
0.13\times 10^{-6}.
</D>
This will be stored as
<CIMG web="fpsb2.png"></CIMG>
Notice that all the trailing 0's are just trash digits. 
</EXM>
The pitfall is:
<Q>
<ALERT/> If a subtraction performed between two numbers that match up to
many significant digits, then the result contains many trailing
trash digits. 
</Q>

<EXM>
Mathematically, 
<D>
[[1-\cos^2 x][x^2]] = [[\sin^2 x][x^2]],
</D>
whenever <M>x\neq 0.</M> Also, the limit as <M>x\to0</M>
is <M>1.</M> Try out the computation for <M>x=5\times
10^{-10}.</M>
<SOLN/>
<R>
x=5e-10
(1-cos(x)^2)/x^2
sin(x)^2/x^2
</R>
</EXM>

<EXM>
We know that one root of <M>ax^2 + bx + c = 0</M> is
<D>
[[-b+\sqrt{b^2-4ac}][2a]].
</D>
Use this formula to find the root of <M>3x^2 + 10^9 x + 100
= 0.</M> Then evaluate the quadratic at this root. Explain what you find.
<SOLN/>
<R>
a = 3; b = 1e9; c = 100
r = function() (-b+sqrt(b^2-4*a*c))/(2*a)
q = function(x) a*x*x + b*x + c
q(r())
</R>
Here the root suffers terribly from loss of significant digits. A way to remedy 
this is to use the alternative formula:
<D>
[[2c][-b-\sqrt{b^2-4ac}]].
</D>
In R
<R>
r.alt = function() 2*c/(-b-sqrt(b^2-4*a*c))
q(r.alt())
</R>
</EXM>

<HEAD3>Multiplication and division</HEAD3>
It is difficult to give the exact procedures used for
multiplication and division of floating point numbers. But the
following pitfall is pretty obvious:
<Q>
<ALERT/> Multiplication by large number (or division by a small number)
will amplify the error.
</Q>

<EXM>
We continue with the last example. Now we focus on the other root:
<R>
a = 3; b = 1e9; c = 100
r = function() (-b-sqrt(b^2-4*a*c))/(2*a)
q = function(x) a*x*x + b*x + c
q(r())
</R>
</EXM>

<HEAD1>Four approaches</HEAD1>
The approximate nature of floating point arithmetics is a source
of headache for numerical analysists. Roughly speaking, there are
four ways to attack this problem:
<OL>
<LI>Express the operations mathematically, and work with them
instead of the ideal operations. This is impossibly complicated,
owing to the fact that the operations are not even
associative. So people have come up with somewhat better-behaved
approximations that are less accurate. The hope is to produce an
upper bound for the error. Unfortunately, the resulting upper
bounds are usually atrociously large.</LI>
<LI>Add a little random jitter to the inputs, and study the
effect on the output. This is usually easy to do, and provides
an idea about the instability of the algorithm.</LI>
<LI>Perform interval arithmetic, i.e., consider each input as an
interval (e.g., 3.2 metre up to nearest centimetre
is <M>[3.15,3.25)</M> metre). The resulting mathematics turns
out to be complicated, though some successes have been
reported.</LI>
<LI>Identifying high-level symptoms that potentially lead to
high numerical error.</LI>
</OL>
We shall discuss one such high level symptom now.


<HEAD1>Condition number</HEAD1>
We have seen that division by a very small number is a potential
source of numerical error. By analogy it seems natural to expect
that inverting a nearly singular matrix should also pose similar
problem. The high-level symptom that we are talking about here is
"nearly singular". We need to devise a way to measure it
quantitatively. The first guess that comes to mind is the
absolute value of the determinant. But that is not a good
measure. For instance, an <M>n\times n</M> diagonal matrix with all
entries equal to <M>[[12]]</M> has determinant <M>2^{-n}\to
0,</M> yet we have no numerical instability in inverting it.
<P/>
A better way to measure "nearness to singularity" is via the
condition number:
<DEFN name="Condition number">
For a real nonsingular matrix <M>A,</M> the condition number is
defined as
<D>
\kappa(A) = \sqrt{[[\mbox{max eigenvalue of <M>A'A</M>}][\mbox{min
eigenvalue of <M>A'A</M>}]]}.
</D>
</DEFN>
Generally, we want to avoid larger condition numbers. But this
does not mean that matrices with large condition numbers are
always bad. It means matrices with low condition numbers are good.
See Theorem 2.7.1 of Golub's book Matrix Computations for a more
rigourous statement. 

<P/>
One consequence of this is that orthogonal matrices are nice
things to work with, because if <M>A</M> is orthogonal, then its
condition number must be 1.
<P/>
This is why <M>QR</M> decomposition is the preferred way to solve
the least squares problem, instead of the normal equations.
<DISQUSE id="err" url="https://www.isical.ac.in/~arnabc/numana/err.html"/>

@}
</NOTE>
