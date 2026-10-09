// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("树默认无向连通无环。距离与直径性质默认非负边权；按边贡献求距离和仍允许负边权。深树遍历注意调用栈。")

#text("训练优先级：A 优先掌握，B 常用进阶，C 拓展储备；不是题目官方难度。每条参考链接用于追溯知识，应用情景和边界由本文重新整理。")

=== #text("TREE-01 [A] 子树拍平成连续区间") <trick-tree-01>

*问题概述*　#text("对子树做修改、查询或按子树筛选节点，直接遍历每次 O(n)。")

*必要思路*　#text("只在首次进入节点时编号，子树对应 [tin[u],tout[u]]，转成序列区间。不要把首次编号与用于 LCA 的“反复记录父节点”的欧拉序混用。边权放在较深端点时，子树内部边应排除 u 自己。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。

=== #text("TREE-02 [A] 祖先关系由进入退出时间判定") <trick-tree-02>

*问题概述*　#text("大量判断 u 是否为 v 的祖先，想避免每次沿父亲跳。")

*必要思路*　#text("u 是 v 的祖先当且仅当 tin[u]≤tin[v]≤tout[u]。配合子树区间可把“属于某祖先分支”变区间包含；这是固定根下的性质，换根后需分类，不能继续直接比较原区间。")

*参考*　#link("https://cp-algorithms.com/graph/lca_binary_lifting.html")[#text("CP-Algorithms：倍增 LCA")]。

=== #text("TREE-03 [A] 树上异或路径不用 LCA") <trick-tree-03>

*问题概述*　#text("边有异或权值，查询两点间路径异或，或找最大异或路径。")

*必要思路*　#text("令 xr[u] 为根到 u 的边权异或，则路径值为 xr[u] xor xr[v]，公共前缀自动抵消。点权路径会把 LCA 的点权抵消掉，需要额外补上该点；不能将加法距离也省掉 LCA。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("TREE-04 [A] 全点对距离：把点对换成边贡献") <trick-tree-04>

*问题概述*　#text("求所有无序点对的距离和，n² 枚举不可行。")

*必要思路*　#text("删去边 e 后两侧为 s 与 n-s 个点，恰有 s(n-s) 个点对经过此边；答案 Σw_e s(n-s)。指定关键点则改成两侧关键点数量乘积；有序点对乘 2。公式本身允许负权边，但“最远”性质另论。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("TREE-05 [A] 点差分：批量统计经过各点的路径") <trick-tree-05>

*问题概述*　#text("给很多 u-v 路径，求每个点被经过多少次。")

*必要思路*　#text("c=LCA(u,v)，做 d[u]++,d[v]++,d[c]--,d[parent(c)]--；根的父亲不存在则跳过。最后子树向父亲累加，得到点覆盖数。端点与 LCA 各保留一次，用一条长度 0 的路径检查边界。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。

=== #text("TREE-06 [A] 边差分：LCA 要减两次") <trick-tree-06>

*问题概述*　#text("给很多路径，求每条树边的覆盖次数。")

*必要思路*　#text("做 d[u]++,d[v]++,d[LCA(u,v)]-=2，再向上汇总；非根点 v 的汇总量即边 parent[v]-v 被走的次数。点差分和边差分不能混用，u=v 时所有边贡献应为 0。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。

=== #text("TREE-07 [A] 全根距离和：换根只改变两侧") <trick-tree-07>

*问题概述*　#text("对每个根 u 求所有节点到 u 的距离总和。")

*必要思路*　#text("先求一个根的答案及子树大小。跨边 u-v（v 是儿子）换根时，v 侧 s 个点距离减 w，另一侧 n-s 个加 w，所以 ans[v]=ans[u]+w(n-2s)。有点权时用两侧权重和替代数量。")

*参考*　#link("https://usaco.guide/gold/all-roots")[#text("USACO Guide：全根树形 DP")]。

=== #text("TREE-08 [B] 一般换根：前后缀排除一个儿子") <trick-tree-08>

*问题概述*　#text("每个根都要算 DP，合并运算没有逆元，不能用总结果除去某个儿子。")

