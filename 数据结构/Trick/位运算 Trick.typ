#set heading(outlined: false)

// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("默认非负或无符号整数，字长记为 W。ctz/clz 不可传 0，位移量必须小于类型宽度；计数和乘法先扩宽。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")

=== #text("异或前缀把区间变点对") <trick-bit-01>

*问题概述*　#text("给定长度 ")$n$#text(" 的 ")$W$#text(" 位非负整数数组和目标 ")$K$#text("，求非空连续子数组 [l,r] 的数量，使 ")$a_l op("xor") … op("xor") a_r=K$#text("。按不同端点对区分子数组，允许元素重复及 ")$K=0$#text("，不计空区间。")

*必要思路*　#text("令 ")$p_(0)=0$#text("，")$p_(i)=a_(1) op("xor")…op("xor") a_(i)$#text("，条件为 ")$p_(l-1)=p_(r) op("xor") K$#text("。扫描 ")$r$#text("，先查询此前前缀次数，再插入 ")$p_(r)$#text("。初始插入 ")$p_(0)$#text("；")$K=0$#text(" 时若先插入会多计空区间。此为异或消去的自行推导。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("数对异或和拆成每一位") <trick-bit-02>

*问题概述*　#text("给定 ")$n$#text(" 个 ")$W$#text(" 位非负整数 ")$a_i$#text("，求 ")$sum _(1≤i<j≤n)(a_i op("xor") a_j)$#text("，运算顺序是先对每个数对异或再把结果相加。下标不同但值相同也计为一个数对，不计有序重复或自身配对。")

*必要思路*　#text("第 ")$b$#text(" 位有 ")$c$#text(" 个 1、n-c 个 0，贡献 ")$c(n-c)2^b$#text("。按位相加，")$O(n W)$#text("，无需枚举数对。若有序则乘 2，求 XOR 后再求和可拆位，但“异或值乘积”等跨位非线性目标不能照套。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("所有子数组的异或值之和") <trick-bit-03>

*问题概述*　#text("给定 ")$W$#text(" 位非负整数数组 ")$a_1…a_n$#text("，求全部非空连续子数组的 XOR 值的算术总和 ")$sum _(1≤l≤r≤n)(a_l op("xor") … op("xor") a_r)$#text("，而非把各区间结果再进行一次 XOR。")

*必要思路*　#text("先得到 ")$n+1$#text(" 个前缀 XOR，按每一位数 0、1 前缀数，贡献 ")$c_0 c_1 2^b$#text("。每对前缀唯一对应一个非空区间，所以无序配对即可。与“所有区间 XOR 的 XOR”不同，后者是每个元素被包含次数的奇偶。")

*参考*　#link("https://www.luogu.com.cn/article/f3jhcq3e")[#text("洛谷 critnos：位运算技术")]。

=== #text("所有子集 XOR 的和") <trick-bit-04>

*问题概述*　#text("给定 ")$n$#text(" 个有编号的非负整数，枚举全部下标子集 ")$S⊆(1…n)$#text("，子集值为其中元素的 XOR，空集值规定为 0。求所有子集值的算术和；重复数值的不同下标仍是独立选择，")$n=0$#text(" 时只有空集。")

*必要思路*　#text("某位只要至少一个元素为 1，就恰在一半子集中为 1：翻转一个该位为 1 的指定元素，配对出相反位值。故 ")$n≥1$#text(" 时答案为 (所有元素 OR)×2^(n-1)；空子集贡献 0，")$n=0$#text(" 答案为 0。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("不用真的做加法：和与异或的进位") <trick-bit-05>

*问题概述*　#text("给定非负整数 ")$S$#text("、")$X$#text("，判断是否存在两个非负整数 ")$a$#text("、")$b$#text("，使 ")$a+b=S$#text(" 且 ")$a op("xor") b=X$#text("，并在存在时构造一组。本条不要求 ")$a$#text("、")$b$#text(" 都为正、不要求互异，也不附加上界。")

