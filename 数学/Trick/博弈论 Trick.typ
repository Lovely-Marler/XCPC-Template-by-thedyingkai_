// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("除另述外，默认双方行动规则相同、轮流行动、无随机、有限结束、无法行动者输。反常终止、循环或共享资源需要单独建模。")

#text("训练优先级：A 优先掌握，B 常用进阶，C 拓展储备；不是题目官方难度。每条参考链接用于追溯知识，应用情景和边界由本文重新整理。")

=== #text("GAME-01 [A] 先手必胜不是“可走步数为奇数”") <trick-game-01>

*问题概述*　#text("可选操作有多种且长度不固定，判断双方最优行动下谁获胜。")

*必要思路*　#text("无操作为必败 P；存在一步到 P 则是必胜 N；所有后继均为 N 才是 P。先写小规模搜索，再观察规律。只有每局操作数的奇偶已由局面唯一决定时，才能直接比奇偶。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。

=== #text("GAME-02 [A] 正常 Nim：寻找异或为零的局面") <trick-game-02>

*问题概述*　#text("若干石子堆，每次任取一堆的正数石子，最后不能取者输。")

*必要思路*　#text("异或和 X=0 必败，否则必胜。构造时找 a[i] 满足 (a[i] xor X)<a[i]，把这堆降至 a[i] xor X。每步只改一堆、允许任意正数、不能增堆，缺任一条件都需重新分析。")

*参考*　#link("https://cp-algorithms.com/game_theory/sprague-grundy-nim.html")[#text("CP-Algorithms：SG 与 Nim")]。

=== #text("GAME-03 [A] 反 Nim：全是 1 的末局单独处理") <trick-game-03>

*问题概述*　#text("规则同 Nim，但取走最后一个石子的人输。")

*必要思路*　#text("若所有非空堆都为 1，非空堆数为偶数时先手胜；若至少一堆大于 1，胜负按普通异或和非零判断。走法进入“全为 1”区域时需留下奇数个 1。空局面的终止规则单独明确，不能把所有普通 SG=0 的结论直接反转。")

*参考*　#link("https://cp-algorithms.com/game_theory/sprague-grundy-nim.html")[#text("CP-Algorithms：SG 与 Nim")]。

=== #text("GAME-04 [A] 巴什：按一回合配对") <trick-game-04>

*问题概述*　#text("一堆 n 个，每次可取 1..m 个，无法操作者输。")

*必要思路*　#text("P 局面是 n 为 m+1 的倍数。先手先调到倍数，此后对方取 x，就取 m+1-x。取数集合不连续时不能照套，需做胜负或 SG 递推。")

*参考*　#link("https://www.luogu.com.cn/article/bk8r8qm6")[#text("洛谷 zhaojiaen：博弈论")]。

=== #text("GAME-05 [A] 减法游戏：有限窗口证明最终周期") <trick-game-05>

*问题概述*　#text("每次只能取集合 S 中的数量，n 很大，暴力算前若干项后看到周期。")

*必要思路*　#text("设 max(S)=M，SG 或胜负只依赖前 M 项。完整长度 M 的状态窗口若重复，未来将重复，可据此证明最终周期；必须比较完整窗口而非几个点。SG≤可选后继数，但窗口空间可能很大，不能保证短周期。")

*参考*　#link("https://cp-algorithms.com/game_theory/sprague-grundy-nim.html")[#text("CP-Algorithms：SG 与 Nim")]。

=== #text("GAME-06 [B] SG 合并：异或的是游戏，不是任意堆数") <trick-game-06>

*问题概述*　#text("多个互相独立的小游戏，每回合只选择其中一个行动。")

*必要思路*　#text("先求单游戏 sg(x)=mex{sg(y)}，再异或各 sg。双方必须使用同一行动规则，游戏有限且正常终止；共享预算、一步同时改多个游戏或反常终止时，普通异或合并未必成立。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。

=== #text("GAME-07 [B] 分裂后继：先异或，再 mex") <trick-game-07>

*问题概述*　#text("一段可以切成两段，此后两段分别进行游戏，求该长度的 SG。")

