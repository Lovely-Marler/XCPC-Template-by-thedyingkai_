#set heading(outlined: false)

// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("模数下的除法先检查可逆条件。计数口径区分有序/无序、重复/互异；期望可线性拆分，但概率乘法不能假定独立。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")

=== #text("整除子数组：前缀余数相同") <trick-math-01>

*问题概述*　#text("给定整数数组 ")$a_1…a_n$#text(" 和正整数 ")$m$#text("，求非空连续子数组 [l,r] 的数量，使 ")$sum _(i=l)^r a_i$#text(" 是 ")$m$#text(" 的倍数。数组允许负数，按不同端点对计数，0 也是 ")$m$#text(" 的倍数。")

*必要思路*　#text("前缀和 ")$p_(r)-p_(l-1)≡0 mod m$#text(" 等价于两前缀余数相同。扫描时累计相同余数次数，初始余数 0 的次数为 1；负数余数用 ")$(x mod m+m) mod m$#text(" 归一化，")$m$#text(" 必须正。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("裴蜀：任意整数线性组合只差 gcd") <trick-math-02>

*问题概述*　#text("从整数坐标 0 出发，每次可以选择给定非负整数长度 ")$a_i$#text("，向左或向右移动该长度；每种长度可无限次使用。给定整数目标 ")$D$#text("，判断能否经过有限步恰到 ")$D$#text("；允许所有 ")$a_i$#text(" 都为 0，位置没有额外边界。")

*必要思路*　#text("可达整数集合恰为所有长度 gcd 的倍数，所以检查 gcd|D。允许负系数是关键；若每种只能用非负次数或次数有限，这个条件通常只必要不充分。全零长度时只有 ")$D=0$#text(" 可达。")

*参考*　#link("https://cp-algorithms.com/algebra/linear-diophantine-equation.html")[#text("CP-Algorithms：不定方程")]。

=== #text("不定方程：所有解变一个参数") <trick-math-03>

*问题概述*　#text("给定整数 a,b,c，以及有限整数区间 ")$[L_x,R_x]$#text("、")$[L_y,R_y]$#text("，求满足 ")$a x+b y=c$#text("、")$L_x≤x≤R_x$#text("、")$L_y≤y≤R_y$#text(" 的整数对 (x,y) 数量。")$a$#text(" 或 ")$b$#text(" 可以为 0，两个系数全为 0 时也必须按区间大小处理。")

*必要思路*　#text("")$g=gcd(a,b)$#text(" 不整除 ")$c$#text(" 则无解；求一组解后 ")$x=x_(0)+(b/g)t$#text("、")$y=y_(0)-(a/g)t$#text("，把两组范围化为 ")$t$#text(" 的整数区间并取交。需正确实现负数 ")$floor/ceil$#text(" 除法；")$a=0$#text(" 或 ")$b=0$#text(" 单独处理。")

*参考*　#link("https://cp-algorithms.com/algebra/linear-diophantine-equation.html")[#text("CP-Algorithms：不定方程")]。

=== #text("模除法先检查可逆") <trick-math-04>

*问题概述*　#text("给定整数 ")$a$#text(" 和模数 ")$m≥2$#text("，求满足 ")$a x≡1 (mod m)$#text(" 的最小非负整数 ")$x$#text("，不存在则报告无逆元。若整式在取模前含除法，必须区分“整数商存在”和“分母在模 ")$m$#text(" 下可逆”，不能直接等同。")

*必要思路*　#text("逆元存在当且仅当 ")$gcd(a,mod)=1$#text("；一般用扩展欧几里得。素数模下费马逆元仍要求 ")$a$#text("不为0 mod p。不可逆不意味着原整数公式不存在，可能须先做整除、拆素数幂或保留因子指数。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。

=== #text("一堆逆元只求逆一次") <trick-math-05>