*必要思路*　#text("把每个方向来的贡献按结合律合并，儿子列表做前缀和后缀聚合。发给第 i 个儿子的消息由前 i-1 项、后 i+1 项、父侧贡献组成。运算不交换时还要固定次序；除法在模数下也未必可用。")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。

=== #text("TREE-09 [A] 非负权树的最远点由直径端点代表") <trick-tree-09>

*问题概述*　#text("每个节点到全树最远点的距离，逐点搜索会 O(n²)。")

*必要思路*　#text("取一条直径端点 A、B，ecc(u)=max(dist(u,A),dist(u,B))，做几次遍历即可。非负边权保证距离的树度量性质；负边权时这条代表性和两次最远搜索都可能失效，应改用树形 DP。")

*参考*　#link("https://oi-wiki.org/graph/tree-diameter/")[#text("OI Wiki：树的直径")]。

=== #text("TREE-10 [B] 点集合的直径可由四个端点合并") <trick-tree-10>

*问题概述*　#text("维护两个点集合的并集直径，不能扫描所有点。")

*必要思路*　#text("非负权树中，若 S、T 各自的直径端点为 (a,b)、(c,d)，并集直径只需比较这四点间距离。由“任意点对集合最远点可由集合直径端点代表”得出，适合在线段树中维护点集直径。空集合与单点集合单独表示。")

*参考*　#link("https://www.luogu.com/article/rjesrsyi")[#text("洛谷：树的相关内容")]。

=== #text("TREE-11 [A] 经过全部关键点：剪叶子得到最小连通子树") <trick-tree-11>

*问题概述*　#text("树上只需走访若干指定点，原树大量枝杈与目标无关。")

*必要思路*　#text("反复删除非关键叶子，剩余树是连接关键点的最小子树。非负边权下，从任意位置开始和结束遍历关键点的最短路程为 2×剩余边权和-该子树直径；必须回到起点则需双走各边。固定端点时保留端点再算。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("TREE-12 [B] 关键点按 DFS 序成环：边被算两次") <trick-tree-12>

*问题概述*　#text("动态维护树上一组关键点连接出的最小子树总长度。")

*必要思路*　#text("关键点按 tin 排成环，相邻距离和 P 恰等于子树边权和的两倍。插入 x 只改前驱 p、后继 s：ΔP=dist(p,x)+dist(x,s)-dist(p,s)。集合仅一两个点时按环关系处理。注意是 P/2，不能漏掉回首距离或除二。自行推导。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。

=== #text("TREE-13 [B] 虚树：只补相邻关键点的 LCA") <trick-tree-13>

*问题概述*　#text("每次查询只有 k 个重要点，需要在它们之间做树形 DP。")

*必要思路*　#text("按 DFS 序排序，加入相邻点 LCA，再排序去重并按祖先关系连边，虚树规模 O(k)。虚边存原链需要的信息：长度、最小边权等；中间普通点若有独立贡献，必须先聚合，不能直接删除。仅清理本次用到的点。")

*实现提示*　#text("tin、tout、depth、LCA 需先在原树准备；ancestor(a,b) 检查 DFS 区间包含。加入相邻 LCA 后重新排序去重，栈中只保留祖先链。k=0 单独返回；构树 O(k log k) 加 O(k) 次 LCA。")

*伪代码*（需结合题目接口实现）

#trick-code("nodes = unique keys sorted by tin\nfor i = 1..size(nodes)-1 using the original list:\n  extra.push(LCA(nodes[i-1], nodes[i]))\nnodes = unique(nodes + extra), sorted by tin\nstack = empty\nfor u in nodes:\n  while stack not empty and not ancestor(stack.top(), u):\n    stack.pop()\n  if stack not empty:\n    p = stack.top()\n    add virtual edge p -> u\n    edge_length = distRoot[u] - distRoot[p]\n  stack.push(u)\nvirtual_root = nodes[0]")

*参考*　#link("https://oi-wiki.org/graph/virtual-tree/")[#text("OI Wiki：虚树")]。

=== #text("TREE-14 [B] 虚树边贡献：结构点不是计数对象") <trick-tree-14>

*问题概述*　#text("求指定关键点之间的距离和，或隔离它们与固定根的最小代价。")

