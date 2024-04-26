#set page(numbering: "1 of 1", number-align: center)
#set heading(numbering: "I.1")
#set par(justify: true)
#set math.equation(numbering: "(1)")

#set page(margin: (top: 5em, bottom: 5em))

#align(center, stack(dir: ttb, spacing: 1em,
  text(size: 18pt, weight: "bold", "Homework 3"), text(style: "italic", "Hubert Gruniaux")))

#let todo(body) = rect(inset: 1em, stroke: 3pt + red, fill: red.lighten(50%), width: 100%)[
  *TODO*: #body
]

#outline(indent: auto)

= Introduction

In this report, we embark on a journey through diverse mathematical models to understand the intricate dynamics of neural systems. Our exploration begins with self-connected neurons, followed by models featuring mutual excitation, Hopfield neural networks, and concludes with a PCA study on a specialized "ring" network model. 

The various studies focus mainly on the mathematical aspects of the underlying dynamic systems. Analytical and qualitative fixed-point studies are provided.

The different parts are mostly independent.

#pagebreak()
= Neuron with self-connection

== The model

In the first part we start with a simple model for neurons: a neuron with an autapse -- a chemical or electrical synapse from the neuron to itself. The firing rate $r$ of the neuron is described by the following differential equation:

$
(d r(t)) / (d t) = -r(t) + f(w r(t) + I)
$ <part1_without_noise>

with 
- $omega$, the synaptic strength,
- $I$, the external input and
- $f(s)$ = 60(1+tanh(s)), the activation function. The curve of $f$ is given as a reference in @tanh. Some notable points: $f(s) -->_(s-> -infinity) 0$, $f(s) -->_(s -> +infinity) 120$ and $f(0)=60$.

#figure(caption: [Plot of the activation function $f(s)=60(1+tanh(s))$], image("figures/tanh.svg", width: 50%)) <tanh>

Unless explicitly specified, the constants $omega$ and $I$ are taken as $0.05 "nA" dot "Hz"^(-1)$ and $-3 "mV"$ respectively the rest of the section.

== Study of the dynamics

The @part1_dynamics_without_noise show the solutions of the @part1_without_noise for some initial conditions (namely $r(0) in {50,60,61}$). We see that depending on the initial condition, the solution converge towards different fixed points.

In particular, the special case $r(0)=60=^"def" r_"crit"$ gives a constant solution (that is equals to $60$ obviously). However, if $r(0) < r_"crit"$, the solution converges towards $min f = 0$, and if $r(0) > r_"crit"$, the solution converges towards $max f = 120$. Therefore, three fixed points are conjectured.

#figure(caption: [Plot of the dynamics for different initial conditions], image("figures/part1_dynamics_without_noise.svg", width: 50%)) <part1_dynamics_without_noise>

A more interesting case (and more realistic) appears when we introduce some noise into the @part1_without_noise:
$
(d r(t)) / (d t) = -r(t) + f(w r(t) + I) + sigma eta(t)
$ <part1_with_noise>
where $eta$ is a gaussian white noise and $sigma in RR_+$ the noise amplitude. Of course, we retrieve @part1_without_noise when $sigma=0$ (no noise).

The solutions of @part1_with_noise are given in @part1_dynamics_with_noise for different initial conditions and $sigma$.

#figure(caption: [Plot of the dynamics for different initial conditions and noise amplitude], image("figures/part1_dynamics_with_noise.svg")) <part1_dynamics_with_noise>

We then observe that in neither case does the curve converge towards 60, even though it initially starts at 60. This is true even with very low noise: the fixed point 60 is unstable.

However, we still observe the same two other fixed points (0 and 120), even with a lot of noise. These are stable fixed points.

== Study of the fixed points

This section provides a more formal and in-depth study of the behavior of the dynamic system. To do this, we study the model in phase space.

In particular, the curve of the (time) derivative of $r$ as a function of $r$ itself is provided in the @part1_state_space.

#figure(caption: [The derivative $(d r) / (d t)$ as a function of $r$ for $omega=0.05 "nA" dot "Hz"^(-1)$ and $I=-3 "mV"$], image("figures/part1_flux.svg", width: 70%)) <part1_state_space>

The cancellation points on the @part1_state_space correspond to fixed points in the system (points of convergence of the solutions). In this case, we find the three fixed points we've already encountered: $0$ (due to numerical instability, we got 1 on the diagram), $60$ and $120$.

If we plot the count of zeros (fixed points) as a function of $omega$, the synaptic strength, and $I$, the external input, we get the bifurcation diagram shown in @bifurcation_diagram.