*问题概述*　#text("给定模数 ")$m≥2$#text(" 及 ")$n$#text(" 个整数 ")$a_i$#text("，保证 ")$gcd(a_i,m)=1$#text("。求全部 ")$a_i$#text(" 的模逆元，希望只进行一次扩展欧几里得或求逆快速幂，其余步骤为 ")$O(n)$#text(" 次模乘；元素不要求互异。")

*必要思路*　#text("做前缀乘积 ")$P$#text("，求总积逆元一次，再逆序求每个逆元：")$op("inv")(a_(i))=P_(i-1) op("inv")(P_(i))$#text("，随后乘 ")$a_(i)$#text(" 推回。要求每个 ")$a_(i)$#text(" 都是单位；混入不可逆元素会使总积也不可逆。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。

=== #text("非互质同余合并") <trick-math-06>

*问题概述*　#text("给定两个同余式 ")$x≡a (mod m)$#text("、")$x≡b (mod n)$#text("，其中 m,n>0 且不要求互质。判断是否有整数解，若有则输出最小非负解与所有解的周期 ")$lcm(m,n)$#text("；多式版本按相同规则逐条合并。")

*必要思路*　#text("令 ")$x=a+m t$#text("，解 ")$m t≡b-a mod n$#text("；")$g=gcd(m,n)$#text(" 必须整除 b-a。合并后模数为 ")$lcm(m,n)$#text("，解归一化。用扩展 gcd 求 ")$t$#text("；多式逐条合并，乘法与 lcm 可能超过 64 位。")

*参考*　#link("https://cp-algorithms.com/algebra/chinese-remainder-theorem.html")[#text("CP-Algorithms：中国剩余定理")]。

=== #text("整除分块：相同商一段算") <trick-math-07>

*问题概述*　#text("给定非负整数 ")$N$#text("、范围 ")$1≤L≤R$#text("，以及权函数 ")$f$#text(" 的区间和查询接口，求 ")$sum _(i=L)^R f(i) floor(N/i)$#text("。希望只处理商不变的连续分母段；i>N 时商为 0，区间可能包含这样的尾段。")

*必要思路*　#text("从 ")$l$#text(" 开始，")$q=N/l$#text("，相同商的右端 ")$r=N/q$#text("（再截到查询上界），整块加 ")$q  sum _(i=l)^r f(i)$#text("。不同正商仅 ")$O(sqrt(N))$#text(" 个；")$q=0$#text(" 时不能再 ")$N/q$#text("，要单独处理剩余尾段。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。

=== #text("多个整除商同时相同") <trick-math-08>

*问题概述*　#text("给定非负整数 ")$N$#text("、")$M$#text("、")$1≤L≤R$#text("，且可 ")$O(1)$#text(" 求权函数 ")$w$#text(" 的区间和。求 ")$sum _(i=L)^R floor(N/i) floor(M/i) w(i)$#text("。分块内两个商都必须固定，范围可超出 min(N,M)，这部分乘积为 0。")

*必要思路*　#text("从左端 ")$l$#text(" 开始，两个商分别为 ")$q_N=floor(N/l)$#text("、")$q_M=floor(M/l)$#text("。若任一商为 0，后续乘积全为 0，可停止。否则 ")$r=min(floor(N/q_N),floor(M/q_M),R)$#text("，在 [l,r] 内同时固定两商，乘权重区间和后令 ")$l=r+1$#text("。总块数 ")$O(sqrt(N)+sqrt(M))$#text("，不对零商做除法。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。

=== #text("约数贡献交换求和") <trick-math-09>

*问题概述*　#text("给定正整数 ")$N$#text("，τ(x) 为 ")$x$#text(" 的正约数个数、σ(x) 为正约数之和。分别求 ")$sum _(x=1)^N τ(x)$#text(" 和 ")$sum _(x=1)^N σ(x)$#text("，不逐个对 ")$x$#text(" 进行质因数分解，且约数均按正整数计入。")

*必要思路*　#text("每个 ")$d$#text(" 为所有 ")$d$#text(" 的倍数贡献一次，")$sum _(x≤N)τ(x)= sum _(d≤N)floor(N/d)$#text("。约数和同理变 ")$sum  d floor(N/d)$#text("，可用整除分块及等差数列区间和。先按“一个约数出现在哪些数中”统计。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/divisors.html")[#text("CP-Algorithms：约数个数与约数和")]。