*必要思路*　#text("距离和用虚树子树关键数 c：边贡献 w c(k-c)。切边问题要求固定根不是待隔离的关键点。若是非负切边代价，虚边取原链最小值，关键儿子必须切，非关键儿子取 min(切边,儿子 DP)。补入的 LCA 和固定根不自动算关键对象。")

*实现提示*　#text("本段仅对应最小切边隔离。构虚树前补入固定根；虚边 cutCost 用原树倍增/树剖查链上最小切边代价，不能使用距离权重。根不能是关键点。")

*伪代码*（需结合题目接口实现）

#trick-code("postorder(u):\n  dp[u] = 0\n  for virtual child v of u:\n    postorder(v)\n    c = minimum cut cost on original path u -> v\n    if v is a key:\n      dp[u] += c\n    else:\n      dp[u] += min(c, dp[v])\nanswer = dp[fixed_root]")

*参考*　#link("https://oi-wiki.org/graph/virtual-tree/")[#text("OI Wiki：虚树")]。

=== #text("TREE-15 [B] 连通块 DP 强制包含最高点") <trick-tree-15>

*问题概述*　#text("求树上连通点集的方案数，朴素“子树任意答案”合并容易重复。")

*必要思路*　#text("令 f[u] 只数子树内且包含 u 的连通集，每个儿子选不连接或连接一个包含该儿子的集。每个非空连通集有唯一深度最小点，把 f[u] 求和便不重不漏；不能把已不连着儿子根的集合拿来连接。")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。

=== #text("TREE-16 [B] 树上背包“平方”看节点对") <trick-tree-16>

*问题概述*　#text("每个节点把儿子背包合并，循环是两重大小枚举，复杂度看上去 O(n³)。")

*必要思路*　#text("若每个子树数组长度受真实子树大小限制，跨两个儿子集合的节点对只在其 LCA 处计一次，可把总合并工作按 O(n²) 分析；容量截断后要按实际循环重算。若每次都扫全局 n 维，或每条边做任意卷积，不能套这个界。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("TREE-17 [B] 启发式合并：小集合搬进大集合") <trick-tree-17>

*问题概述*　#text("对子树统计颜色频次、不同值或维护 map，逐层复制集合会很慢。")

*必要思路*　#text("按当前集合大小从小向大合并。若每个对象搬迁后所在容器规模至少翻倍，每个对象只搬 O(log n) 次；容器每次插入的成本另算。键去重场景要单独核查搬迁分析，不可把所有合并都当作线性。")

*参考*　#link("https://oi-wiki.org/graph/dsu-on-tree/")[#text("OI Wiki：树上启发式合并")]。

=== #text("TREE-18 [B] 点分治：整棵子树先查后加") <trick-tree-18>

*问题概述*　#text("统计树上满足距离条件的点对，在一个重心处处理跨儿子子树的路径。")

*必要思路*　#text("维护已处理子树到重心的距离信息；对当前子树所有点先查询贡献，再整批插入，避免同子树点对重复计入。递归处理删去重心后的各块。距离超阈值剪枝要求非负权；DFS 本身仍可能在长链上爆栈。")

*实现提示*　#text("例：整数非负边权，统计距离恰为 K 的无序点对。cnt 可用哈希表，或范围可控时用数组加 touched 清理；同一儿子整批先查后加。哈希实现每层期望线性。")

*伪代码*（需结合题目接口实现）

#trick-code("process_centroid(c):\n  cnt.clear(); cnt[0] = 1\n  for undeleted neighbor v of c:\n    D = collect distances from c in subtree v\n    // collect skips parent and deleted vertices\n    // distances > K may be pruned for nonnegative edges\n    for d in D:\n      answer += cnt.get(K-d, default=0)\n    for d in D:\n      cnt[d] += 1\n  // delete c, recursively decompose remaining components\n// answer uses 64-bit integer; collect DFS may need an explicit stack")

*参考*　#link("https://oi-wiki.org/graph/tree-divide/")[#text("OI Wiki：树分治")]。

=== #text("TREE-19 [B] 重心的本质是平衡分割") <trick-tree-19>

*问题概述*　#text("需要选根使最大剩余连通块尽量小，或构造分治树。")

