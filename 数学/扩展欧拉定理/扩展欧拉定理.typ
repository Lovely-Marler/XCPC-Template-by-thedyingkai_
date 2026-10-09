`exEulerPow(a,b,m)` 求 $a^b mod m$，b 是非空非负十进制串，`m>0`，a 与 m 可不互质。

令 `phi=phi(m)`。`depow` 同时维护 `b mod phi` 与原 b 是否达到 phi：小指数用原值，大指数用余数加 phi。b=0 保留 0，不能无条件加周期；已知互质时只用余数即可。

当前 phi 用试除，时间 $O(sqrt(m))$；加上指数串扫描与模幂。相同模数多问可缓存 phi，大模数分解可接 Pollard–Rho。

题目：P5091。