=== #text("gcd/AND 的变化点少") <trick-math-10>

*问题概述*　#text("给定非负整数数组及目标 ")$g≥0$#text("，统计 ")$gcd(a_l,…,a_r)=g$#text(" 的非空连续子数组个数。规定 ")$gcd(0,…,0)=0$#text("，不同端点对分别计数；要求压缩固定右端点的不同 gcd 与对应次数。")

*必要思路*　#text("对固定右端点保留不同 gcd 与次数，新数加入时对每个旧 gcd 再 gcd 一次并合并。正 gcd 每次严格下降就至少减半，因此仅 ")$O(log V)$#text(" 种（0 单独计）；总约 ")$O(n log V)$#text(" 次 gcd 运算，其内部成本另算。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。

=== #text("区间加、区间 gcd 变差分") <trick-math-11>

*问题概述*　#text("给定整数数组，支持区间加操作：把 [l,r] 中每个 ")$a_i$#text(" 加上整数 ")$d$#text("；查询返回 ")$gcd(|a_l|,…,|a_r|)$#text("。数组与增量均可为负，区间非空，单点查询返回该元素绝对值。")

*必要思路*　#text("设 ")$d_(i)=a_(i)-a_(i-1)$#text("，")$gcd(a_(l dots.h r))=gcd(a_(l),d_(l+1 dots.h r))$#text("。区间加仅修改 ")$d_(l)$#text(" 与 ")$d_(r+1)$#text("；用树状数组取 ")$a_(l)$#text("，线段树查差分 gcd。差分取绝对值，")$l=r$#text(" 时空差分 ")$gcd=0$#text("。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。

=== #text("约数与倍数方向交换") <trick-math-12>

*问题概述*　#text("给定 ")$n$#text(" 个有编号正整数 ")$a_i≤V$#text("，")$V$#text(" 可接受按值域枚举。对每个 ")$1≤d≤V$#text("，求满足 ")$gcd(a_i,a_j)=d$#text(" 的不同下标无序对数量；重复数值仍按下标区分，本模型不包含 0。")

*必要思路*　#text("先按精确数值计数，再枚举 ")$d$#text(" 的所有倍数累计 ")$op("cntDiv")_(d)$#text("；总访问次数 ")$O(V log V)$#text("。两数 gcd恰为")$d$#text(" 可从大到小，用 ")$binom(op("cntDiv")_(d),2)$#text(" 减掉更大倍数的答案。输入 0 会被所有 ")$d$#text(" 整除，须另处理。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("互质筛选：莫比乌斯把 gcd=1 拆开") <trick-math-13>

*问题概述*　#text("给定正整数 ")$N$#text("、")$M$#text("，统计有序整数对 (a,b)，满足 ")$1≤a≤N$#text("、")$1≤b≤M$#text(" 且 ")$gcd(a,b)=1$#text("。")$a=b=1$#text(" 属于合法对；当 ")$N=M$#text(" 时 (a,b) 与 (b,a) 仍按有序对区分。")

*必要思路*　#text("用 ")$[gcd(a,b)=1]= sum _(d|a,d|b)μ(d)$#text("，把答案转为按共同约数求和。")$1 dots.h N$#text("、")$1 dots.h M$#text(" 的有序对是 ")$sum μ(d)floor(N/d)floor(M/d)$#text("。任意多重集合需按倍数频次计算，并区分同下标、顺序与重复值。")

*参考*　#link("https://oi-wiki.org/math/number-theory/mobius/")[#text("OI Wiki：莫比乌斯反演")]。

=== #text("组合选择替代复杂求和") <trick-math-14>

