#set page(numbering: "1 of 1", number-align: center)
#set heading(numbering: "I.1.a.")
#set par(justify: true)
#set math.equation(numbering: "(1)")

#set page(margin: (top: 5em, bottom: 5em))

#align(center, stack(dir: ttb, spacing: 1em,
  text(size: 18pt, weight: "bold", "Homework 3"), text(style: "italic", "Hubert Gruniaux")))

= Introduction

= Part 1

= Part 2

$
F_1 : x,y & |-> -x + f(omega_2 y + I) \
F_2 : x,y & |-> -y + f(omega_1 x + I)
$

$
J(x,y)=mat((diff F_1)/(diff x)(x,y), (diff F_1)/(diff y)(x,y); (diff F_2)/(diff x)(x,y), (diff F_2)/(diff y)(x,y))
$

$
(diff F_1)/(diff x)(x,y) &= (diff F_2)/(diff y)(x,y) = -1 \
(diff F_1)/(diff y)(x,y) &= 50 omega_2 sigma(omega_2 y + I)(1 - sigma(omega_2 y + I)) \
(diff F_2)/(diff x)(x,y) &= 50 omega_1 sigma(omega_1 x + I)(1 - sigma(omega_1 x + I))
$

Under $omega_1=omega_2=omega$ and $x=y$:
$
(diff F_1)/(diff y)(x,x) = (diff F_2)/(diff x)(x,x) = 50 omega sigma(omega x + I) (1 - sigma(omega x + I))
$

$
forall x, y, tr(J(x,y)) = -2 < 0
$

$
forall x, det(J(x,x)) = 1 - 2500 omega^2 sigma(omega x + I)^2 (1-sigma(omega x + I))^2
$