#figure(caption: [Bifurcation diagram (count of zeros of the curve $dot(r)$ as a function of $r$)], image("figures/part1_bifurcation_diagram.svg", width: 70%)) <bifurcation_diagram>

The yellow part correspond to three concellation points, whereas the purple part correspond to one concellation point. As a remainder, the concellation points in the state space are linked to the fixed points of the dynamic system.

We observe that the weaker the external input and the lower the sypnatic force, the more unstable the system (more fixed points). We also note that it's mainly the sypnatic force that reduces the number of fixed points (when it's large). The external input has less impact.

#pagebreak()
= Mutual excitation

== The model

In this second part, we will consider a little more complex system. Now, we will study a circuit of two neurons that excite each other.

Let consider the two following functions:
$
F_1 : x,y & |-> -x + f(omega_2 y + I) \
F_2 : x,y & |-> -y + f(omega_1 x + I)
$
with $f(s)=50 sigma(s)$ and $sigma(s)=(1+e^(-s))^(-1)$. The function $f$ is the activation function and $f(RR)=[0,50]$ with $f(s) -->_(s->-infinity) 0$ and $f(s) -->_(s->+infinity) 50$.

Then, the firing rate model is described by the below system of differential equations:
$
dot(x)(t) & = F_1(x(t),y(t)) \
dot(y)(t) & = F_2(x(t),y(t))
$
with $dot(x)(t) = (d x)/(d t)(t)$ and $dot(y)(t) = (d y)/(d t)(t)$.

A more in depth mathematical study of the system will be provided in the third subsection (when studying analitically the fixed points).

== Study of the dynamics

A simulation of the dynamics for some random initial conditions is provided in @part2_dynamics. In that particular case, they all converge towards a single fixed point: 60. It will be showed later that this model may have more than one fixed point, including a potential unstable point.

#figure(caption: [The dynamics], image("figures/part2_dynamics.svg", width: 80%)) <part2_dynamics>

== Study of the fixed points

Like with the first model, we study the model in the state space to better analyze the fixed points.

#figure(caption: [Trajectories in the state space for random initial conditions (and nullclines)], image("figures/part2_state_space.svg", width: 80%))

The two dashed lines are the nullclines of the system. Their crossing points indicates the fixed points of the system. Indeed, we can observe that the different trajectories converges towards one of those points.

We can see that the points at $(0,0)$ and $(50,50)$ appear to be stable. The point at $(25,25)$, on the other hand, appears to be unstable (no random trajectory converges on it). These three points are the fixed points of our system.

We can analitically study the stability of the fixed points. For that, we first need to compute the Jacobian matrix of the system at each point:
$
forall x, y, J(x,y)=mat((diff F_1)/(diff x)(x,y), (diff F_1)/(diff y)(x,y); (diff F_2)/(diff x)(x,y), (diff F_2)/(diff y)(x,y))
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

The signs of $tr(J)$ and $det(J)$ will tell us the stability of the fixed point.

In our case, the fixed points are $(0,0)$, $(25,25)$ and $(50,50)$:
- $det(J(0,0)) = det(J(50,50)) approx 1 > 0$
- $det(J(25,25)) approx -24 < 0$
Therefore, because $tr(J) < 0$, $(0,0)$ and $(50,50)$ are stable but $(25,25)$ is an unstable fixed point.

The count of fixed points (number of crossing points of the nullclines) change as a function of the input current. The exact function is given by the bifurcation diagram on @part2_bifurcation_diagram. Whereas, different nullclines are shown for different input currents on @part2_nullclines.

#figure(caption: [Nullclines for different input current $I$], gap: 1em, stack(dir: ltr,
figure(caption: [For $I=0 "nA"$], supplement: [Subfigure], image("figures/part2_nullclines_I=0.svg", width: 33%)),
figure(caption: [For $I=-10 "nA"$], supplement: [Subfigure], image("figures/part2_nullclines_I=10.svg", width: 33%)),
figure(caption: [For $I=-20 "nA"$], supplement: [Subfigure], image("figures/part2_nullclines_I=20.svg", width: 33%)),
)) <part2_nullclines>

#figure(caption: [Bifurcation diagram], image("figures/part2_bifurcation_diagram.svg", width: 50%)) <part2_bifurcation_diagram>

From @part2_bifurcation_diagram, we observe two regimes. For $I in [-16, -6]$, we have three fixed points including one unstable. Otherwise, we only have a single fixed point that is stable.

#pagebreak()
= Hopfield neural network

== The model

#let sign = $op("sign")$;