*问题概述*　#text("给定非负整数 a,b,r，求 ")$sum _k binom(a,k) binom(b,r-k)$#text("，其中 ")$binom(u,v)$#text(" 在 v<0 或 v>u 时定义为 0，求和包含全部合法 ")$k$#text("。目标是在求值之前识别整个求和的组合意义，不能额外截断 ")$k$#text(" 的范围。")

*必要思路*　#text("把 ")$a+b$#text(" 个对象分两类，选 ")$r$#text(" 个；按第一类选 ")$k$#text(" 个分类便得 ")$binom(a+b,r)$#text("。这也是范德蒙德恒等式的组合证明。上下界被截断时只算完整合法 ")$k$#text("；任意加权系数不一定还能直接合并。")

*参考*　#link("https://cp-algorithms.com/combinatorics/binomial-coefficients.html")[#text("CP-Algorithms：二项式系数")]。

=== #text("插板法：下界先平移") <trick-math-15>

*问题概述*　#text("给定 ")$k≥1$#text(" 个有编号整数变量及下界 ")$l_i$#text("、总和 ")$S$#text("，求满足 ")$x_i≥l_i$#text("、")$sum  x_i=S$#text(" 的整数向量个数；每个变量没有上界，按各坐标值区分方案。")$k=0$#text(" 的特例仅在 ")$S=0$#text(" 时有一个空向量。")

*必要思路*　#text("非负解数为 ")$binom(S+k-1,k-1)$#text("；设 ")$y i=x i-l i$#text("，先把 ")$S$#text(" 减去 ")$sum  l i$#text("，若新 S<0 无解。")$k=0$#text(" 时只可能空和 0；题目对象可区分才是这类解计数。")

*参考*　#link("https://cp-algorithms.com/combinatorics/stars_and_bars.html")[#text("CP-Algorithms：插板法")]。

=== #text("有上界的插板用容斥") <trick-math-16>

*问题概述*　#text("给定 ")$k≥1$#text("、非负整数上界 ")$u_i$#text(" 和目标 ")$S≥0$#text("，求满足 ")$0≤x_i≤u_i$#text("、")$sum  x_i=S$#text(" 的整数向量个数，变量按编号区分。若采用子集容斥，要求 ")$k$#text(" 足够小可枚举 ")$2^k$#text("；大 ")$k$#text("、小 ")$S$#text(" 应换用 DP。")

*必要思路*　#text("对超界变量集合 ")$T$#text("，用 ")$y_i=x_i-(u_i+1)$#text(" 把下界移回 0，容斥贡献为 ")$(-1)^abs(T) binom(S-sum_(i in T)(u_i+1)+k-1,k-1)$#text("。对所有 ")$T$#text(" 求和，不合法的组合数参数贡献 0。小 ")$k$#text(" 可枚举 ")$2^k$#text("；大 ")$k$#text("、小 ")$S$#text(" 采用前缀和背包。")

*参考*　#link("https://cp-algorithms.com/combinatorics/stars_and_bars.html")[#text("CP-Algorithms：插板法")]；#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。

=== #text("至少出现一次：先算完全没出现") <trick-math-17>

*问题概述*　#text("给定 ")$n≥0$#text("、")$k≥0$#text("，求长度 ")$n$#text(" 的有序字符串个数，字符来自 ")$k$#text(" 个有标签符号，且每种符号至少出现一次。位置与符号都可区分；")$n=k=0$#text(" 时唯一空串合法，")$k=0$#text(" 且 n>0 时无方案。")

*必要思路*　#text("容斥缺失符号，答案 ")$sum _(j=0)^k(-1)^j binom(k,j)(k-j)^n$#text("。符号与位置都可区分。")$n=0$#text(" 时 ")$0^0$#text(" 在此代表唯一空映射，按计数语义取 1，避免代码默认不一致。")

*参考*　#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。

=== #text("模小质数的组合数按位拆") <trick-math-18>

*问题概述*　#text("给定非负整数 ")$n$#text("、")$k$#text(" 和质数 ")$p$#text("，求 ")$binom(n,k) mod p$#text("，k>n 时为 0。")$n$#text(" 可以远大于 ")$p$#text("，")$p$#text(" 必须小到能承担 ")$0…p-1$#text(" 的预处理；不允许把这个前提替换为任意复合模数。")

