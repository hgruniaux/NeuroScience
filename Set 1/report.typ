
#set page(numbering: "1 of 1", number-align: center)
#set math.equation(numbering: "(1)")

= Introduction

We consider the population count $N$ to be constant.

= First model : SI

The first model is quite simple : each infected people has a chance to infect new people. The infection rate is given by the parameter $beta in RR_+$. The evolution of infected people is thus given by the following recurrent equation :

$
I_t = I_(t-1) + (beta) I_(t-1)
$

The figure TODO gives the results for a one year simulation with $beta = 0.02$ and $I_0=3$. Notice, that the graph do not correspond exactly to the equation : it is truncated over $N=100$. Indeed, in this problem, and with $beta > 0$, we have $I_t -->_(t-> infinity) +infinity$

= Second model : SI corrected

$
I_t = I_(t-1) + (beta/N) I_(t-1) S_(t_1)
$

= Third model : SIS

$
I_t = I_(t-1) + (beta/N) I_(t-1) S_(t-1) + gamma I_(t-1)
$