*必要思路*　#text("")$a+b=(a op("xor") b)+2(a op("and") b)$#text("，故需 ")$S≥X$#text("、S-X 偶数，并令 ")$C=(S-X)/2$#text(" 满足 ")$C op("and") X=0$#text("；可取 ")$a=C$#text("、")$b=C+X$#text("。若要求都正或加其他上界，需额外处理。先扩宽类型避免求差与乘法溢出。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("区间 XOR：前缀 0..x 只有四种") <trick-bit-06>

*问题概述*　#text("给定非负整数 ")$L≤R$#text("，求连续整数 ")$L,L+1,…,R$#text(" 的按位 XOR；区间非空，范围可达 ")$10^18$#text("，要求不逐个枚举整数。")

*必要思路*　#text("")$F(x)=0 op("xor")_(1) op("xor")…op("xor") x$#text("，根据 x mod4 分别是 ")$x$#text("、1、")$x+1$#text("、0，答案 ")$F(R) op("xor") F(L-1)$#text("，定义 ")$F(-1)=0$#text("。可将四个连续整数配对证明；")$x+1$#text(" 要检查类型上界。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("遍历置位只按 popcount 工作") <trick-bit-07>

*问题概述*　#text("给定 ")$W$#text(" 位无符号掩码 ")$S$#text("，每个置位对应一个有效下标。要求恰好访问这些置位各一次，返回其位号或单个位掩码；")$S=0$#text(" 时不访问任何元素，工作量与 popcount(S) 成正比。")

*必要思路*　#text("反复 ")$x op("&=") x-1$#text(" 去掉最低置位；当前位可用 ctz(x) 取得。无符号 ")$x$#text(" 的 ")$op("lowbit")=x op("&") (-x)$#text("，用于枚举每个有效元素。")$x=0$#text(" 时停止，避免调用零的 ctz；用 64 位输入就配套 ctzll。")

*参考*　#link("https://cp-algorithms.com/algebra/bit-manipulation.html")[#text("CP-Algorithms：位操作")]。

=== #text("枚举子掩码与 3^n 复杂度") <trick-bit-08>

*问题概述*　#text("给定 ")$n$#text(" 位掩码 ")$S$#text("，枚举全部 ")$T⊆S$#text("，每个 ")$T$#text(" 只输出一次，包括 0 和 ")$S$#text("。另一任务对全部 ")$n$#text(" 位 ")$S$#text(" 枚举上述配对 (S,T)，要求说明总枚举数，而非误估为 ")$4^n$#text("。")

*必要思路*　#text("从 ")$op("sub")=S$#text(" 反复 ")$op("sub")=(op("sub")-1) op("&") S$#text("。若包含空集，在处理 ")$op("sub")=0$#text(" 后退出，不能继续下减。一个掩码有 ")$2^op("popcount")(S)$#text(" 个子集；枚举所有 (S,sub) 总数为 ")$3^n$#text("，每位有不在 ")$S$#text("、仅在 ")$S$#text("、也在 sub 三种。")

*参考*　#link("https://cp-algorithms.com/algebra/all-submasks.html")[#text("CP-Algorithms：子掩码枚举")]。

=== #text("固定选 k 个：不枚举全部 2^n") <trick-bit-09>

*问题概述*　#text("给定整数 ")$0≤k≤n$#text("，从有编号的 ")$n$#text(" 个元素中恰选 ")$k$#text(" 个，枚举所有下标集合且不重复。希望只生成 ")$binom(n,k)$#text(" 个候选，避免遍历全部 ")$2^n$#text(" 个集合；若输出机器字掩码，还须满足 ")$n$#text(" 不超过可用位数。")

*必要思路*　#text("保存递增位置组合 ")$c_(0)<…<c_(k-1)$#text("。从最右找还能增加的位置，加一后把后续位置依次填为最小合法值，再转换成掩码；总生成 ")$binom(n,k)$#text(" 个组合，朴素每次 ")$O(k)$#text("。")$k=0$#text(" 输出唯一空集，k>n 无解；必要时再学 Gosper 位技巧。")