*必要思路*　#text("Lucas：把 ")$n$#text("、")$k$#text(" 写成 ")$p$#text(" 进制，")$binom(n,k)≡ product  C(n_i,k_i) mod p$#text("；某位 ")$k_i>n_i$#text(" 即为 0。预处理 ")$0 dots.h p-1$#text(" 的组合值/阶乘，")$p$#text(" 大时仍可能内存不可承受。复合模不能直接套。")

*参考*　#link("https://cp-algorithms.com/combinatorics/binomial-coefficients.html")[#text("CP-Algorithms：二项式系数")]。

=== #text("括号合法性是路径不越界") <trick-math-19>

*问题概述*　#text("给定 ")$n≥0$#text("，求长度 2n、恰有 ")$n$#text(" 个左括号和 ")$n$#text(" 个右括号的合法单类型括号串数量。每个前缀的左括号数必须不少于右括号数；")$n=0$#text(" 计唯一空串，不附加高度上界或括号颜色。")

*必要思路*　#text("")$n$#text(" 对括号数为 ")$binom(2n,n)-binom(2n,n+1)$#text("，用首次跌破边界的反射建立非法路径对应。需要多种括号颜色或高度上界时再加状态/限制。用差式计算可避免除以 ")$n+1$#text(" 在模数下不可逆的问题。")

*参考*　#link("https://cp-algorithms.com/combinatorics/catalan-numbers.html")[#text("CP-Algorithms：Catalan 数")]。

=== #text("恰有 k 个固定点与错排") <trick-math-20>

*问题概述*　#text("给定 ")$0≤k≤n$#text("，求 1…n 的排列中恰有 ")$k$#text(" 个固定点的数量，固定点是满足 ")$p_i=i$#text(" 的下标。剩余 n-k 个位置都必须不是固定点；")$n=0,k=0$#text(" 计唯一空排列。")

*必要思路*　#text("先选固定位置 ")$binom(n,k)$#text("，剩下必须全部错排，乘 ")$D(n-k)$#text("。")$D(0)=1$#text("、")$D(1)=0$#text("，")$D(n)=(n-1)(D(n-1)+D(n-2))$#text("。不能让剩余部分又有固定点，否则变成至少 ")$k$#text(" 个。")

*参考*　#link("https://oi-wiki.org/math/combinatorics/derangement/")[#text("OI Wiki：错位排列")]。

=== #text("置换重复操作拆成环") <trick-math-21>

*问题概述*　#text("给定 1…n 上的置换 ")$p$#text("，以及可能由长整数表示的非负次数 ")$T$#text("。把映射 ")$p$#text(" 连续作用 ")$T$#text(" 次，求每个编号 ")$x$#text(" 最终到达的 ")$(p^T)(x)$#text("；")$T=0$#text(" 时为 ")$x$#text("，输入必须是双射而非一般函数图。")

*必要思路*　#text("将置换拆为不交环。每点沿其环前进 T mod 环长次即可，已给定 ")$T$#text(" 的普通整数值时总 ")$O(n)$#text("，长串需先计算各环长的余数。一般函数图还有入环树枝，必须先处理到环距离；不能把重复作用当成循环移动整个数组。")

*参考*　#link("https://cp-algorithms.com/algebra/binary-exp.html")[#text("CP-Algorithms：快速幂")]。

=== #text("不区分旋转：平均固定方案") <trick-math-22>

*问题概述*　#text("给定 ")$n≥1$#text(" 个环上位置和 ")$k≥1$#text(" 种有标签颜色，每处恰染一种颜色、无其他限制。两种染色若能通过旋转互相得到则视为同一方案，反射不自动视为等价。求旋转等价类数，不能直接用 ")$k^n/n$#text("。")

