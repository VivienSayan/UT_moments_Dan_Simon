# Unscented Transform vs 1st order linearization 
A matlab code for the example 14.1 of the following book: "Optimal state estimation" from Dan Simon (p.434)

I have implemented the "polar to cartesian" transformation example from the book.
The results show the propagated mean and covariance computed from; (1) a Monte-Carlo transformation with 10000 points; (2) an Unscented transformation with 2n+1 points; (3) a linearization of the model. The initial sample was normally-distributed, with the following standard deviations: ±0.01 for the radius, and ±0.35 rad for the orientation.

Do not hesitate to report any mistake !