*参考*　#link("https://cp-algorithms.com/combinatorics/generating_combinations.html")[#text("CP-Algorithms：固定大小组合枚举")]。

=== #text("超集枚举转补集子集") <trick-bit-10>

*问题概述*　#text("给定有限全集位掩码 ")$U$#text(" 和 ")$S⊆U$#text("，枚举所有满足 ")$S⊆T⊆U$#text(" 的掩码 ")$T$#text("，每个一次。只有 ")$U$#text(" 中的位可以出现，不能把机器字范围外的取反位算作自由元素。")

*必要思路*　#text("剩余自由位为 U xor S，枚举其子掩码 ")$T$#text("，输出 S or T。")$U$#text(" 必须是题目有限位域，不能直接把机器字 ~S 当全集。复杂度 ")$2^(W-op("popcount")(S))$#text("；")$S$#text(" 不是 ")$U$#text(" 子集时先判非法。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/all-submasks.html")[#text("CP-Algorithms：子掩码枚举")]。

=== #text("SOS：每个集合的全部子集之和") <trick-bit-11>

*问题概述*　#text("给定所有 ")$n$#text(" 位掩码对应的数值 ")$f_(T)$#text("，对每个掩码 ")$S$#text(" 求 ")$F_(S)= sum _(T⊆S)f_(T)$#text("，包含空集和 ")$S$#text(" 本身。允许按模数做加法，要求总复杂度 ")$O(n 2^n)$#text("，而非为每个 ")$S$#text(" 独立枚举子集。")

*必要思路*　#text("按位做高维前缀和：第 ")$b$#text(" 位为 1 时 ")$F_(S)+=F_(S op("xor")(1 op("<<") b))$#text("，总 ")$O(n 2^n)$#text("。做超集和时反向传播；若只要找最大子集值，运算改 max。注意是逐位分阶段，不能任意一次遍历就完成全部传播。")

*参考*　#link("https://usaco.guide/plat/dp-sos")[#text("USACO Guide：SOS DP")]。

=== #text("不相交查询取有限全集补集") <trick-bit-12>

*问题概述*　#text("给定 ")$n$#text(" 位掩码对象及其权值，对查询掩码 ")$S$#text("，求所有与 ")$S$#text(" 按位 AND 为 0 的对象的最大权值，或对象总数。对象可有重复掩码，计数按对象编号，最大值不存在时报告无解；")$n$#text(" 足够小可开 ")$2^n$#text(" 数组。")

*必要思路*　#text("")$T op("and") S=0$#text(" 等价于 ")$T⊆(U op("xor") S)$#text("。先按精确掩码聚合，再做 SOS 子集最大值或求和，查询补集位置。全集位数不大才可开 ")$2^W$#text("；不存在的最大值用 -INF，不能用 0 混淆负权。")

*参考*　#link("https://usaco.guide/plat/dp-sos")[#text("USACO Guide：SOS DP")]。

=== #text("固定右端点的 AND/OR 只有少量不同值") <trick-bit-13>

*问题概述*　#text("给定 ")$W$#text(" 位非负整数数组和目标 ")$K$#text("，统计所有非空连续子数组中按位 AND 恰为 ")$K$#text(" 的个数；OR 版本将全部 AND 换为 OR。要求压缩每个固定右端点的不同区间结果，同时保留各结果对应的区间数量。")

*必要思路*　#text("保存以 ")$r-1$#text(" 结尾的不同值与次数，和 ")$a_(r)$#text(" 做 ")$op("and")/op("or")$#text(" 后合并相邻重复值，再加入单点。延长区间时每位只能从 1→0（AND）或 0→1（OR），所以每个右端点仅 ")$O(W)$#text(" 个值。次数也要聚合。自行推导。")