*必要思路*　#text("设 ")$G$#text(" 为位置上的旋转群，Burnside 给出等价类数")$=(1/|G|) sum _(g∈G)op("Fix")(g)$#text("。设旋转 ")$g$#text(" 有 ")$c_g$#text(" 个位置循环；不限制各色数量时，")$op("Fix")(g)=k^(c_g)$#text("，因为同一循环内颜色必须相同。群若包含反射则需另统计反射固定方案；模数下平均必须正确处理整除。")

*参考*　#link("https://cp-algorithms.com/combinatorics/burnside.html")[#text("CP-Algorithms：Burnside 引理")]。

=== #text("曼哈顿最远对拆成符号投影") <trick-math-23>

*问题概述*　#text("给定至少两个二维点，坐标可为负，求不同下标点对间曼哈顿距离 ")$|x_i-x_j|+|y_i-y_j|$#text(" 的最大值。允许点坐标重复；本条求最远距离，不求最近距离。")

*必要思路*　#text("看 ")$x+y$#text(" 与 x-y，两组各自最大值减最小值，取最大即可。")$d$#text(" 维推广为 ")$2^d$#text(" 个正负号投影，每种求极差。最远对可这样算，最近对不能简单取投影差最小值。")

*参考*　#link("https://cp-algorithms.com/geometry/manhattan-distance.html")[#text("CP-Algorithms：曼哈顿距离")]。

=== #text("Manhattan 球变矩形") <trick-math-24>

*问题概述*　#text("给定整数坐标点集及多组 ")$(x_0,y_0,R)$#text("，")$R≥0$#text("。对每组统计满足 ")$|x-x_0|+|y-y_0|≤R$#text(" 的输入点数量，边界计入，重复坐标按输入点的重数计。若改为统计全部整数格点，须另外保持坐标变换的奇偶约束。")

*必要思路*　#text("变换 ")$u=x+y$#text("、")$v=x-y$#text("，条件成 ")$|u-u_(0)|≤R$#text(" 且 ")$|v-v_(0)|≤R$#text("。点集查询可用二维前缀或扫描线；若要按变换后每个整数格点计数，原坐标为整数要求 ")$u$#text("、")$v$#text(" 同奇偶，不能把全部格点都算回去。")

*参考*　#link("https://cp-algorithms.com/geometry/manhattan-distance.html")[#text("CP-Algorithms：曼哈顿距离")]。

=== #text("绝对值和的最优位置是中位数") <trick-math-25>

*问题概述*　#text("给定非空实数或整数序列 ")$a_1…a_n$#text("，在数轴上选择一个实数位置 ")$x$#text("，最小化 ")$sum |a_i-x|$#text("，求最小值及一个最优 ")$x$#text("。所有点权重相同，")$x$#text(" 不受额外区间限制；偶数 ")$n$#text(" 时最优点可能不唯一。")

*必要思路*　#text("排序后相邻区间上目标斜率是左侧数目减右侧数目，跨过中位数后由非正变非负，故中位数最优；偶数个时两个中位数之间都最优。有正权则取加权中位数。平方距离对应均值，不是同一结论。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("三角形不等式先排最大边") <trick-math-26>

*问题概述*　#text("给定 ")$n$#text(" 个有编号的正整数边长 ")$a_i$#text("，统计不同下标无序三元组 i<j<k，使三边可构成非退化三角形。相等长度允许，边长之和比较必须严格大于第三边，不能把退化情形计入。")

*必要思路*　#text("正边长排序，固定最大边 ")$c$#text("，对较小两边用双指针判断 ")$a+b>c$#text("；若成立，当前右端与一段左端都合法，一次计数。退化三角形用严格大于，和先扩宽。零/负数不能当一般边长。自行推导。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。

=== #text("抽屉：前缀余数保证有解") <trick-math-27>

*问题概述*　#text("给定 ")$n≥1$#text(" 个任意整数 ")$a_i$#text("，证明并可构造一个非空连续子数组 [l,r]，使其和被 ")$n$#text(" 整除。除数组长度为 ")$n$#text(" 外没有数值范围或正负限制；目标是保证至少一个合法区间。")