*必要思路*　#text("每个候选 u 检查 max(n-sz[u],各儿子 sz)，取最小者；重心删后每块≤n/2。节点等权且边长为正时，重心还最小化到所有节点的距离和；有非负节点权时改用子树权重判断加权中位点。负边长不能沿用这一距离结论。")

*参考*　#link("https://oi-wiki.org/graph/tree-centroid/")[#text("OI Wiki：树的重心")]。

=== #text("TREE-20 [A] 删一个点：答案是各分支的交叉贡献") <trick-tree-20>

*问题概述*　#text("删点 u 后，问有多少点对不再连通，或经过 u 的路径数量。")

*必要思路*　#text("剩余分支大小为 s_i，先算 Σ_{i<j}s_i s_j=((n-1)²-Σs_i²)/2；若路径允许端点为 u，再加 n-1。可逐分支用累计数乘当前大小避免平方溢出。这是唯一树路径经过 u 的自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("TREE-21 [B] 换根后的子树只分三种情况") <trick-tree-21>

*问题概述*　#text("固定建树后，询问以 r 为新根时 u 的子树和。")

*必要思路*　#text("u=r 则是全树；u 不是原根下 r 的祖先，则仍是原子树；否则找到 u 朝 r 方向的儿子 c，新子树为全树减原子树 c。用祖先判断和倍增找 c，最终是一段或两段序列区间。")

*参考*　#link("https://oi-wiki.org/graph/hld/")[#text("OI Wiki：树链剖分")]。

=== #text("TREE-22 [B] 路径顺序敏感：左右两端分别收集") <trick-tree-22>

*问题概述*　#text("树链剖分维护路径上的矩阵乘积或字符串，普通区间求和写法得出错误顺序。")

*必要思路*　#text("从 u、v 两侧分别收集链段，维护每段正向和反向聚合；拼接时 u 侧向上、v 侧向下，最后接 LCA 附近段。结合律足够做区间结构，但非交换运算不能随意交换链段。")

*参考*　#link("https://oi-wiki.org/graph/hld/")[#text("OI Wiki：树链剖分")]。

=== #text("TREE-23 [B] 点集 LCA 只看 DFS 序两端") <trick-tree-23>

*问题概述*　#text("一组节点求共同 LCA，需要反复合并所有节点。")

*必要思路*　#text("非空集合的共同 LCA= LCA(tin 最小节点,tin 最大节点)。某祖先子树在 DFS 序中连续：若同时含两端，就含中间所有集合点，故可据此证明。可在线段树维护集合两端，不能改用节点编号最小最大。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("TREE-24 [B] 树同构：儿子类型排序后编码") <trick-tree-24>

*问题概述*　#text("判断两棵无标号树是否同构，节点编号和儿子顺序不可靠。")

*必要思路*　#text("有根树把儿子类型 ID 排序，将整个列表映射成新 ID；精确字典可避免随机哈希碰撞。无根树先找中心（不断剥叶，最后一个或两个点），比较其根化形式；中心与重心不是同一概念。")

*参考*　#link("https://oi-wiki.org/graph/tree-hash/")[#text("OI Wiki：树哈希")]。

=== #text("TREE-25 [B] 基环树：先剥树枝，再处理环") <trick-tree-25>

*问题概述*　#text("简单无向连通图恰有一个环，想把树 DP 扩展到整个图。")

*必要思路*　#text("按度数 1 剥叶找环，把各挂树汇总到环点。若做点独立集等 DP，可固定首环点选/不选再跑链式 DP，并检查最后与第一点的兼容；不能随便断边忽略环约束。任意多环图已不是该模型。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("TREE-26 [C] 树计数用度数出现次数") <trick-tree-26>

*问题概述*　#text("求 n 个有标号点构成的树数，或限制每个点度数。")

*必要思路*　#text("Prüfer 序列长度 n-2，点 i 出现 d_i-1 次。普通树总数 n^(n-2)；给定正整数度数且总和 2(n-1)，树数 (n-2)!/Π(d_i-1)!。n=1、2 独立处理，模数除法需合法逆元。")

*参考*　#link("https://cp-algorithms.com/graph/pruefer_code.html")[#text("CP-Algorithms：Prüfer 编码")]。