*实现提示*　#text("例：统计所有子数组 AND 等于 ")$K$#text(" 的个数。cur 保存以当前右端点结束的 (AND值,数量)；相同结果在这一链中连续，可相邻合并。")$O(n W)$#text(" 时间、")$O(W)$#text(" 空间。OR 版本把 & 换成 |。")

*伪代码*（需结合题目接口实现）

#trick-code("cur = empty; answer = 0\nfor x in a:\n  next = [(x, 1)]\n  for (value, count) in cur:\n    y = value & x\n    if next.back.value == y:\n      next.back.count += count\n    else:\n      next.push_back((y, count))\n  cur = next\n  for (value, count) in cur:\n    if value == K: answer += count")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("固定左端点的 AND/OR 可跳变化点") <trick-bit-14>

*问题概述*　#text("给定 ")$W$#text(" 位非负整数数组，固定左端点 ")$l$#text("，求 ")$sum _(r=l)^n op("and")(a_l…a_r)$#text("，或对应的 OR 总和。已能快速查询任意区间的 ")$op("and")/op("or")$#text("，要求把连续相同结果的右端点段一次计入，不逐个枚举 ")$r$#text("。")

*必要思路*　#text("用稀疏表或区间结构查询 ")$op("and")/op("or")$#text("，通过单调性二分当前值能保持到的最远右端点，一次处理整段。每个端点最多 ")$O(W)$#text(" 种结果；XOR 不单调，不能照用变化段方法。自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/sparse-table.html")[#text("CP-Algorithms：Sparse Table")]。

=== #text("优化 AND 答案：高位试着保留") <trick-bit-15>

*问题概述*　#text("给定 ")$n$#text(" 个 ")$W$#text(" 位非负整数和整数 ")$1≤k≤n$#text("，恰选 ")$k$#text(" 个不同下标，使所选元素的按位 AND 值最大，求该最大值。除了选择个数外没有下标、和、邻接等额外约束；")$k=2$#text(" 是两数版本。")

*必要思路*　#text("从高位到低位试设 ")$op("cand")=op("ans")|(1 op("<<") b)$#text("，数满足 ")$(a_(i) op("&") op("cand"))==op("cand")$#text(" 的个数；至少 ")$k$#text(" 个就接受。该集合包含全部已接受位，且数值高位优先，所以贪心成立。若还要求两数和等约束，单纯数个数不够。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("最大 XOR 与可任取子集 XOR 是两种问题") <trick-bit-16>

*问题概述*　#text("给定 ")$n$#text(" 个非负整数，区分两个目标：①")$n≥2$#text(" 时恰选两个不同下标求 XOR 最大值；②任取一个下标子集求 XOR 最大值，允许空集。两个目标分别要求只使用两原数和允许使用任意多个原数，不能互换算法。")

*必要思路*　#text("两个现有数用 01 Trie 高位贪心找反位；任意子集用线性基消元。线性基会生成输入中不存在的组合值，不能代替 Trie 解“恰好两个原数”。有下标限制时查询前只插合法下标。")

*参考*　#link("https://oi-wiki.org/math/linear-algebra/basis/")[#text("OI Wiki：线性基")]。

=== #text("线性基判可达与计数") <trick-bit-17>

*问题概述*　#text("给定 ")$n$#text(" 个有编号的 ")$W$#text(" 位非负整数及目标 ")$X$#text("，求是否存在下标子集 ")$S$#text(" 使 ")$op("xor")_(i∈S)a_i=X$#text("，并求这样的子集个数。包含空集，不限制子集大小；重复数值不同下标分别计为不同选择。")

*必要思路*　#text("将 ")$X$#text(" 用同一高位基消去，最终为 0 则可达。基秩为 ")$r$#text("，每个可达 ")$X$#text(" 都有 ")$2^(n-r)$#text(" 个子集映射到它，来自线性映射核维数。空集包含在内；若限制子集大小，单个普通基不够。")