*必要思路*　#text("取 ")$n+1$#text(" 个前缀（含 0），余数只有 ")$n$#text(" 类，必有两个相同；它们之间的非空区间和整除 ")$n$#text("。把“存在某一段”转换成“两个前缀同类”，常比直接构造区间容易。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("平均值条件变前缀大小") <trick-math-28>

*问题概述*　#text("给定整数数组以及有理阈值 ")$K=c/d$#text("，d>0。统计满足 ")$( sum _(i=l)^r a_i)/(r-l+1)≥K$#text(" 的非空连续子数组个数，等号计入；要求使用整数变换避免浮点判等。")

*必要思路*　#text("令 ")$b_(i)=a_(i)-K$#text("，条件变区间和")$≥0$#text("，即前缀 ")$p_(l-1)≤p_(r)$#text("。离散化前缀并用树状数组统计此前≤当前者。若 ")$K$#text(" 是有理数 ")$c/d$#text("，改用 ")$d*a_(i)-c$#text(" 做整数比较，d>0，注意扩宽。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("指示变量：复杂事件逐个贡献") <trick-math-29>

*问题概述*　#text("给定有限对象集合 ")$E$#text(" 及概率空间，对每个 ")$e$#text(" 定义事件 ")$A_e$#text(" 和指示变量 ")$I_e$#text("。随机得分 ")$X= sum _e I_e$#text("，已能单独计算每个 ")$P(A_e)$#text("，求 ")$E_(X)$#text("；事件之间允许任意相关性，不要求独立。")

*必要思路*　#text("对每个事件 ")$A_e$#text("，用 ")$I_e$#text(" 表示它发生时为 1、不发生时为 0。则 ")$E[X]=sum_(e in E)P(A_e)$#text("，由期望线性性得到，不需事件独立。独立性只在拆联合概率乘积时需要；求二阶矩 ")$E_(X^2)$#text(" 则需两两事件联合概率，不能直接把 ")$E_(X)$#text(" 平方。")

*参考*　#link("https://www.luogu.com/article/ms32f221")[#text("洛谷：概率和期望")]。

=== #text("尾和公式：期望长度换存活概率") <trick-math-30>

*问题概述*　#text("给定取值于非负整数的随机变量 ")$X$#text("，能够计算每个 ")$k≥1$#text(" 的 ")$P(X≥k)$#text("，但难以直接计算 ")$P(X=k)$#text("。求 ")$E_(X)$#text("；如果支撑集无限，期望允许为无穷，必须根据尾概率和判断是否收敛。")

*必要思路*　#text("")$X= sum _(k≥1)[X≥k]$#text("，因此 ")$E_(X)= sum  P(X≥k)$#text("。比如最长连续成功长度、等待轮数可从前缀事件得到。无限和要确认收敛；几何等待以成功概率 p>0 为例 ")$E=1/p$#text("。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("期望次数：用每次成功需要的等待") <trick-math-31>

*问题概述*　#text("共有 ")$n≥1$#text(" 种卡片，每次独立且均匀地从 ")$n$#text(" 种中抽到一种，允许重复。初始一张都没有，求第一次集齐全部 ")$n$#text(" 种所需抽取次数的期望，集齐的最后一次抽取也计入。")

*必要思路*　#text("已有 ")$k$#text(" 种时，下一次抽到新种概率 ")$(n-k)/n$#text("，这阶段期望 ")$n/(n-k)$#text("。把阶段相加，得 ")$n H_n$#text("。抽样非均匀时“已收集种数 ")$k$#text("”不再足够决定概率，不能继续只按 ")$k$#text(" 计算。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("模概率：有理分母不能随便除") <trick-math-32>

*问题概述*　#text("有限概率过程的转移概率为有理数 ")$a/b$#text("，题目要求把最终有理答案映射到模质数 ")$p$#text(" 的域中。要求原分母以及消元后真正需要求逆的分母都不为 0 mod p；求该模值，不能把浮点近似直接取模。")

