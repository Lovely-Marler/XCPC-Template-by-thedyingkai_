// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("模数下的除法先检查可逆条件。计数口径区分有序/无序、重复/互异；期望可线性拆分，但概率乘法不能假定独立。")

#text("训练优先级：A 优先掌握，B 常用进阶，C 拓展储备；不是题目官方难度。每条参考链接用于追溯知识，应用情景和边界由本文重新整理。")

=== #text("MATH-01 [A] 整除子数组：前缀余数相同") <trick-math-01>

*问题概述*　#text("求子数组和能被 m 整除的数量，数组可有负数。")

*必要思路*　#text("前缀和 p[r]-p[l-1]≡0 mod m 等价于两前缀余数相同。扫描时累计相同余数次数，初始余数 0 的次数为 1；负数余数用 (x%m+m)%m 归一化，m 必须正。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-02 [A] 裴蜀：任意整数线性组合只差 gcd") <trick-math-02>

*问题概述*　#text("可用若干长度进行正向或反向移动，判断能否恰到目标 D。")

*必要思路*　#text("可达整数集合恰为所有长度 gcd 的倍数，所以检查 gcd|D。允许负系数是关键；若每种只能用非负次数或次数有限，这个条件通常只必要不充分。全零长度时只有 D=0 可达。")

*参考*　#link("https://cp-algorithms.com/algebra/linear-diophantine-equation.html")[#text("CP-Algorithms：不定方程")]。

=== #text("MATH-03 [A] 不定方程：所有解变一个参数") <trick-math-03>

*问题概述*　#text("求 ax+by=c 且 x、y 在区间中的整数解个数。")

*必要思路*　#text("g=gcd(a,b) 不整除 c 则无解；求一组解后 x=x0+(b/g)t、y=y0-(a/g)t，把两组范围化为 t 的整数区间并取交。需正确实现负数 floor/ceil 除法；a=0 或 b=0 单独处理。")

*参考*　#link("https://cp-algorithms.com/algebra/linear-diophantine-equation.html")[#text("CP-Algorithms：不定方程")]。

=== #text("MATH-04 [A] 模除法先检查可逆") <trick-math-04>

*问题概述*　#text("组合公式有除以 a，模数可能不是质数，直接 a^(mod-2) 出错。")

*必要思路*　#text("逆元存在当且仅当 gcd(a,mod)=1；一般用扩展欧几里得。素数模下费马逆元仍要求 a不为0 mod p。不可逆不意味着原整数公式不存在，可能须先做整除、拆素数幂或保留因子指数。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。

=== #text("MATH-05 [B] 一堆逆元只求逆一次") <trick-math-05>

*问题概述*　#text("有很多非零模数元素 a[i]，分别快速幂求逆太慢。")

*必要思路*　#text("做前缀乘积 P，求总积逆元一次，再逆序求每个逆元：inv(a[i])=P[i-1]×inv(P[i])，随后乘 a[i] 推回。要求每个 a[i] 都是单位；混入不可逆元素会使总积也不可逆。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。

=== #text("MATH-06 [B] 非互质同余合并") <trick-math-06>

*问题概述*　#text("x≡a mod m、x≡b mod n，周期不互质。")

*必要思路*　#text("令 x=a+mt，解 mt≡b-a mod n；g=gcd(m,n) 必须整除 b-a。合并后模数为 lcm(m,n)，解归一化。用扩展 gcd 求 t；多式逐条合并，乘法与 lcm 可能超过 64 位。")

*参考*　#link("https://cp-algorithms.com/algebra/chinese-remainder-theorem.html")[#text("CP-Algorithms：中国剩余定理")]。

=== #text("MATH-07 [A] 整除分块：相同商一段算") <trick-math-07>

*问题概述*　#text("求 Σf(i)floor(N/i)，而 f 的区间和容易求。")

*必要思路*　#text("从 l 开始，q=N/l，相同商的右端 r=N/q（再截到查询上界），整块加 q×Σ_{i=l}^r f(i)。不同正商仅 O(√N) 个；q=0 时不能再 N/q，要单独处理剩余尾段。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。

