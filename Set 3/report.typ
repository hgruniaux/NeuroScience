#set page(numbering: "1 of 1", number-align: center)
#set heading(numbering: "I.1.a.")
#set par(justify: true)
#set math.equation(numbering: "(1)")

#set page(margin: (top: 5em, bottom: 5em))

#align(center, stack(dir: ttb, spacing: 1em,
  text(size: 18pt, weight: "bold", "Homework 3"), text(style: "italic", "Hubert Gruniaux")))

= Introduction

= Part 1: Neuron with self-connection

In the first part we start with a simple model for neurons. The firing rate $r$ of the neuron is described by the following differential equation:

$
(d r(t)) / (d t) = -r(t) + f(w r(t) + I)
$ <part1_without_noise>

with 
- $omega$, the synaptic strength,
- $I$, the external input and
- $f(s)$ = 60(1+tanh(s)), the activation function. The curve of $f$ is given as a reference in @tanh. Some notable points: $f(s) -->_(s-> -infinity) 0$, $f(s) -->_(s -> +infinity) 120$ and $f(0)=60$.

#figure(caption: [Plot of the activation function $f(s)=60(1+tanh(s))$], image("figures/tanh.svg", width: 50%)) <tanh>

Unless explicitly specified, the constants $omega$ and $I$ are taken as $0.05 "nA" dot "Hz"^(-1)$ and $-3 "mV"$ respectively the rest of the section.

The @part1_dynamics_without_noise show the solutions of the @part1_without_noise for some initial conditions (namely $r(0) in {50,60,61}$). We see that depending on the initial condition, the solution converge towards different fixed points.

In particular, the special case $r(0)=60=^"def" r_"crit"$ gives a constant solution (that is equals to $60$ obviously). However, if $r(0) < r_"crit"$, the solution converges towards $min f = 0$, and if $r(0) > r_"crit"$, the solution converges towards $max f = 120$.

#figure(caption: [Plot of the dynamics for different initial conditions], image("figures/part1_dynamics_without_noise.svg", width: 50%)) <part1_dynamics_without_noise>

A more interesting case (and more realistic) appears when we introduce some noise into the @part1_without_noise:
$
(d r(t)) / (d t) = -r(t) + f(w r(t) + I) + sigma eta(t)
$ <part1_with_noise>
where $eta$ is a gaussian white noise and $sigma in RR_+$ the noise amplitude. Of course, we retrieve @part1_without_noise when $sigma=0$ (no noise).

The solutions of @part1_with_noise are given in @part1_dynamics_with_noise for different initial conditions and $sigma$.

#figure(caption: [Plot of the dynamics for different initial conditions and noise amplitude], image("figures/part1_dynamics_with_noise.svg")) <part1_dynamics_with_noise>

#figure(caption: [The derivative $(d r) / (d t)$ as a function of $r$ for $omega=0.05 "nA" dot "Hz"^(-1)$ and $I=-3 "mV"$], image("figures/part1_flux.svg", width: 70%)) <part1_state_space>

The cancellation points on the @part1_state_space correspond to fixed points in the system (points of convergence of the solutions). In this case, we find the three fixed points we've already encountered: $0$ (due to numerical instability, we got 1 on the diagram), $60$ and $120$.

If we plot the count of zeros (fixed points) as a function of $omega$, the synaptic strength, and $I$, the external input, we get the bifurcation diagram shown in @bifurcation_diagram.

#figure(caption: [Bifurcation diagram (count of zeros of the curve $dot(r)$ as a function of $r$)], image("figures/part1_bifurcation_diagram.svg", width: 70%)) <bifurcation_diagram>

The yellow part correspond to three concellation points, whereas the purple part correspond to one concellation point. As a remainder, the concellation points in the state space are linked to the fixed points of the dynamic system.

We observe that the weaker the external input and the lower the sypnatic force, the more unstable the system (more fixed points). We also note that it's mainly the sypnatic force that reduces the number of fixed points (when it's large). The external input has less impact.

= Part 2: Mutual excitation

Let be the two following functions:
$
F_1 : x,y & |-> -x + f(omega_2 y + I) \
F_2 : x,y & |-> -y + f(omega_1 x + I)
$
with $f(s)=50 sigma(s)$ and $sigma(s)=(1+e^(-s))^(-1)$. The function $f$ is the activation function and $f(RR)=[0,50]$ with $f(s) -->_(s->-infinity) 0$ and $f(s) -->_(s->+infinity) 50$.

Then, the firing rate model is described by the following system of differential equations:
$
dot(x)(t) & = F_1(x(t),y(t)) \
dot(y)(t) & = F_2(x(t),y(t))
$
with $dot(x)(t) = (d x)/(d t)(t)$ and $dot(y)(t) = (d y)/(d t)(t)$.

#figure(caption: [Trajectories in the state space for random initial conditions (and nullclines)], image("figures/part2_state_space.svg", width: 80%))

The two dashed lines are the nullclines of the system. Their crossing points indicates the fixed points of the system. Indeed, we can observe that the different trajectories converges towards one of those points.

We can see that the points at $(0,0)$ and $(50,50)$ appear to be stable. The point at $(25,25)$, on the other hand, appears to be unstable (no random trajectory converges on it).

Then the Jacobian matrix of the system is
$
J(x,y)=mat((diff F_1)/(diff x)(x,y), (diff F_1)/(diff y)(x,y); (diff F_2)/(diff x)(x,y), (diff F_2)/(diff y)(x,y))
$

Now we have:
$
(diff F_1)/(diff x)(x,y) &= (diff F_2)/(diff y)(x,y) = -1 \
(diff F_1)/(diff y)(x,y) &= 50 omega_2 sigma(omega_2 y + I)(1 - sigma(omega_2 y + I)) \
(diff F_2)/(diff x)(x,y) &= 50 omega_1 sigma(omega_1 x + I)(1 - sigma(omega_1 x + I))
$

And with the assumption $omega_1=omega_2=omega$,we get
$
forall x, y, tr(J(x,y)) = -2 < 0
$
And
$
forall x, y, det(J(x,y)) = 1 - 2500 omega^2 sigma(omega x + I) sigma (omega y + I) (1-sigma(omega x + I)) (1 - sigma(omega y + I))
$

= Part 3: Hopfield neural network

#let sign = $op("sign")$;

Let $p_1, ..., p_n in RR^d$ be the $n$ patterns, then we define the weight matrix $W$ to be:
$
W = 1/N sum_(i=1)^n p_i p_i^T
$

#figure(caption: [Different weight matrices $W$], gap: 1em, stack(dir: ltr,
figure(caption: [For the cat pattern], supplement: [Subfigure], image("figures/part3_mat_w_cat.svg", width: 50%)),
figure(caption: [For the cat + man patterns], supplement: [Subfigure], image("figures/part3_mat_w_cat_man.svg", width: 50%))))

The dynamics of the network is given by the following system:
$
dot(x)(t) = -x(t) + sign(W x(t)) + sigma eta(t)
$
with
$
sign(x) = cases(
  +1 &"if" x > 0, 
  0 &"if" x = 0, 
  -1 &"if" x < 0)
$
and where $eta$ is a gaussian white noise and $sigma in RR_+$ the noise amplitude.

$
d = 16 times 16 = 256
$



#figure(caption: [The cat and man patterns], stack(dir: ltr, spacing: 1em, image("figures/part3_cat.svg", width: 50%), image("figures/part3_man.svg", width: 50%)))