*必要思路*　#text("一次切分得到两个独立子游戏，后继 SG 是 sg[left] xor sg[right]；把所有合法切法的后继值加入集合，最后取 mex。不能把两段 SG 相加，也不能分别 mex 后再合并。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。

=== #text("GAME-08 [B] mex 的范围由出度限制") <trick-game-08>

*问题概述*　#text("某游戏有海量数值状态，但每个状态最多 d 种合法操作，SG 值似乎也需巨大数组。")

*必要思路*　#text("一个含至多 d 个数的集合，其 mex≤d。单次只标记 0..d 即可，超过 d 的后继 SG 不影响 mex；用时间戳避免重复清空。SG 小不等于状态数少，两者要分别估算。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("GAME-09 [A] 对称应手：镜像操作的合法性") <trick-game-09>

*问题概述*　#text("棋盘或两条链完全对称，每次选择一处放置或移除，能否设计后手策略？")

*必要思路*　#text("建立无固定点的配对；若先手每次破坏一对中的一侧，而镜像侧仍可合法应手，后手恢复对称。证明操作不会同时影响双方配对位置，也不会让镜像失效。有中心固定点时常先占中心，再实施配对。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("GAME-10 [B] 阶梯 Nim：相邻下移才异或奇数层") <trick-game-10>

*问题概述*　#text("石子在编号 1..n 的阶梯，第 i 层每次可把任意正数颗移到 i-1，0 层不参与游戏。")

*必要思路*　#text("只异或奇数层的数量。操作偶数层时，可把刚进入奇数层的石子继续下移来还原有效局面；操作奇数层相当于减少有效 Nim 堆。若允许任意跳多层，规则已改变，不可沿用此结论。")

*参考*　#link("https://oi-wiki.org/math/game-theory/impartial-game/")[#text("OI Wiki：公平组合游戏")]。

=== #text("GAME-11 [B] Silver Dollar：把棋子变成间隙") <trick-game-11>

*问题概述*　#text("数轴上互不重叠的棋子可向左移动，不能跨其他棋子，无法行动者输。")

*必要思路*　#text("设排序后位置为 x[1..n]，g[1]=x[1]（最左可到 0），g[i]=x[i]-x[i-1]-1。从最右间隙开始隔一个取一个，即 g[n],g[n-2],… 做 Nim 异或。一次移动在相邻间隙间转移空位，可按阶梯博弈理解。棋子移除或允许跨越会改变模型。")

*参考*　#link("https://www.codechef.com/wiki/tutorial-coin-game")[#text("CodeChef 官方题解：A Coin Game（Silver Dollar）")]。

=== #text("GAME-12 [B] 威佐夫：两堆可同量同时减少") <trick-game-12>

*问题概述*　#text("每步可从一堆任取，或从两堆各取相同正数，无法行动者输。")

*必要思路*　#text("令 a≤b，k=b-a；P 局面恰为 a=floor(kφ)、b=a+k，φ=(1+√5)/2。不是普通 Nim。大整数判定要考虑黄金比例计算精度，用整数比较或高精度确认临界值。")

*参考*　#link("https://www.luogu.com.cn/article/bk8r8qm6")[#text("洛谷 zhaojiaen：博弈论")]。

=== #text("GAME-13 [C] Fibonacci Nim：行动上限也是状态") <trick-game-13>

*问题概述*　#text("一堆石子，首步不能取完，其后每次最多取对手上次所取的两倍。")

*必要思路*　#text("该标准规则下，初始 P 局面恰为 Fibonacci 数。一般中途状态还需记当前取数上限；Zeckendorf 分解中最小 Fibonacci 项可用于策略。首步可取完或上限规则改变后，不能套初始结论。")

*参考*　#link("https://oi-wiki.org/math/game-theory/impartial-game/")[#text("OI Wiki：公平组合游戏")]。

=== #text("GAME-14 [B] 有环博弈：反图传播胜负与平局") <trick-game-14>

*问题概述*　#text("棋子沿有向边移动，图有环；终点无出边者输，无限移动算平局。")

*必要思路*　#text("从终点 P 开始在反图上传播：有边到 P 的前驱变 N；全部后继已是 N 的前驱变 P。维护剩余未判后继数。最后未判状态为可保证不败的平局区域；不是“某点在环里就平局”。")