=== #text("MATH-08 [B] 多个整除商同时相同") <trick-math-08>

*问题概述*　#text("求 Σfloor(N/i)floor(M/i)w(i)，只按 N 分块可能漏变化。")

*必要思路*　#text("从 l 开始分别算 rN=N/(N/l)、rM=M/(M/l)，取 r=min(rN,rM,上界)。商为 0 的因子按具体函数处理，不做除零。区间 w 和可 O(1) 查询时，总块数 O(√N+√M)。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。

=== #text("MATH-09 [A] 约数贡献交换求和") <trick-math-09>

*问题概述*　#text("求 1..N 的约数个数总和，不想逐个分解。")

*必要思路*　#text("每个 d 为所有 d 的倍数贡献一次，Σ_{x≤N}τ(x)=Σ_{d≤N}floor(N/d)。约数和同理变 Σd floor(N/d)，可用整除分块及等差数列区间和。先按“一个约数出现在哪些数中”统计。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/divisors.html")[#text("CP-Algorithms：约数个数与约数和")]。

=== #text("MATH-10 [B] gcd/AND 的变化点少") <trick-math-10>

*问题概述*　#text("统计所有子数组 gcd，相邻延长区间时状态很多。")

*必要思路*　#text("对固定右端点保留不同 gcd 与次数，新数加入时对每个旧 gcd 再 gcd 一次并合并。正 gcd 每次严格下降就至少减半，因此仅 O(log V) 种（0 单独计）；总约 O(n log V) 次 gcd 运算，其内部成本另算。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。

=== #text("MATH-11 [B] 区间加、区间 gcd 变差分") <trick-math-11>

*问题概述*　#text("数组支持区间加和区间 gcd，gcd 本身不适合直接懒加。")

*必要思路*　#text("设 d[i]=a[i]-a[i-1]，gcd(a[l..r])=gcd(a[l],d[l+1..r])。区间加仅修改 d[l] 与 d[r+1]；用树状数组取 a[l]，线段树查差分 gcd。差分取绝对值，l=r 时空差分 gcd=0。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。

=== #text("MATH-12 [A] 约数与倍数方向交换") <trick-math-12>

*问题概述*　#text("值域 V 可接受，需要统计 gcd 为某值、互质对或共有因子。")

*必要思路*　#text("先按精确数值计数，再枚举 d 的所有倍数累计 cntDiv[d]；总访问次数 O(V log V)。两数 gcd恰为d 可从大到小，用 C(cntDiv[d],2) 减掉更大倍数的答案。输入 0 会被所有 d 整除，须另处理。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-13 [B] 互质筛选：莫比乌斯把 gcd=1 拆开") <trick-math-13>

*问题概述*　#text("统计有序或无序互质对，逐对求 gcd 太慢。")

*必要思路*　#text("用 [gcd(a,b)=1]=Σ_{d|a,d|b}μ(d)，把答案转为按共同约数求和。1..N、1..M 的有序对是 Σμ(d)floor(N/d)floor(M/d)。任意多重集合需按倍数频次计算，并区分同下标、顺序与重复值。")

*参考*　#link("https://oi-wiki.org/math/number-theory/mobius/")[#text("OI Wiki：莫比乌斯反演")]。

=== #text("MATH-14 [A] 组合选择替代复杂求和") <trick-math-14>

*问题概述*　#text("Σ_k C(a,k)C(b,r-k) 出现在计数里，逐项计算看似必要。")

*必要思路*　#text("把 a+b 个对象分两类，选 r 个；按第一类选 k 个分类便得 C(a+b,r)。这也是范德蒙德恒等式的组合证明。上下界被截断时只算完整合法 k；任意加权系数不一定还能直接合并。")

*参考*　#link("https://cp-algorithms.com/combinatorics/binomial-coefficients.html")[#text("CP-Algorithms：二项式系数")]。