*参考*　#link("https://oi-wiki.org/math/linear-algebra/basis/")[#text("OI Wiki：线性基")]。

=== #text("全局 XOR 标记不移动 Trie 节点") <trick-bit-18>

*问题概述*　#text("维护 ")$W$#text(" 位非负整数多重集合，支持插入 ")$x$#text("、删除一份已存在的 ")$x$#text("、把全部现有元素同时 XOR K，以及给定 ")$x$#text(" 查询 ")$max_y(x op("xor") y)$#text("。查询时集合保证非空，插入删除的 ")$x$#text(" 都表示当时的真实数值。")

*必要思路*　#text("维护全局 tag，存底层值 ")$op("raw")=$#text("真实值 xor tag；全局修改只 ")$op("tag") op("xor")=K$#text("。查询真实 ")$x$#text(" 的最大异或等价查 raw 与 x xor tag。插入、删除都先翻译坐标；按真实数值排序则需按 tag 的各位解释 Trie 分支。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("bitset 背包：布尔状态批量平移") <trick-bit-19>

*问题概述*　#text("给定 ")$n$#text(" 件重量为正整数的物品，每件至多选一次，容量 ")$V$#text("。求 0…V 中哪些总重量可由下标子集组成，允许空集；只问可达性，不求价值、最少件数或精确方案数。")

*必要思路*　#text("")$op("bits")_(0)=1$#text("，每个重量 ")$w$#text(" 执行 ")$op("bits")|=op("bits") op("<<") w$#text("，一次位移并 OR 表示完整旧层的转移，约 O(nV/机器字长)。负重量需平移值域并设计双向位移；求最大价值或精确计数不能直接用布尔 bitset。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("bitset 记录新出现的和以恢复方案") <trick-bit-20>

*问题概述*　#text("在上一条 ")$0/1$#text(" 可达性模型中，再给目标 ")$T≤V$#text("。若 ")$T$#text(" 可达，要求输出一组物品下标，使重量和恰为 ")$T$#text(" 且每件最多一次；只要求任意合法方案，不要求所选件数最少。")

*必要思路*　#text("计算 ")$op("new")=(op("old") op("<<") w) op("&")  op("~") op("old")$#text("，仅对新出现的和记 (物品编号,前驱和)。每个和首次出现一次，记录总量 ")$O(V)$#text("，之后沿前驱恢复；位移前快照须正确。若要最少件数，首次出现不等于最优。此为“每状态只记录一次”的自行推导。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。

=== #text("二维 0/1 关系压成 bitset") <trick-bit-21>

*问题概述*　#text("给定 ")$n$#text(" 点简单无向图，多次询问不同节点 ")$u$#text("、")$v$#text(" 的公共邻居数，公共邻居必须同时与两点有边。另一独立模型为有向图的可达性闭包，求所有点对是否存在路径；本条强调用位集合批量处理布尔关系，两个模型不能混淆。")

*必要思路*　#text("每点邻居压成位集，共同邻居数是 ")$(op("adj")_(u) op("&") op("adj")_(v)).op("count")()$#text("。传递闭包可按 ")$k$#text(" 阶段，对能达 ")$k$#text(" 的行 ")$op("or") op("reach")_(k)$#text("。仍有 ")$O(n^2)$#text(" 或 ")$O(n^3/op("word"))$#text(" 量级，需估算矩阵内存；不是有位集就变线性。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("区间中某一位为 1 的个数") <trick-bit-22>

*问题概述*　#text("给定非负整数 ")$L≤R$#text(" 和位号 ")$b≥0$#text("，二进制最低位编号为 0。求区间内满足 ")$((x op(">>") b) op("&") 1)=1$#text(" 的整数 ")$x$#text(" 的数量，按整数计数；要求显式控制 ")$2^(b+1)$#text(" 与 ")$R+1$#text(" 的中间溢出。")