We consider two patterns $p_1$ (the cat) and $p_2$ (the man/astronaut) in $RR^d$ with $d = 16 times 16 = 256$. Both patterns are shown in @part3_patterns.

#figure(caption: [The cat and man patterns], stack(dir: ltr, spacing: 1em, image("figures/part3_cat.svg", width: 50%), image("figures/part3_man.svg", width: 50%))) <part3_patterns>

Let $p_1, ..., p_n in RR^d$ be the $n$ patterns, then we define the weight matrix $W$ to be:
$
W = 1/N sum_(i=1)^n p_i p_i^T
$
In particular, we note $W_1$ the weigth matrix for the pattern $p_1$ and $W_2$ the weight matrix for the patterns $p_1$ and $p_2$. Both the matrices are shown in @part3_weight_matrices.

#figure(caption: [Different weight matrices $W$], gap: 1em, stack(dir: ltr,
figure(caption: [For the cat pattern, $W_1$], supplement: [Subfigure], image("figures/part3_mat_w_cat.svg", width: 50%)),
figure(caption: [For the cat + man patterns, $W_2$], supplement: [Subfigure], image("figures/part3_mat_w_cat_man.svg", width: 50%)))) <part3_weight_matrices>

The dynamics of the Hopfield neural network is given by the following system (with $x(t)$ the "predicted" pattern at time $t$):
$
dot(x)(t) = -x(t) + sign(W x(t)) + sigma eta(t)
$
with
$
sign(x) = cases(
  +1 &"if" x > 0, 
  0  &"if" x = 0, 
  -1 &"if" x < 0)
$
and where $eta$ is a gaussian white noise and $sigma in RR_+$ the noise amplitude.

== The dynamics and fixed points of the model

The figures @part3_cat_simulation and @part3_man_simulation both show two examples of the evolution of the system for $W_1$ and $W_2$ respectively, and an initial uniform random pattern. We see that in the first case, the pattern converges towards the cat pattern (as $W_1$ only memorized the cat pattern). In the second case, the model converges towards the man pattern, but for a different initial pattern, the model can also converge towards the cat. Notably, because $W_2$ memorizes both the cat and man patterns.

In both cases, the convergence is quite fast. Only a few iterations are needed before observing one of the memorized patterns clearly.
 
#figure(caption: [Simulation of the network for $W_1$ and an initial random pattern], image("figures/part3_cat_simulation.svg", width: 80%))<part3_cat_simulation>
#figure(caption: [Simulation of the network for $W_2$ and an initial random pattern], image("figures/part3_man_simulation.svg", width: 80%)) <part3_man_simulation>

Now, let consider the man pattern and add some white noise to it (to corrupt it). This way, we get @part3_man_corrupted. The man is still recognizable with some effort, but it is not the same as the uncorrupted man pattern shown in @part3_patterns.

#figure(caption: [The man pattern corrupted with noise], image("figures/part3_man_corrupted.svg", width: 50%)) <part3_man_corrupted>

Still, the network will converge towards the clean pattern (without noise) as shown in @part3_man_corrupted_simulation. Moreover, the convergence is quite fast (the image is clearly recognizable for $t$ small).

This example show the resilience of the network to noise. And the convergence towards the nearest "memorised" pattern.

#figure(caption: [Simulation of the network for the corrupted man pattern], image("figures/part3_man_corrupted_simulation.svg", width: 80%)) <part3_man_corrupted_simulation>

#pagebreak()
== Network capacity

An important property of our network is how much distinct patterns can be memorized by $N$ neurons.

We note $C$ the capacity of our network, which is how many patterns can be memorized until the network is not able to relax back to the pattern after adding small noise. We can prove #footnote[Hertz, J.A. (1991). Introduction To The Theory Of Neural Computation (1st ed.). CRC Press.] that $C approx 0.138 N$ where $N$ is the count of neurons. So, with $N=256$, we get $C_256 approx 35$ and with $N=64$, we get $C_64 approx 9$.

We can retrieve these results experimentally using the following protocol:
+ Create a weight matrix for $M$ random patterns.
+ Select one of the random patterns and add noise to it.
+ Simulate the network with the corrupted pattern as the initial condition.
+ If the network converge towards the uncorrupted pattern, then OK. Otherwise, it is a failure.
+ Repeat from the step 2 as many times as you wish.
+ At the end, we get a probability of success for the network to relax back to the initial pattern for $M$ memorized patterns.

The @part3_capacity_experience show the experience for $N=64$ and $N=256$ and for different initial pattern counts. We clearly see a decrease in probability after the computed theoretical capacity $C=0.138N$ is reached.