=== #text("MATH-15 [A] 插板法：下界先平移") <trick-math-15>

*问题概述*　#text("求 x1+…+xk=S 的非负整数解，或每个 xi≥li。")

*必要思路*　#text("非负解数为 C(S+k-1,k-1)；设 yi=xi-li，先把 S 减去 Σli，若新 S<0 无解。k=0 时只可能空和 0；题目对象可区分才是这类解计数。")

*参考*　#link("https://cp-algorithms.com/combinatorics/stars_and_bars.html")[#text("CP-Algorithms：插板法")]。

=== #text("MATH-16 [B] 有上界的插板用容斥") <trick-math-16>

*问题概述*　#text("xi 在 [0,ui] 且总和为 S，直接乘组合数不符合上界。")

*必要思路*　#text("对超界集合 T，把对应变量减去 ui+1，贡献 (-1)^|T| C(S-Σ_{i∈T}(ui+1)+k-1,k-1)。变量数小时枚举 2^k；大 k、小 S 则用前缀和背包更实用。下标不合法的组合数为 0。")

*参考*　#link("https://cp-algorithms.com/combinatorics/stars_and_bars.html")[#text("CP-Algorithms：插板法")]；#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。

=== #text("MATH-17 [A] 至少出现一次：先算完全没出现") <trick-math-17>

*问题概述*　#text("长度 n 的序列使用 k 种符号，要求每种至少出现一次。")

*必要思路*　#text("容斥缺失符号，答案 Σ_{j=0}^k(-1)^j C(k,j)(k-j)^n。符号与位置都可区分。n=0 时 0^0 在此代表唯一空映射，按计数语义取 1，避免代码默认不一致。")

*参考*　#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。

=== #text("MATH-18 [B] 模小质数的组合数按位拆") <trick-math-18>

*问题概述*　#text("n、k 极大，模数是较小质数 p，普通阶乘数组开不下。")

*必要思路*　#text("Lucas：把 n、k 写成 p 进制，C(n,k)≡ΠC(n_i,k_i) mod p；某位 k_i>n_i 即为 0。预处理 0..p-1 的组合值/阶乘，p 大时仍可能内存不可承受。复合模不能直接套。")

*参考*　#link("https://cp-algorithms.com/combinatorics/binomial-coefficients.html")[#text("CP-Algorithms：二项式系数")]。

=== #text("MATH-19 [A] 括号合法性是路径不越界") <trick-math-19>

*问题概述*　#text("计数合法括号串、栈入栈出栈顺序或不低于零的 ±1 路径。")

*必要思路*　#text("n 对括号数为 C(2n,n)-C(2n,n+1)，用首次跌破边界的反射建立非法路径对应。需要多种括号颜色或高度上界时再加状态/限制。用差式计算可避免除以 n+1 在模数下不可逆的问题。")

*参考*　#link("https://cp-algorithms.com/combinatorics/catalan-numbers.html")[#text("CP-Algorithms：Catalan 数")]。

=== #text("MATH-20 [A] 恰有 k 个固定点与错排") <trick-math-20>

*问题概述*　#text("排列中恰有 k 个位置保持原样，求方案数。")

*必要思路*　#text("先选固定位置 C(n,k)，剩下必须全部错排，乘 D(n-k)。D(0)=1、D(1)=0，D(n)=(n-1)(D(n-1)+D(n-2))。不能让剩余部分又有固定点，否则变成至少 k 个。")

*参考*　#link("https://oi-wiki.org/math/combinatorics/derangement/")[#text("OI Wiki：错位排列")]。

=== #text("MATH-21 [B] 置换重复操作拆成环") <trick-math-21>

*问题概述*　#text("长度 n 的置换重复执行 T 次，T 很大。")

*必要思路*　#text("把置换分解成不交环，每个元素只沿所在环移动 T mod 环长。时间 O(n)，还可求周期、固定点数等。输入为一般函数时有树枝加环，需先处理入环距离，不能把全部点都当置换环。")