*实现提示*　#text("默认无合法行动者输，永远行动视为平局。rev 是反向边，remain 初值等于出度；按边计数，多重边也按同一口径处理。O(V+E)。")

*伪代码*（需结合题目接口实现）

#trick-code("state[all] = UNKNOWN; remain[u] = outdegree(u)\nqueue all u with remain[u] == 0; state[u] = LOSE\nwhile queue not empty:\n  u = queue.pop()\n  for p in rev[u]:\n    if state[p] != UNKNOWN: continue\n    if state[u] == LOSE:\n      state[p] = WIN; queue.push(p)\n    else:\n      remain[p] -= 1\n      if remain[p] == 0:\n        state[p] = LOSE; queue.push(p)\nUNKNOWN states are DRAW")

*参考*　#link("https://cp-algorithms.com/game_theory/games_on_graphs.html")[#text("CP-Algorithms：有环图上的博弈")]。

=== #text("GAME-15 [A] 玩家规则不同：把行动者加入状态") <trick-game-15>

*问题概述*　#text("两人能走的边、可取数量或胜利条件不同，同一局面轮到不同人结果不同。")

*必要思路*　#text("状态必须是 (局面,轮到谁)，分别列各自行动；有限图可倒推，允许循环则需按胜负平局处理。不要给原局面单独算普通 SG，因为相同状态不再对应同一组合法操作。")

*参考*　#link("https://cp-algorithms.com/game_theory/games_on_graphs.html")[#text("CP-Algorithms：有环图上的博弈")]。

=== #text("GAME-16 [A] 得分博弈：用 minimax 而非只有胜负") <trick-game-16>

*问题概述*　#text("双方轮流选择对象，目标是最大化自己的分数差，并非“无操作者输”。")

*必要思路*　#text("零和且总收益定义清楚时，记当前行动者的最优净收益，转移是 max(本步收益-下一状态值)。若双方目标不构成零和，需明确效用与平局偏好；单个 SG 值不能表达分数。")

*参考*　#link("https://www.luogu.com.cn/article/bk8r8qm6")[#text("洛谷 zhaojiaen：博弈论")]。

=== #text("GAME-17 [B] 树上删边游戏：子树值加一后异或") <trick-game-17>

*问题概述*　#text("有根树，每次剪掉一条边及其远离根的一侧，无法剪者输。")

*必要思路*　#text("叶子 sg=0，节点 sg(u)=xor_{v为儿子}(sg(v)+1)。儿子分支互相独立，而连接父节点的那条边带来 +1 的递推。仅是这种剪边规则；删节点、改根或每步剪多条边时另做证明。")

*参考*　#link("https://www.luogu.com/article/7hk1nffs")[#text("洛谷原创：树的删边游戏与无向图的删边游戏")]。

=== #text("GAME-18 [A] 奇偶策略：找到严格每步翻转的势") <trick-game-18>

*问题概述*　#text("游戏虽然形态复杂，但每次恰好消耗一个资源，终局资源量固定。")

*必要思路*　#text("若存在整数势 F，每步恰好减少 1，到终局总减少量固定，就能由 F 初始值与终值之差的奇偶判胜负。若每步可减少不同奇偶数或终值依赖选择，则总步数未确定，奇偶推理失效。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("GAME-19 [B] “多一步无害”：需要证明策略偷换") <trick-game-19>

*问题概述*　#text("怀疑先手不会输，能否让先手随便先走一步，再扮演后手的策略？")

*必要思路*　#text("这只能在额外行动不会妨碍原策略、且能合法模拟原行动时使用。给出明确模拟规则及冲突修复办法；不能仅说“先手有优势”。常用于单调放置类游戏，但删点、强制动作和反常终止可能破坏它。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("GAME-20 [A] 暴力找规律必须同时证两条") <trick-game-20>

*问题概述*　#text("小规模 SG 表显示败态似乎满足某个同余或数值关系，想直接推广到 10^18。")

*必要思路*　#text("验证候选 P 集内部不存在一步转移，同时所有非 P 状态都能一步进入 P，才完成败态刻画。打表优先找最小反例；保留边界状态与规则原文。只验证第一条会把过小的 P 集误判成正确规律。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。

