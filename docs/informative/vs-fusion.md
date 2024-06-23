# Aegis vs Fusion

## Instance creation

<img src="../images/new-instance-benchmark.png"/>

Aegis total: 189221 µs\
Fusion total: 219065 µs

Aegis is faster by 115.77% (approx.)

...in creating instances!

## Creating state values and changing values

<img src="../images/state-benchmark.png"/>

Aegis total: 4283 µs\
Fusion total: 4214 µs

Fusion is faster by 101.63% (approx.)

Fusion beat us on this one, fair enough 😅

## Animating springs

<img src="../images/spring-benchmark.png"/>

Unfortunately, the benchmark was so close that it couldn't properly calculate the values. However, Aegis did end up being a _liiiiitle_ faster.

## Updating properties

<img src="../images/update-props-benchmark.png"/>

Aegis total: 7709 µs\
Fusion total: 24643 µs

Aegis is faster by 319.665% 😳