*参考*　#link("https://cp-algorithms.com/algebra/binary-exp.html")[#text("CP-Algorithms：快速幂")]。

=== #text("MATH-22 [C] 不区分旋转：平均固定方案") <trick-math-22>

*问题概述*　#text("项链或棋盘染色在旋转下视为相同，直接除以对称数会算错。")

*必要思路*　#text("Burnside：等价类数=(1/|G|)Σ_{g∈G}Fix(g)。轮换把位置分成若干循环，每循环颜色必须一致；无限制 k 色时 Fix(g)=k^循环数。群包含反射则也要统计反射；模数下平均要求正确处理整除。")

*参考*　#link("https://cp-algorithms.com/combinatorics/burnside.html")[#text("CP-Algorithms：Burnside 引理")]。

=== #text("MATH-23 [A] 曼哈顿最远对拆成符号投影") <trick-math-23>

*问题概述*　#text("二维点求最大 |x1-x2|+|y1-y2|，枚举点对太慢。")

*必要思路*　#text("看 x+y 与 x-y，两组各自最大值减最小值，取最大即可。d 维推广为 2^d 个正负号投影，每种求极差。最远对可这样算，最近对不能简单取投影差最小值。")

*参考*　#link("https://cp-algorithms.com/geometry/manhattan-distance.html")[#text("CP-Algorithms：曼哈顿距离")]。

=== #text("MATH-24 [B] Manhattan 球变矩形") <trick-math-24>

*问题概述*　#text("统计到某点曼哈顿距离≤R 的点，圆菱形形状不便做区间查询。")

*必要思路*　#text("变换 u=x+y、v=x-y，条件成 |u-u0|≤R 且 |v-v0|≤R。点集查询可用二维前缀或扫描线；若要按变换后每个整数格点计数，原坐标为整数要求 u、v 同奇偶，不能把全部格点都算回去。")

*参考*　#link("https://cp-algorithms.com/geometry/manhattan-distance.html")[#text("CP-Algorithms：曼哈顿距离")]。

=== #text("MATH-25 [A] 绝对值和的最优位置是中位数") <trick-math-25>

*问题概述*　#text("在数轴选一个位置 x，使 Σ|a[i]-x| 最小。")

*必要思路*　#text("排序后相邻区间上目标斜率是左侧数目减右侧数目，跨过中位数后由非正变非负，故中位数最优；偶数个时两个中位数之间都最优。有正权则取加权中位数。平方距离对应均值，不是同一结论。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-26 [A] 三角形不等式先排最大边") <trick-math-26>

*问题概述*　#text("求可构成三角形的三元组数，三重循环不可接受。")

*必要思路*　#text("正边长排序，固定最大边 c，对较小两边用双指针判断 a+b>c；若成立，当前右端与一段左端都合法，一次计数。退化三角形用严格大于，和先扩宽。零/负数不能当一般边长。自行推导。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。

=== #text("MATH-27 [A] 抽屉：前缀余数保证有解") <trick-math-27>

*问题概述*　#text("任意 n 个整数，证明存在非空连续段的和被 n 整除。")

*必要思路*　#text("取 n+1 个前缀（含 0），余数只有 n 类，必有两个相同；它们之间的非空区间和整除 n。把“存在某一段”转换成“两个前缀同类”，常比直接构造区间容易。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-28 [A] 平均值条件变前缀大小") <trick-math-28>

*问题概述*　#text("统计平均值至少 K 的子数组，枚举均值会涉及小数。")

*必要思路*　#text("令 b[i]=a[i]-K，条件变区间和≥0，即前缀 p[l-1]≤p[r]。离散化前缀并用树状数组统计此前≤当前者。若 K 是有理数 c/d，改用 d*a[i]-c 做整数比较，d>0，注意扩宽。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-29 [A] 指示变量：复杂事件逐个贡献") <trick-math-29>

*问题概述*　#text("随机对象的总得分是若干元素是否被覆盖、是否出现等事件的计数，事件并不独立。")

