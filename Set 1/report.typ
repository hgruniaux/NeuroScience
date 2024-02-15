#set page(numbering: "1 of 1", number-align: center)
#set heading(numbering: "I.1.a.")
#set par(justify: true)
#set math.equation(numbering: "(1)")

#set page(margin: (top: 5em, bottom: 5em))

#align(center, stack(dir: ttb, spacing: 1em,
  text(size: 18pt, weight: "bold", "Homework 1"), text(style: "italic", "Hubert Gruniaux")))

= Introduction

The goal of this document is to test different models of infection spread $beta$. We first consider a naive model, only considering the infection rate. Then, we include a contact probability to improve the modelisation. Finally, we also add the possibility of recovering from an infection with a rate $gamma$.
Due to the simplicity of the models, a minimal mathematical study will be provided for each model.

In all models, we consider the total population count $N$ to be constant.

Code is available at https://github.com/hgruniaux/NeuroScience/tree/main/Set%201.

= First model : SI

== The equation

The first model is quite simple: each infected person has a chance to infect new people. The infection rate is given by the parameter $beta in RR_+$. The evolution of infected people is thus given by the following equation:

$
I_t = I_(t-1) + (beta) I_(t-1)
$

However, the model is not realistic. Indeed, for $t --> infinity$, we have $I_t --> infinity$. So, at one point, $I_t$ will be greater than $N$, the population count, which is absurd. To avoid that, the Python implementation clamps the result to $N$. In other terms, the following equation is used:

$
I_t = min(N, I_(t-1) + (beta) I_(t-1))
$

We can determine that $I_t = N$ when $t >= t_"end" =^"def" (log N - log I_0)/(log (1+beta))$.

== Results

#grid(columns: (1fr, 1fr), rows: (auto, auto), gutter: 0.5em,
[#figure(caption: [Evolution for $beta=0.02$ and $I_0=3$], image(width: 70%, "figures/si_002_3.svg")) <si_002_3>],
figure(caption: [Evolution for $beta=0.02$ and $I_0=42$], image(width: 70%, "figures/si_002_42.svg")),
figure(caption: [Evolution for $beta=0.04$ and $I_0=3$], image(width: 70%, "figures/si_004_3.svg")),
[#figure(caption: [Evolution for $beta=0.04$ and $I_0=42$], image(width: 70%, "figures/si_004_42.svg")) <si_004_42>]
)

We can observe that an increase in the rate of infection or in the initial number of patients results in a higher increase in the number of infected. In particular, the 100% infected threshold is reached quicker. The infected count is $N$ for $t = 178 "days"$ in @si_002_3, but for $t = 23" days"$ in @si_004_42.

Additionally, the evolution is exponential (in fact, mathematically speaking, $forall t, I_t = I_0 (1+beta)^n$ is an exponential). The more people are infected, the more they will be the next day.

== Conclusion

The growth and its links to $beta$ and $I_0$ is the same as what might have been expected in practice. However, the curves do not correspond to what we observe in the real world (see the brutal clamping at $N$).

= Second model : SI improved

== The equation

To improve the previous model, infection is spread only with a certain probability $S/N$ (probability of getting in contact with healthy people). Therefore, the new equation is:

$
I_t = I_(t-1) + (beta/N) I_(t-1) S_(t_1)
$

We can easily prove that $I_t -->_(t->infinity) N$ for $beta>0$ and $forall t, I_t <= N$.

== Results

#grid(columns: (1fr, 1fr), rows: (auto, auto), gutter: 0.5em,
[#figure(caption: [Evolution with $beta=0.02$ and $I_0=3$], image(width: 70%, "figures/si_improved_002_3.svg")) <si_improved_002_3>],
figure(caption: [Evolution with $beta=0.02$ and $I_0=42$], image(width: 70%, "figures/si_improved_002_42.svg")),
figure(caption: [Evolution with $beta=0.04$ and $I_0=3$], image(width: 70%, "figures/si_improved_004_3.svg")),
[#figure(caption: [Evolution with $beta=0.04$ and $I_0=42$], image(width: 70%, "figures/si_improved_004_42.svg")) <si_improved_004_42>]
)

First, we now observe that the model converges to $N$ and not towards $infinity$ (without clamping). Notably, $forall t, 0 <= I_t <= N$. So, it is, at least, more coherent than the first model.

Furthermore, increasing $beta$ or $I_0$ still translates to an increase in the infected count. For example, in @si_improved_002_3 we reach $S_t=I_t$ for $t approx 174 "days"$ and in @si_improved_004_42 for $t approx 8 "days"$. Which is what we may expect.

At last, the transition to the maximum $N$ is smoother and more in line with what we may observe in real conditions.

== Conclusion

Despite observing better results compared to the naive model, it is still imperfect. Indeed, we may mention that we rarely observe in nature a 100% proportion of the infected population after some time, but the model exhibits this behavior. Therefore, some information may still be lacking.

= Third model : SIS

== The equation

In the last model, we also take into account the possibility of recovering from an infection. This recovery rate is represented by $gamma in RR_+$ and included in the equation with the term $-gamma I_(t-1)$. Hence, the equation becomes:

$
I_t = I_(t-1) + (beta/N) I_(t-1) S_(t-1) - gamma I_(t-1)
$

We can prove that:
$
I_t -->_(t->infinity) I_infinity (sigma) =^"def" cases((1-1/sigma)N &"if" sigma >= 1, 0 &"if" sigma <= 1) 

$ with $sigma=beta/gamma > 0$. It also comes that $forall t, 0 <= I_t <= N$ and $forall sigma, 0 <= I_infinity (sigma) <= N$.

== Results

#grid(columns: (1fr, 1fr, 1fr), rows: (auto),
figure(caption: [Evolution with $gamma=0.001$], image(width: 100%, "figures/sis_1.svg")),
figure(caption: [Evolution with $gamma=0.006$], image(width: 100%, "figures/sis_6.svg")),
figure(caption: [Evolution with $gamma=0.009$], image(width: 100%, "figures/sis_9.svg"))
)

We observe that an increase in $gamma$ translates into a decrease in $I_infinity$. The more people are able to recover, the fewer people are infected at the same time. This is explained by the fact that the recovery rate is compensating the infection.

#figure(caption: [Infected curves for $sigma in {3,1,1/3}$], image(width: 33%, "figures/sis_sigma.svg"))

Moreover, in the last figure, we notice that if $sigma <= 1$ (infection rate is lower or equal to the recovery rate), then the infected count converges towards 0 (no more infected people). But otherwise, the infected count converges towards a value less than $N$ (not all the population can be infected, except when $sigma --> infinity$). This differs from the previous model, which always converged towards $N$.

== Conclusion

Taking into account the recovery rate changes the results. Now, the population cannot be totally infected at the same time, which is what we may observe in real conditions. Additionally, we still observe mostly the same growth and evolution for the same $beta$ and $I_0$ values as the previous model.

As a conclusion, this last model seems to be quite correct and still simple.
