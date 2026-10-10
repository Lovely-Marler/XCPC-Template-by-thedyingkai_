#import "../../template/trick-code.typ": trick-code
#import "../../template/topic.typ": render-topic

#let tree-intro = [
#text("树默认无向连通无环。距离与直径性质默认非负边权；按边贡献求距离和仍允许负边权。深树遍历注意调用栈。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")
]

#let tree-topics = (
  "trick-tree-01": (title: [#text("子树拍平成连续区间")], body: [
*问题概述*　#text("给定固定根 ")$r$#text(" 的树，每点有数值 ")$a_u$#text("，执行对子树全部节点加 ")$d$#text("、查询子树数值和等操作。子树指在同一固定根下包含 ")$u$#text(" 及其全部后代的点集；要求把操作映射为序列中的一个连续区间，且每点只对应一个数组位置。")

*必要思路*　#text("只在首次进入节点时编号，子树对应 ")$[op("tin")_(u),op("tout")_(u)]$#text("，转成序列区间。不要把首次编号与用于 LCA 的“反复记录父节点”的欧拉序混用。边权放在较深端点时，子树内部边应排除 ")$u$#text(" 自己。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。

===== #text("延伸：固定根树的 DFS 首次访问序数量")

*延伸问题*　#text("给定节点编号互异的无向树及固定根 ")$r$#text("。DFS 每次完整访问一个儿子子树后才访问下一儿子，每点只在首次进入时输出；各节点儿子访问顺序可任意排列。求不同完整输出序列数，不计返回父亲时的重复输出。")

*必要思路*　#text("设 ")$c_u$#text(" 为固定根下 ")$u$#text(" 的儿子数，答案为 ")$product_u c_u!$#text("。各节点独立选择儿子排列；每个儿子子树是不可拆散的连续块，不同排列产生不同序列，反之序列能唯一确定这些排列。不能改用 degree(u)!：非根点的父亲不是儿子。若邻接表顺序已经固定，只会得到一种 DFS 序。")

*依据*　由定义推导，证明或边界已给出。

===== #text("延伸：只给 DFS 前序，能有多少棵树")

*延伸问题*　#text("给定 ")$n≥1$#text(" 个互异标签的排列 ")$p$#text("，指定根为 ")$p_1$#text("。统计这些标签上的简单无向树，使存在一种儿子访问顺序，DFS 首次进入序恰为 ")$p$#text("；同一棵带标签树只计一次。没有边集合、度数或编号排序限制，儿子顺序可以自由选择。")

*必要思路*　#text("每种有序根树形状，按前序位置依次填入 ")$p$#text("，得到一棵候选树；反之给定树及 ")$p$#text("，各儿子子树的先后次序由它们在 ")$p$#text(" 的位置唯一确定，因此两者一一对应。")$n$#text(" 点有序根树由 ")$n-1$#text(" 次下行、")$n-1$#text(" 次上行的合法括号编码计数，答案为 ")$binom(2n-2,n-1)-binom(2n-2,n)$#text("，即 ")$op("Catalan")(n-1)$#text("。注意这不是任意标号树的 Cayley 数。")

*参考*　#link("https://cp-algorithms.com/combinatorics/catalan-numbers.html")[#text("CP-Algorithms：Catalan 数")]。

===== #text("延伸：若儿子必须按标签递增访问")

*延伸问题*　#text("仍给定互异标签前序 ")$p$#text("，根为 ")$p_1$#text("，但 DFS 必须按儿子标签从小到大访问。统计符合该序列的简单无向树，不能再任意选择儿子顺序；只保留父子关系作为树方案。")

*必要思路*　#text("不再统一是 Catalan 数。令 ")$F(l,r)$#text(" 为以 ")$p_l$#text(" 为根、前序区间恰为 [l,r] 的树数。其儿子子树把 ")$[l+1,r]$#text(" 划分为连续非空段，各段首元素即儿子标签，必须严格递增。定义 G(pos,last,r) 为剩余区间 [pos,r] 的合法儿子森林数，按下段终点 ")$t$#text(" 枚举并乘 ")$F(op("pos"),t)$#text("。用区间长度及 last 状态记忆化，至多 ")$O(n^3)$#text(" 状态、O(n⁴) 转移；last 可以离散为标签排名，并用 0 哨兵。")

#trick-code("F(l,r):\n  return G(l+1, 0, r)  // labels ranked 1..n\nG(pos,last,r):\n  if pos > r: return 1\n  if rank(p[pos]) <= last: return 0\n  answer = 0\n  for t = pos..r:\n    answer += F(pos,t) * G(t+1,rank(p[pos]),r)\n  return answer\n// memoize F and G; answer = F(1,n)")

*依据*　由定义推导，证明或边界已给出。

===== #text("延伸：给前序与深度，树是否唯一")

*延伸问题*　#text("给定互异标签前序 ")$p_1…p_n$#text(" 及相应节点深度 ")$d_1…d_n$#text("。根深度为 0，每沿一条树边向下深度加 1。判断是否存在符合两序列的有根树，并在存在时恢复父亲；儿子顺序按给定前序确定。")

*必要思路*　#text("必须 ")$d_1=0$#text("，其他深度为正，且 ")$d_i≤d_(i-1)+1$#text("。维护前序访问中的祖先栈：处理深度 ")$d$#text(" 时弹到栈长 ")$d$#text("，栈顶就是唯一父亲，再压入新点。越级加深或第二个深度 0 均非法。由每点父亲唯一可得树唯一，")$O(n)$#text(" 恢复；只给前序而不给深度则通常不唯一。")

*依据*　由定义推导，证明或边界已给出。

===== #text("延伸：前序加后序与二叉树的单儿子歧义")

*延伸问题*　#text("给定互异标签的前序 ")$P$#text(" 和后序 ")$Q$#text("，二者均按每点一次记录。一般有序根树模型中，要求判断是否合法并恢复树；二叉树变形则区分左、右孩子，统计具有同一前后序的二叉树数。")

*必要思路*　#text("先验证两序列标签集合相同、各标签只出现一次，且 ")$P$#text(" 的首项等于 ")$Q$#text(" 的末项。按 ")$P$#text(" 依次压栈并挂到当前栈顶；只要栈顶等于 ")$Q$#text(" 的下一个待完成节点就弹栈，序列结束必须同时全部用完且不能提前弹空。节点标签唯一时，一般有序根树结构由此确定。二叉模型还须每点儿子数")$≤2$#text("；有两儿子时前后次序固定，只有一个儿子时可放左或右，因此有 ")$s$#text(" 个单儿子节点时计数为 ")$2^s$#text("。")

*依据*　由定义推导，证明或边界已给出。

===== #text("延伸：一般图的 DFS 数量不能直接乘出度阶乘")

*延伸问题*　#text("给定图、起点和标准递归 DFS：只在首次访问输出节点，已访问邻居跳过，完成当前递归后继续扫描邻居。允许改变各点邻居扫描顺序，要求统计不同首次访问输出序列，而非邻接表排列数；图中可有共享后继。")

*必要思路*　#text("同一邻接表排列选择可能输出相同序列，因为扫描到已访问邻居时不会再输出；共享后继也使分支不独立。因此树上的儿子阶乘公式不适用。小图可枚举扫描顺序或 DFS 分支，以完整输出序列去重作校验器；大图必须利用题目结构另建状态，不能凭 DAG 无环就照搬根树公式。先区分首次访问序、DFS 生成树、回溯日志三种计数对象。")

*依据*　由定义推导，证明或边界已给出。
  ]),

  "trick-tree-02": (title: [#text("祖先关系由进入退出时间判定")], body: [
*问题概述*　#text("给定以 ")$r$#text(" 为固定根的树和多组节点对 (u,v)，判断 ")$u$#text(" 是否为 ")$v$#text(" 的祖先。本条把节点自身也视为自己的祖先，根在全部询问中不变；预处理后希望每次判断为 ")$O(1)$#text("。")

*必要思路*　#text("")$u$#text(" 是 ")$v$#text(" 的祖先当且仅当 ")$op("tin")_(u)≤op("tin")_(v)≤op("tout")_(u)$#text("。配合子树区间可把“属于某祖先分支”变区间包含；这是固定根下的性质，换根后需分类，不能继续直接比较原区间。")

*参考*　#link("https://cp-algorithms.com/graph/lca_binary_lifting.html")[#text("CP-Algorithms：倍增 LCA")]。
  ]),

  "trick-tree-03": (title: [#text("树上异或路径不用 LCA")], body: [
*问题概述*　#text("给定无向树，每条边有 ")$W$#text(" 位非负整数权值。对多组 (u,v)，求唯一简单路径上全部边权的按位 XOR；")$u=v$#text(" 时空路径值为 0。扩展目标可为全部点对路径 XOR 的最大值，但本条权值在边上而非点上。")

*必要思路*　#text("令 ")$op("xr")_(u)$#text(" 为根到 ")$u$#text(" 的边权异或，则路径值为 ")$op("xr")_(u) op("xor") op("xr")_(v)$#text("，公共前缀自动抵消。点权路径会把 LCA 的点权抵消掉，需要额外补上该点；不能将加法距离也省掉 LCA。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。
  ]),

  "trick-tree-04": (title: [#text("全点对距离：把点对换成边贡献")], body: [
*问题概述*　#text("给定 ")$n$#text(" 点无向树及整数边权 ")$w_e$#text("，定义 dist(u,v) 为唯一简单路径的边权和。求 ")$sum _(1≤u<v≤n)op("dist")(u,v)$#text("，按两个不同节点组成的无序对计数，不计自身点对；边权允许为负，仍按路径和定义。")

*必要思路*　#text("删去边 ")$e$#text(" 后两侧为 ")$s$#text(" 与 n-s 个点，恰有 s(n-s) 个点对经过此边；答案 ")$sum  w_e s(n-s)$#text("。指定关键点则改成两侧关键点数量乘积；有序点对乘 2。公式本身允许负权边，但“最远”性质另论。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。
  ]),

  "trick-tree-05": (title: [#text("点差分：批量统计经过各点的路径")], body: [
*问题概述*　#text("给定树及 ")$q$#text(" 条由端点 ")$(u_i,v_i)$#text(" 指定的简单路径。求每个节点出现在多少条路径中，路径两个端点都计入；")$u_i=v_i$#text(" 的路径只包含该节点，重复询问按出现次数计数。")

*必要思路*　#text("")$c=op("LCA")(u,v)$#text("，做 ")$d_(u)++,d_(v)++,d_(c)--,d_(op("parent")(c))--$#text("；根的父亲不存在则跳过。最后子树向父亲累加，得到点覆盖数。端点与 LCA 各保留一次，用一条长度 0 的路径检查边界。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。
  ]),

  "trick-tree-06": (title: [#text("边差分：LCA 要减两次")], body: [
*问题概述*　#text("给定树及 ")$q$#text(" 条端点指定的简单路径，求每条原树边被这些路径经过的次数。点对路径无方向，重复路径重复计数；当两个端点相同，本次对所有边的贡献均为 0。")

*必要思路*　#text("做 ")$d_(u)++,d_(v)++,d_(op("LCA")(u,v))-=2$#text("，再向上汇总；非根点 ")$v$#text(" 的汇总量即边 ")$op("parent")_(v)-v$#text(" 被走的次数。点差分和边差分不能混用，")$u=v$#text(" 时所有边贡献应为 0。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。
  ]),

  "trick-tree-07": (title: [#text("全根距离和：换根只改变两侧")], body: [
*问题概述*　#text("给定 ")$n$#text(" 点无向树和整数边权，对每个节点 ")$u$#text(" 求 ")$D_u= sum _v op("dist")(u,v)$#text("，dist 为唯一简单路径上的边权和，包含 ")$op("dist")(u,u)=0$#text("。节点均按权重 1 计入，要求一次预处理得到全部 ")$n$#text(" 个答案。")

*必要思路*　#text("先求一个根的答案及子树大小。跨边 u-v（")$v$#text(" 是儿子）换根时，")$v$#text(" 侧 ")$s$#text(" 个点距离减 ")$w$#text("，另一侧 n-s 个加 ")$w$#text("，所以 ")$op("ans")_(v)=op("ans")_(u)+w(n-2s)$#text("。有点权时用两侧权重和替代数量。")

*参考*　#link("https://usaco.guide/gold/all-roots")[#text("USACO Guide：全根树形 DP")]。
  ]),

  "trick-tree-08": (title: [#text("一般换根：前后缀排除一个儿子")], body: [
*问题概述*　#text("给定树和结合运算 op，带单位元 ")$e$#text("。对每条有向邻接关系 u→v，定义消息 M(u→v) 为 ")$u$#text(" 侧连通块对 ")$v$#text(" 的贡献：从其余邻居送入 ")$u$#text(" 的消息按规定次序合并，再经已知节点转移函数处理。求全部方向消息及每个点作为根的结果，op 不要求可逆或可交换。")

*必要思路*　#text("把每个方向来的贡献按结合律合并，儿子列表做前缀和后缀聚合。发给第 ")$i$#text(" 个儿子的消息由前 ")$i-1$#text(" 项、后 ")$i+1$#text(" 项、父侧贡献组成。运算不交换时还要固定次序；除法在模数下也未必可用。")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。
  ]),

  "trick-tree-09": (title: [#text("非负权树的最远点由直径端点代表")], body: [
*问题概述*　#text("给定 ")$n$#text(" 点无向树，所有边权非负。对每个节点 ")$u$#text("，求 ")$max_v op("dist")(u,v)$#text("，其中 dist 是唯一简单路径长度，")$v$#text(" 可以等于 ")$u$#text("；要求在线性次遍历内得到全部节点的最远距离。")

*必要思路*　#text("取一条直径端点 ")$A$#text("、")$B$#text("，")$op("ecc")(u)=max(op("dist")(u,A),op("dist")(u,B))$#text("，做几次遍历即可。非负边权保证距离的树度量性质；负边权时这条代表性和两次最远搜索都可能失效，应改用树形 DP。")

*参考*　#link("https://oi-wiki.org/graph/tree-diameter/")[#text("OI Wiki：树的直径")]。
  ]),

  "trick-tree-10": (title: [#text("点集合的直径可由四个端点合并")], body: [
*问题概述*　#text("给定同一棵非负边权树上的两个非空点集 ")$S$#text("、")$T$#text("，已知各集的一组直径端点 (a,b)、(c,d)。求并集 S∪T 的最大点对距离及一组取得该值的端点，不允许重新遍历集合全部元素；单点集合的两个端点可相同。")

*必要思路*　#text("非负权树中，若 ")$S$#text("、")$T$#text(" 各自的直径端点为 (a,b)、(c,d)，并集直径只需比较这四点间距离。由“任意点对集合最远点可由集合直径端点代表”得出，适合在线段树中维护点集直径。空集合与单点集合单独表示。")

*参考*　#link("https://www.luogu.com/article/rjesrsyi")[#text("洛谷：树的相关内容")]。
  ]),

  "trick-tree-11": (title: [#text("经过全部关键点：剪叶子得到最小连通子树")], body: [
*问题概述*　#text("给定非负边权树及非空关键点集合 ")$K$#text("。选择任意起点和终点，在树上行走并访问 ")$K$#text(" 中每个节点至少一次，允许重复经过点和边。求最短总路程；起终点由算法自由选择，不要求回到起点。")

*必要思路*　#text("反复删除非关键叶子，得到连接 ")$K$#text(" 的最小子树 ")$H$#text("。设 ")$W_H$#text(" 是其边权和，")$D_H$#text(" 是其直径长度，最短路程为 ")$2W_H-D_H$#text("：直径两端之间的边可只走一次，其余必须往返。若固定起终点 s,t，把 s,t 也纳入剪枝保留集合，答案改为 ")$2W_H-op("dist")(s,t)$#text("；若两者相同就是闭合行走。")

*依据*　自行推导/归纳，理由已写在思路中。
  ]),

  "trick-tree-12": (title: [#text("关键点按 DFS 序成环：边被算两次")], body: [
*问题概述*　#text("给定非负边权树，维护关键点集合 ")$K$#text("，支持插入一个尚不在集合的节点或删除一个已有节点。每次操作后求包含全部 ")$K$#text(" 的最小连通子树的边权和；集合为空或只有一个点时答案为 0。")

*必要思路*　#text("关键点按 tin 排成环，相邻距离和 ")$P$#text(" 恰等于子树边权和的两倍。插入 ")$x$#text(" 只改前驱 ")$p$#text("、后继 ")$s$#text("：")$Δ P=op("dist")(p,x)+op("dist")(x,s)-op("dist")(p,s)$#text("。集合仅一两个点时按环关系处理。注意是 ")$P/2$#text("，不能漏掉回首距离或除二。自行推导。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。
  ]),

  "trick-tree-13": (title: [#text("虚树：只补相邻关键点的 LCA")], body: [
*问题概述*　#text("给定已预处理 LCA 的固定根树，多次询问指定 ")$k$#text(" 个关键点。要求构造一棵节点数为 ")$O(k)$#text(" 的压缩树，保留关键点及所需分叉祖先，父子边对应原树的一条祖先链；后续 DP 只依赖这些链可聚合的信息，中间点的独立贡献必须先归并。")

*必要思路*　#text("按 DFS 序排序，加入相邻点 LCA，再排序去重并按祖先关系连边，虚树规模 ")$O(k)$#text("。虚边存原链需要的信息：长度、最小边权等；中间普通点若有独立贡献，必须先聚合，不能直接删除。仅清理本次用到的点。")

*实现提示*　#text("tin、tout、depth、LCA 需先在原树准备；ancestor(a,b) 检查 DFS 区间包含。加入相邻 LCA 后重新排序去重，栈中只保留祖先链。")$k=0$#text(" 单独返回；构树 ")$O(k log k)$#text(" 加 ")$O(k)$#text(" 次 LCA。")

*伪代码*（需结合题目接口实现）

#trick-code("nodes = unique keys sorted by tin\nfor i = 1..size(nodes)-1 using the original list:\n  extra.push(LCA(nodes[i-1], nodes[i]))\nnodes = unique(nodes + extra), sorted by tin\nstack = empty\nfor u in nodes:\n  while stack not empty and not ancestor(stack.top(), u):\n    stack.pop()\n  if stack not empty:\n    p = stack.top()\n    add virtual edge p -> u\n    edge_length = distRoot[u] - distRoot[p]\n  stack.push(u)\nvirtual_root = nodes[0]")

*参考*　#link("https://oi-wiki.org/graph/virtual-tree/")[#text("OI Wiki：虚树")]。
  ]),

  "trick-tree-14": (title: [#text("虚树边贡献：结构点不是计数对象")], body: [
*问题概述*　#text("同一棵树上的关键点询问有两种独立模型：①给非负距离边权及关键集合 ")$K$#text("，求不同关键点无序对的距离和；②给非负切边费用、固定根 ")$r$#text("∉")$K$#text("，删边使所有 ")$K$#text(" 中节点都与 ")$r$#text(" 不连通，求最小费用。压缩树的距离权与最小切边费用不能混用。")

*必要思路*　#text("距离和用虚树子树关键数 ")$c$#text("：边贡献 w c(k-c)。切边问题要求固定根不是待隔离的关键点。若是非负切边代价，虚边取原链最小值，关键儿子必须切，非关键儿子取 min(切边,儿子 DP)。补入的 LCA 和固定根不自动算关键对象。")

*实现提示*　#text("本段仅对应最小切边隔离。构虚树前补入固定根；虚边 cutCost 用原树倍增/树剖查链上最小切边代价，不能使用距离权重。根不能是关键点。")

*伪代码*（需结合题目接口实现）

#trick-code("postorder(u):\n  dp[u] = 0\n  for virtual child v of u:\n    postorder(v)\n    c = minimum cut cost on original path u -> v\n    if v is a key:\n      dp[u] += c\n    else:\n      dp[u] += min(c, dp[v])\nanswer = dp[fixed_root]")

*参考*　#link("https://oi-wiki.org/graph/virtual-tree/")[#text("OI Wiki：虚树")]。
  ]),

  "trick-tree-15": (title: [#text("连通块 DP 强制包含最高点")], body: [
*问题概述*　#text("给定无向树，统计所有非空节点子集 ")$S$#text("，使 ")$S$#text(" 所诱导的子图连通。按原节点编号区分子集，不能因选取根不同把同一 ")$S$#text(" 重复计数；可按指定模数输出方案数。")

*必要思路*　#text("令 ")$f_(u)$#text(" 只数子树内且包含 ")$u$#text(" 的连通集，每个儿子选不连接或连接一个包含该儿子的集。每个非空连通集有唯一深度最小点，把 ")$f_(u)$#text(" 求和便不重不漏；不能把已不连着儿子根的集合拿来连接。")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。
  ]),

  "trick-tree-16": (title: [#text("树上背包“平方”看节点对")], body: [
*问题概述*　#text("给定有根树，求恰选 ")$K$#text(" 个节点、所选点集连通且包含根时的最大节点权重和。使用子树背包并逐个合并儿子，每个数组长度不超过真实子树大小；要求分析所有合并的总复杂度，而非把每个节点都机械估为 ")$O(n^2)$#text("。")

*必要思路*　#text("令 ")$f_u(k)$#text(" 为 ")$u$#text(" 子树内选择 ")$k$#text(" 点、连通且含 ")$u$#text(" 的最大权值和，初始 ")$f_u(1)=w_u$#text("，其余不可达。每个儿子可不选，或连接一个含儿子根的方案；用双层枚举合并两份容量数组。数组按真实子树大小截断，则跨两个分支的节点对只在 LCA 处计一次，可按 ")$O(n^2)$#text(" 分析全部合并。目标容量 ")$K$#text(" 还能截断，但不能直接把所有模型都说成 ")$O(n K)$#text("。")

*依据*　自行推导/归纳，理由已写在思路中。
  ]),

  "trick-tree-17": (title: [#text("启发式合并：小集合搬进大集合")], body: [
*问题概述*　#text("给定固定根树，每个节点有颜色 ")$c_u$#text("。对每个 ")$u$#text(" 求其子树内各颜色的出现频次，或由频次得到不同颜色数等统计量。要求复用子树容器，避免把同一子树信息沿祖先链反复完整复制；颜色相同的键需要累计而非视为不同键。")

*必要思路*　#text("按当前集合大小从小向大合并。若每个对象搬迁后所在容器规模至少翻倍，每个对象只搬 ")$O(log n)$#text(" 次；容器每次插入的成本另算。键去重场景要单独核查搬迁分析，不可把所有合并都当作线性。")

*参考*　#link("https://oi-wiki.org/graph/dsu-on-tree/")[#text("OI Wiki：树上启发式合并")]。
  ]),

  "trick-tree-18": (title: [#text("点分治：整棵子树先查后加")], body: [
*问题概述*　#text("给定非负整数边权树及整数 ")$K≥0$#text("，统计不同节点无序对 {u,v}，满足唯一简单路径长度 ")$op("dist")(u,v)=K$#text("。点对只计一次，不计 ")$u=v$#text("；零权边允许，要求在点分治中避免把同一邻居子树内的点对算到当前重心。")

*必要思路*　#text("维护已处理子树到重心的距离信息；对当前子树所有点先查询贡献，再整批插入，避免同子树点对重复计入。递归处理删去重心后的各块。距离超阈值剪枝要求非负权；DFS 本身仍可能在长链上爆栈。")

*实现提示*　#text("例：整数非负边权，统计距离恰为 ")$K$#text(" 的无序点对。cnt 可用哈希表，或范围可控时用数组加 touched 清理；同一儿子整批先查后加。哈希实现每层期望线性。")

*伪代码*（需结合题目接口实现）

#trick-code("process_centroid(c):\n  cnt.clear(); cnt[0] = 1\n  for undeleted neighbor v of c:\n    D = collect distances from c in subtree v\n    // collect skips parent and deleted vertices\n    // distances > K may be pruned for nonnegative edges\n    for d in D:\n      answer += cnt.get(K-d, default=0)\n    for d in D:\n      cnt[d] += 1\n  // delete c, recursively decompose remaining components\n// answer uses 64-bit integer; collect DFS may need an explicit stack")

*参考*　#link("https://oi-wiki.org/graph/tree-divide/")[#text("OI Wiki：树分治")]。
  ]),

  "trick-tree-19": (title: [#text("重心的本质是平衡分割")], body: [
*问题概述*　#text("给定 ")$n$#text(" 点无向树，选择节点 ")$u$#text(" 并删除 ")$u$#text(" 及其 关联边，令 M(u) 为剩余最大连通块的节点数，空图取 0。求使 M(u) 最小的节点，或任意满足 ")$M(u)≤n/2$#text(" 的重心，用作平衡分治中心。")

*必要思路*　#text("每个候选 ")$u$#text(" 检查 max(n-sz[u],各儿子 sz)，取最小者；重心删后每块")$≤n/2$#text("。节点等权且边长为正时，重心还最小化到所有节点的距离和；有非负节点权时改用子树权重判断加权中位点。负边长不能沿用这一距离结论。")

*参考*　#link("https://oi-wiki.org/graph/tree-centroid/")[#text("OI Wiki：树的重心")]。
  ]),

  "trick-tree-20": (title: [#text("删一个点：答案是各分支的交叉贡献")], body: [
*问题概述*　#text("给定 ")$n$#text(" 点无向树，对每个节点 ")$u$#text("，求在删除 ")$u$#text(" 后仍保留的不同节点无序对 {a,b} 中，")$a$#text("、")$b$#text(" 不再连通的数量。另一个变形统计所有经过 ")$u$#text(" 的不同端点路径，此时端点允许为 ")$u$#text("；两个目标的计数域不同。")

*必要思路*　#text("剩余分支大小为 ")$s_i$#text("，先算 ")$sum _(i<j)s_i s_j=((n-1)^2- sum  s_i^2)/2$#text("；若路径允许端点为 ")$u$#text("，再加 ")$n-1$#text("。可逐分支用累计数乘当前大小避免平方溢出。这是唯一树路径经过 ")$u$#text(" 的自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。
  ]),

  "trick-tree-21": (title: [#text("换根后的子树只分三种情况")], body: [
*问题概述*　#text("给定树及节点权值，先以固定根 ")$r_0$#text(" 建立数据结构。每次询问指定新根 ")$r$#text(" 和节点 ")$u$#text("，求在根 ")$r$#text(" 的意义下 ")$u$#text(" 子树中的节点权值和；询问不改变边，只改变父子关系，可以另外支持节点权值修改。")

*必要思路*　#text("")$u=r$#text(" 则是全树；")$u$#text(" 不是原根下 ")$r$#text(" 的祖先，则仍是原子树；否则找到 ")$u$#text(" 朝 ")$r$#text(" 方向的儿子 ")$c$#text("，新子树为全树减原子树 ")$c$#text("。用祖先判断和倍增找 ")$c$#text("，最终是一段或两段序列区间。")

*参考*　#link("https://oi-wiki.org/graph/hld/")[#text("OI Wiki：树链剖分")]。
  ]),

  "trick-tree-22": (title: [#text("路径顺序敏感：左右两端分别收集")], body: [
*问题概述*　#text("给定树，每点存一个字符串或矩阵，op 为字符串拼接或矩阵乘法等结合但不交换的运算。对有方向的询问 (u,v)，求唯一简单路径按 ")$u$#text(" 到 ")$v$#text(" 的节点顺序做 op 的结果，端点及 LCA 各出现一次。")

*必要思路*　#text("从 ")$u$#text("、")$v$#text(" 两侧分别收集链段，维护每段正向和反向聚合；拼接时 ")$u$#text(" 侧向上、")$v$#text(" 侧向下，最后接 LCA 附近段。结合律足够做区间结构，但非交换运算不能随意交换链段。")

*参考*　#link("https://oi-wiki.org/graph/hld/")[#text("OI Wiki：树链剖分")]。
  ]),

  "trick-tree-23": (title: [#text("点集 LCA 只看 DFS 序两端")], body: [
*问题概述*　#text("给定以 ")$r$#text(" 为固定根、已支持两点 LCA 的树，以及非空节点集合 ")$S$#text("。求全部 ")$S$#text(" 的共同最低祖先，即同时为所有节点祖先且深度最大的节点；希望集合摘要只保留 DFS 首次进入序中最早和最晚的两个节点。")

*必要思路*　#text("设 ")$a$#text(" 为 ")$S$#text(" 中 tin 最小的节点，")$b$#text(" 为 tin 最大的节点，则 ")$op("LCA")(S)=op("LCA")(a,b)$#text("。祖先子树在首次进入 DFS 序中是连续区间：同时含两端，就包含所有集合节点。集合摘要只需维护这两个端点；不能改用节点编号的最小最大值。")

*依据*　自行推导/归纳，理由已写在思路中。
  ]),

  "trick-tree-24": (title: [#text("树同构：儿子类型排序后编码")], body: [
*问题概述*　#text("给定两棵无向、无节点标签、无边权的树，判断是否存在保持邻接关系的节点双射。节点编号与邻接表儿子顺序不构成标签；若有指定根，双射还须对应两棵树的根。本条要求精确判断而非依赖可能碰撞的单个随机哈希。")

*必要思路*　#text("有根树把儿子类型 ID 排序，将整个列表映射成新 ID；精确字典可避免随机哈希碰撞。无根树先找中心（不断剥叶，最后一个或两个点），比较其根化形式；中心与重心不是同一概念。")

*参考*　#link("https://oi-wiki.org/graph/tree-hash/")[#text("OI Wiki：树哈希")]。
  ]),

  "trick-tree-25": (title: [#text("基环树：先剥树枝，再处理环")], body: [
*问题概述*　#text("给定简单无向连通图，节点数与边数均为 ")$n$#text("，因此恰有一个环。每点有权值，求不含相邻两点的节点集合的最大总权值，允许空集；要求同时处理环上节点及挂在环上的树，不能随意断环边改变约束。")

*必要思路*　#text("按度数 1 剥叶找环，把各挂树汇总到环点。若做点独立集等 DP，可固定首环点选/不选再跑链式 DP，并检查最后与第一点的兼容；不能随便断边忽略环约束。任意多环图已不是该模型。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。
  ]),

  "trick-tree-26": (title: [#text("树计数用度数出现次数")], body: [
*问题概述*　#text("给定 ")$n≥2$#text(" 个有编号节点和正整数度数 ")$d_1…d_n$#text("，求满足每点度数恰为 ")$d_i$#text(" 的简单无向树数量；若 ")$sum  d_i≠2(n-1)$#text(" 则无解。无度数限制时求全部有标号树数；")$n=1$#text(" 必须作为单节点、度数 0 的特例处理。")

*必要思路*　#text("Prüfer 序列长度 ")$n-2$#text("，点 ")$i$#text(" 出现 ")$d_i-1$#text(" 次。普通树总数 ")$n^(n-2)$#text("；给定正整数度数且总和 ")$2(n-1)$#text("，树数 ")$(n-2)!/ product (d_i-1)!$#text("。")$n=1$#text("、2 独立处理，模数除法需合法逆元。")

*参考*　#link("https://cp-algorithms.com/graph/pruefer_code.html")[#text("CP-Algorithms：Prüfer 编码")]。
  ]),
)

#let tree-topic(id, level: 4, outlined: false) = render-topic(tree-topics, id, level: level, outlined: outlined)