*必要思路*　#text("")$0 dots.h x$#text(" 中该位周期为 ")$2^(b+1)$#text("，每周期后一半为 1：令 ")$m=x+1$#text("、")$h=2^b$#text("，数量")$=(m/(2h))h+max(0,m mod (2h)-h)$#text("。区间做前缀差。最大位的 2h 与 ")$x+1$#text(" 可能溢出，必要时用 128 位。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("bitset 小块 RMQ：把单调栈存成掩码") <trick-bit-23>

*问题概述*　#text("给定静态数值数组，回答大量闭区间 [l,r] 的最大值查询。把数组分成长度不超过机器字位数 ")$W$#text(" 的小块，要求块内查询 ")$O(1)$#text("，跨块用预处理的整块最值结构；相等最大值只求数值，不要求特定下标。")

*必要思路*　#text("在不超过机器字长的小块内，单调栈保存可能成为区间最大值的位置，并为每个右端点保存掩码；移掉 ")$l$#text(" 之前的位，最低置位位置就是候选最大值。完整块用 ST 表。最值同值弹栈规则必须一致，查询掩码非零再 ctz。")

*参考*　#link("https://www.luogu.com.cn/article/f3jhcq3e")[#text("洛谷 critnos：位运算技术")]。

=== #text("Gray Code：枚举时只改一个元素") <trick-bit-24>

*问题概述*　#text("给定 ")$n$#text(" 个元素和可维护的集合代价 f(S)，加入或移除单个元素能快速更新。要求枚举全部 ")$2^n$#text(" 个下标集合且每个一次，枚举过程中相邻两个集合只改变一个元素；不要求按二进制数值递增输出。")

*必要思路*　#text("以 ")$g(i)=i op("xor")(i op(">>") 1)$#text(" 的 Gray 顺序枚举，相邻掩码恰差一位；对两个掩码 XOR 后定位该位，执行一次增删更新。总状态仍 ")$2^n$#text("，只减少更新成本；")$n$#text(" 必须能放入所用整数且可承受枚举量。")

*参考*　#link("https://cp-algorithms.com/algebra/gray-code.html")[#text("CP-Algorithms：Gray Code")]。

=== #text("有限位域的取反与移位边界") <trick-bit-25>

*问题概述*　#text("给定有效位数 ")$1≤w≤W$#text(" 和只含低 ")$w$#text(" 位的无符号掩码 ")$S$#text("，构造同一有限全集中的补集及全 1 掩码。还需要在 ")$S≠0$#text(" 时求最低置位号；要求 ")$w=W$#text(" 和 ")$S=0$#text(" 时也不触发非法移位或未定义的零输入操作。")

*必要思路*　#text("使用 unsigned 类型，")$W$#text(" 位全集是明确的 ")$U$#text("，再做 U xor S。1ULL<<b 仅当 b<64；64 位全 1 用 ~0ULL，不能 ")$(1op("ULL") op("<<") 64)-1$#text("。GCC 的 ctz/clz 对 0 未定义，")$C++20$#text(" 的 countr_zero 等另有定义，不能混淆。")

*参考*　#link("https://cp-algorithms.com/algebra/bit-manipulation.html")[#text("CP-Algorithms：位操作")]。

=== #text("最高不同位决定 XOR 比较") <trick-bit-26>

*问题概述*　#text("给定非空合法候选集合 ")$A$#text(" 和 ")$W$#text(" 位非负查询值 ")$x$#text("，求使 x XOR a 最大的 ")$a∈A$#text("。若候选还有时间、下标等约束，分支中必须保留至少一个满足约束的完整候选；目标是数值最大，不是逐位任选值拼成不存在的数。")

*必要思路*　#text("若两个候选高于 ")$b$#text(" 的位相同而 ")$b$#text(" 位不同，")$b$#text(" 位为 1 的异或值一定更大，故从高位决策。Trie 查询可据此贪心；不过存在可行性约束时，所选分支必须含合法候选，不能只看该位有没有 1。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。