#figure(caption: [Simulations for $10$ trials each time], stack(dir: ltr,
figure(caption: [For $N=64$], supplement: [Subfigure], image("figures/part3_capacity_N=64.svg", width: 50%)),
figure(caption: [For $N=256$], supplement: [Subfigure], image("figures/part3_capacity_N=256.svg", width: 50%)))) <part3_capacity_experience>

#pagebreak()
= PCA and the ring network model

== The model

The dynamics of the network is given by the following system:
$
dot(x)(t) = -x(t) + J Phi(x(t))
$
where the activation function is $Phi(s)=tanh(s)$.

We define the connectivity matrix of this network, $J$, such that the strength between neurons $i$ and $j$ is given by
$
J_(i,j) = 2cos(theta_i-theta_j)
$

The @part4_connectivity_matrix gives the connectivity matrix that will be used for the rest of this section. It was generated using random $theta_i in [0,2pi)$.

#figure(caption: [The connectivity matrix for randoms $theta_i$], image("figures/part4_connectivity_matrix.svg", width: 50%)) <part4_connectivity_matrix>

We observe that the connectivity matrix is symmetric. Indeed, this fact can be proved mathematically:
$
forall i, j, J_(i,j) = 2cos(theta_i - theta_j) =^(cos "is even") 2 cos(theta_j - theta_i) = J_(j,i)
$

The simulated dynamics of the system for $N=100$ neurons and $t in [0, 100] "ms"$ is provided on @part4_dynamics.
#figure(caption: [Dynamics of $x_i(t)$ for $i in [|1,N|]$], image("figures/part4_dynamics.svg", width: 50%)) <part4_dynamics>

One can do a principal component analysis (PCA) on the matrix $X$ build from the previously simulated dynamics (matrix of shape $N times T$). The covariance matrix and the principal components (eigen values) are provided on @part4_pca_results.

#figure(caption: [Results of PCA], gap: 1em, stack(dir: ltr,
figure(caption: [The covariance matrix], supplement: [Subfigure], image("figures/part4_covariance_matrix_pca.svg", width: 50%)),
figure(caption: [The eigenvalues], supplement: [Subfigure], image("figures/part4_eigenvalues.svg", width: 50%))
)) <part4_pca_results>

The explained variance for the $i$-th principal component is defined as:
$
"EV"_i = lambda_i / (sum_(j=1)^n lambda_j)
$
Their values are provided on @part4_explained_variances for each principal component.

#figure(caption: [The computed explained variances], image("figures/part4_explained_variance.svg", width: 50%)) <part4_explained_variances>

== PCA on set of attractors

In this section, we built a $100 times 500$ matrix that contains the collected 500 attractors (the fixed points) for different random initial conditions. The results of PCA on this matrix are provided in @part4_q_pca_results.

#figure(caption: [Results of the PCA], gap: 1em, grid(columns: 2, rows: 2, row-gutter: 0.2em,
figure(caption: [The covariance matrix], supplement: [Subfigure], image("figures/part4_q_covariance_mat.svg")),
figure(caption: [The eigenvalues], supplement: [Subfigure], image("figures/part4_q_eigenvalues.svg")),
figure(caption: [The computed explained variances], supplement: [Subfigure], image("figures/part4_q_explained_variance.svg")),
figure(caption: [Principal components in the plane $"PC"_1 - "PC"_2$], supplement: [Subfigure], image("figures/part4_q_simplified.svg"))
)) <part4_q_pca_results>

We observe that there is two interesting components (of explained variance $0.956$ and $0.0439$ respectively). The thid component has an explained variance $10^6$ times smaller than the second. Likewise, the second component has an explained variance $21$ times smaller than the first one (which can be easily seen in the plot).

If we plot the principal components in the plane $"PC"_1 - "PC"_2$, we can see a ring. The name of the model comes from that fact.

= Conclusion

Our exploration of diverse mathematical models has provided valuable insights into the dynamics of neural systems. From self-connected neurons to Hopfield networks and a specialized "ring" network model, each part contributed to a deeper understanding of neural models.

The different models studied have their own particularities: advantages and disadvantages. The main differences can be summed up in the activation function and the number of neurons considered. We note that networks with more neurons (like Hopfield's) can implement more advanced behaviors: pattern memorization. In particular, the number of patterns memorized is proportional to the number of neurons.

One final point: we showed in the last section that BCP analysis can be used to reduce the complexity of a problem by preserving only the relevant components (and thus reducing the size of the problem).