*必要思路*　#text("若 ")$b$#text(" 在模 ")$p$#text(" 下可逆，表示为 ")$a op("inv")(b)$#text("，照样做代数递推；若 ")$b≡0 mod p$#text(" 或消自环出现不可逆分母，需要判断题目是否保证答案可定义，不能用浮点再取模。这里的模值不保留概率大小顺序。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。

=== #text("取整区间反推分母范围") <trick-math-33>

*问题概述*　#text("给定 ")$N≥0$#text("、整数 ")$q≥0$#text(" 及有限正整数区间 [L,R]，求全部满足 ")$floor(N/x)=q$#text(" 的整数 ")$x$#text("，或者其数量。")$q=0$#text(" 也需处理，此时条件为 x>N；")$x=0$#text(" 不属于合法分母。")

*必要思路*　#text("q>0 时 ")$x∈[floor(N/(q+1))+1,floor(N/q)]$#text("，再与题目区间取交。")$q=0$#text(" 时是 x>N，没有有限右端。反过来枚举少量商，可避开巨大分母范围。自行推导。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。

=== #text("质因子指数取代巨大乘积") <trick-math-34>

*问题概述*　#text("给定若干正整数因子 ")$A_1…A_m$#text("，其乘积 ")$P$#text(" 可能无法直接存储。求 ")$P$#text(" 的正约数个数、是否为完全平方数，以及十进制末尾零的数量；约数个数可按模数输出，但判断平方和末尾零必须使用实际指数信息。")

*必要思路*　#text("分解各因子并累加质因子指数：约数个数为 ")$product (e+1)$#text("，平方要求每个 ")$e$#text(" 为偶数，十进制末尾零为 min(e2,e5)。阶乘 ")$p$#text(" 指数用 ")$sum  floor(n/p^k)$#text("。若只需判平方，可仅记指数奇偶。")

*参考*　#link("https://cp-algorithms.com/algebra/divisors.html")[#text("CP-Algorithms：约数个数与约数和")]。

=== #text("复合模指数：非互质时不能直接降幂") <trick-math-35>

*问题概述*　#text("给定非负整数 ")$a$#text("、模数 ")$m≥2$#text("，以及用十进制长串表示的非负指数 ")$E$#text("，求 ")$a^E mod m$#text("。不保证 ")$gcd(a,m)=1$#text("，")$E=0$#text(" 时规定结果为 1 mod m；不能未经判定把 ")$E$#text(" 直接替换为 E mod φ(m)。")

*必要思路*　#text("只有 ")$gcd(a,m)=1$#text(" 才可无条件按欧拉周期降指数。非互质可分解成质数幂，分别跟踪 ")$a$#text(" 的 ")$p$#text(" 因子指数达到模数幂次的时刻，再处理单位部分并 CRT；不要省掉“原指数是否足够大”的信息。自行归纳。")

*参考*　#link("https://cp-algorithms.com/algebra/chinese-remainder-theorem.html")[#text("CP-Algorithms：中国剩余定理")]。

=== #text("恒等式与宽整数防溢出") <trick-math-36>

*问题概述*　#text("输入整数范围保证最终答案或比较结果可表示，但直接乘法可能溢出 64 位。典型任务为正整数 a,b 的 lcm、整数闭区间 [l,r] 的等差和，以及分母为正的两个有理数大小比较；要求给出不截断中间值的精确计算方式。")

*必要思路*　#text("")$lcm(a,b)=a/gcd(a,b)*b$#text("，先除再乘。等差和先在 128 位中计算 ")$l+r$#text(" 与 ")$r-l+1$#text("，再把其中的偶因子除 2 后相乘；最终和能放进 64 位，也不保证端点和或区间长度能放进 64 位。比较 ")$a/b$#text(" 与 ")$c/d$#text("（b,d>0）用 128 位交叉乘积，负分母先归一化。C++ 必须在运算前转换操作数，不能先用 64 位计算再赋给 128 位变量；最终转回目标类型前检查范围。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。