*必要思路*　#text("写 X=ΣI_e，则 E[X]=ΣP(e发生)，线性性无需独立。独立性只在把联合概率拆成乘积时需要。若目标是 E[X²]，需再计算两两联合项，不能把 E[X] 直接平方。")

*参考*　#link("https://www.luogu.com/article/ms32f221")[#text("洛谷：概率和期望")]。

=== #text("MATH-30 [B] 尾和公式：期望长度换存活概率") <trick-math-30>

*问题概述*　#text("随机非负整数 X 的分布很难直接求，但容易求 X≥k 的概率。")

*必要思路*　#text("X=Σ_{k≥1}[X≥k]，因此 E[X]=ΣP(X≥k)。比如最长连续成功长度、等待轮数可从前缀事件得到。无限和要确认收敛；几何等待以成功概率 p>0 为例 E=1/p。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-31 [B] 期望次数：用每次成功需要的等待") <trick-math-31>

*问题概述*　#text("均匀独立抽 n 种卡片，求收齐全部卡片的期望次数。")

*必要思路*　#text("已有 k 种时，下一次抽到新种概率 (n-k)/n，这阶段期望 n/(n-k)。把阶段相加，得 nH_n。抽样非均匀时“已收集种数 k”不再足够决定概率，不能继续只按 k 计算。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MATH-32 [B] 模概率：有理分母不能随便除") <trick-math-32>

*问题概述*　#text("随机过程答案要求模 p，状态转移有概率 a/b。")

*必要思路*　#text("若 b 在模 p 下可逆，表示为 a×inv(b)，照样做代数递推；若 b≡0 mod p 或消自环出现不可逆分母，需要判断题目是否保证答案可定义，不能用浮点再取模。这里的模值不保留概率大小顺序。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。

=== #text("MATH-33 [A] 取整区间反推分母范围") <trick-math-33>

*问题概述*　#text("固定商 q，问 floor(N/x)=q 的正整数 x 有哪些。")

*必要思路*　#text("q>0 时 x∈[floor(N/(q+1))+1,floor(N/q)]，再与题目区间取交。q=0 时是 x>N，没有有限右端。反过来枚举少量商，可避开巨大分母范围。自行推导。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。

=== #text("MATH-34 [A] 质因子指数取代巨大乘积") <trick-math-34>

*问题概述*　#text("求巨大乘积的约数个数、是否完全平方或末尾零，数值本身无法存储。")

*必要思路*　#text("分解各因子并累加质因子指数：约数个数为 Π(e+1)，平方要求每个 e 为偶数，十进制末尾零为 min(e2,e5)。阶乘 p 指数用 Σfloor(n/p^k)。若只需判平方，可仅记指数奇偶。")

*参考*　#link("https://cp-algorithms.com/algebra/divisors.html")[#text("CP-Algorithms：约数个数与约数和")]。

=== #text("MATH-35 [B] 复合模指数：非互质时不能直接降幂") <trick-math-35>

*问题概述*　#text("算 a^巨大指数 mod m，想把指数直接对 φ(m) 取模。")

*必要思路*　#text("只有 gcd(a,m)=1 才可无条件按欧拉周期降指数。非互质可分解成质数幂，分别跟踪 a 的 p 因子指数达到模数幂次的时刻，再处理单位部分并 CRT；不要省掉“原指数是否足够大”的信息。自行归纳。")

*参考*　#link("https://cp-algorithms.com/algebra/chinese-remainder-theorem.html")[#text("CP-Algorithms：中国剩余定理")]。

=== #text("MATH-36 [A] 恒等式与宽整数防溢出") <trick-math-36>

*问题概述*　#text("需要计算 lcm、等差求和、比较分数，结果可能在 64 位范围，但中间乘法溢出。")

*必要思路*　#text("lcm(a,b)=a/gcd(a,b)*b，先除再乘；求 (l+r)(r-l+1)/2 可先把偶因子除 2。比较 a/b 与 c/d（b,d>0）用 128 位交叉乘积，负分母先归一化。仍要验证最终类型可容纳。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。

