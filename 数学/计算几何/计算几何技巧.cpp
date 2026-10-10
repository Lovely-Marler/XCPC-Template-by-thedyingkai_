#pragma once

#include "凸包与旋转卡壳.cpp"

// start: integer-polar
using IP = Point<i64>;

// 先提升再相减；仍须保证最终行列式装入 i128。
i128 orient128(const IP& a, const IP& b, const IP& c) {
    i128 x1 = (i128) b.x - a.x, y1 = (i128) b.y - a.y;
    i128 x2 = (i128) c.x - a.x, y2 = (i128) c.y - a.y;
    return x1 * y2 - y1 * x2;
}
bool zeroVector(const IP& p) { return p.x == 0 && p.y == 0; }
int polarHalf(const IP& p) { return p.y < 0 || (p.y == 0 && p.x < 0); }
struct PolarLess {
    bool operator()(const IP& a, const IP& b) const {
        int x = polarHalf(a), y = polarHalf(b);
        if(x != y) return x < y;
        return cross(a, b) > 0;
    }
};
// 只接收非零向量；用半平面区分同向和反向。
bool sameRay(const IP& a, const IP& b) {
    return !zeroVector(a) && !zeroVector(b) && polarHalf(a) == polarHalf(b) && cross(a, b) == 0;
}
// end: integer-polar

// start: angle
constexpr d128 GEOM_PI = numbers::pi_v<d128>;
d128 normAngle(d128 a, d128 period = 2 * GEOM_PI) {
    assert(isfinite(a) && isfinite(period) && period > 0);
    a = fmodl(a, period);
    if(a < 0) a += period;
    if(a >= period) a = 0;
    return a == 0 ? 0.0L : a;
}
d128 signedAngle(const IP& a, const IP& b) {
    assert(!zeroVector(a) && !zeroVector(b));
    return atan2l((d128) cross(a, b), (d128) dot(a, b));
}
// end: angle

// start: half-plane
// closed=false: 最大开半圆；closed=true: 最大闭半圆。
// 零向量不参与方向扫描，闭半平面中原点的数量由调用者另加。
int maxHalfPlane(vector<IP> a, bool closed = false) {
    a.erase(remove_if(a.begin(), a.end(), zeroVector), a.end());
    sort(a.begin(), a.end(), PolarLess());
    vector<IP> p;
    vector<int> w;
    for(const auto& v : a) {
        if(!p.empty() && sameRay(p.back(), v))
            w.back()++;
        else
            p.push_back(v), w.push_back(1);
    }
    int n = p.size();
    if(n == 0) return 0;
    vector<i64> pref(2 * n + 1);
    for(int i = 0; i < 2 * n; i++) pref[i + 1] = pref[i] + w[i % n];
    int ans = 0, j = 0;
    for(int i = 0; i < n; i++) {
        j = max(j, i + 1);
        while(j < i + n) {
            i128 c = cross(p[i], p[j % n]);
            if(c > 0 || (closed && c == 0 && dot(p[i], p[j % n]) < 0))
                j++;
            else
                break;
        }
        ans = max(ans, int(pref[j] - pref[i]));
    }
    return ans;
}
// end: half-plane

// start: coverage-width
// 返回 {存在一个朝向覆盖 k 点, 每个朝向都覆盖 k 点} 的最小闭角宽。
// 非零向量，可同向、可重复；角宽是弧度。1 <= k <= a.size()。
pair<d128, d128> coverageWidth(const vector<IP>& p, int k) {
    int n = p.size();
    assert(1 <= k && k <= n);
    vector<d128> a(2 * n);
    for(int i = 0; i < n; i++) {
        assert(!zeroVector(p[i]));
        a[i] = normAngle(atan2l((d128) p[i].y, (d128) p[i].x));
    }
    sort(a.begin(), a.begin() + n);
    for(int i = 0; i < n; i++) a[i + n] = a[i] + 2 * GEOM_PI;
    d128 some = 2 * GEOM_PI, every = 0;
    for(int i = 0; i < n; i++) {
        some = min(some, a[i + k - 1] - a[i]);
        every = max(every, a[i + k] - a[i]);
    }
    return {some, every};
}
// end: coverage-width

// start: origin-triangles
// 统计严格包含原点的三角形。
// 前提：所有向量非零，任意两向量不共线（不允许同向或反向）。
i128 countOriginTriangles(vector<IP> a) {
    for(const auto& p : a) assert(!zeroVector(p));
    sort(a.begin(), a.end(), PolarLess());
    int n = a.size();
    for(int i = 1; i < n; i++) assert(!sameRay(a[i - 1], a[i]));
    i128 ans = (i128) n * (n - 1) * (n - 2) / 6;
    int j = 0;
    for(int i = 0; i < n; i++) {
        j = max(j, i + 1);
        while(j < i + n && cross(a[i], a[j % n]) > 0) j++;
        if(j < i + n) assert(cross(a[i], a[j % n]) != 0);
        i64 k = j - i - 1;
        ans -= (i128) k * (k - 1) / 2;
    }
    return ans;
}
// end: origin-triangles

// start: convex-query
// 逆时针严格凸包，不重复首点；允许空集、单点、线段。
// 返回 -1 外部，0 边界，1 严格内部。n>=3 时 O(log n)。
int convexLocation(const vector<IP>& p, const IP& q) {
    int n = p.size();
    if(n == 0) return -1;
    if(n == 1) return p[0] == q ? 0 : -1;
    if(n == 2) return pointOnSegment(q, Line<i64>(p[0], p[1])) ? 0 : -1;
    i128 a = orient128(p[0], p[1], q), b = orient128(p[0], p[n - 1], q);
    if(a < 0 || b > 0) return -1;
    if(a == 0) return pointOnSegment(q, Line<i64>(p[0], p[1])) ? 0 : -1;
    if(b == 0) return pointOnSegment(q, Line<i64>(p[0], p[n - 1])) ? 0 : -1;
    int l = 1, r = n - 1;
    while(r - l > 1) {
        int mid = (l + r) / 2;
        if(orient128(p[0], p[mid], q) >= 0)
            l = mid;
        else
            r = mid;
    }
    i128 c = orient128(p[l], p[r], q);
    return c < 0 ? -1 : (c == 0 ? 0 : 1);
}
// end: convex-query

// start: polygon-area
// 返回两倍有向面积；逆时针为正，顺时针为负。
i128 signedArea2(const vector<IP>& p) {
    i128 ans = 0;
    for(int i = 0; i < (int) p.size(); i++) ans += cross(p[i], p[(i + 1) % p.size()]);
    return ans;
}
// end: polygon-area

// start: minkowski
// 输入为 convexHull(..., false) 的输出。O(n+m)，返回同样的凸包格式。
// 坐标加减仍在 i64 内完成，须保证坐标、边向量和结果坐标装入 i64。
vector<IP> minkowskiSum(vector<IP> a, vector<IP> b) {
    if(a.empty() || b.empty()) return {};
    auto startAtLowest = [](vector<IP>& p) {
        auto it = min_element(p.begin(), p.end(), [](const IP& u, const IP& v) {
            return u.y != v.y ? u.y < v.y : u.x < v.x;
        });
        rotate(p.begin(), it, p.end());
    };
    startAtLowest(a);
    startAtLowest(b);
    if(a.size() == 1) {
        for(auto& p : b) p += a[0];
        return b;
    }
    if(b.size() == 1) {
        for(auto& p : a) p += b[0];
        return a;
    }
    int n = a.size(), m = b.size();
    vector<IP> ea(n), eb(m);
    for(int i = 0; i < n; i++) ea[i] = a[(i + 1) % n] - a[i];
    for(int j = 0; j < m; j++) eb[j] = b[(j + 1) % m] - b[j];
    vector<IP> ans{a[0] + b[0]};
    int i = 0, j = 0;
    while(i < n || j < m) {
        IP step;
        if(i == n)
            step = eb[j++];
        else if(j == m)
            step = ea[i++];
        else if(sameRay(ea[i], eb[j]))
            step = ea[i++] + eb[j++];
        else if(PolarLess()(ea[i], eb[j]))
            step = ea[i++];
        else
            step = eb[j++];
        ans.push_back(ans.back() + step);
    }
    ans.pop_back(); // 最后一步回到首点。
    return ans;
}
vector<IP> minkowskiDifference(const vector<IP>& a, vector<IP> b) {
    for(auto& p : b) p = -p; // 旋转 180 度，保持逆时针。
    return minkowskiSum(a, b);
}
// end: minkowski

// start: exact-intersection
i128 gcdGeom128(i128 a, i128 b) {
    if(a < 0) a = -a;
    if(b < 0) b = -b;
    while(b != 0) {
        i128 r = a % b;
        a = b;
        b = r;
    }
    return a;
}
struct GeomFraction {
    i128 num, den; // den>0，最简分数。
    GeomFraction(i128 n, i128 d) : num(n), den(d) {
        assert(d != 0);
        if(den < 0) num = -num, den = -den;
        i128 g = gcdGeom128(num, den);
        num /= g, den /= g;
    }
};
// 无限直线交点。平行或重合返回 nullopt；输入直线不可退化。
// 分数分子含三次乘积，不能仅按叉积的二次量估计范围。
optional<pair<GeomFraction, GeomFraction>>
exactLineIntersection(const IP& a, const IP& b, const IP& c, const IP& d) {
    assert(a != b && c != d);
    i128 ux = (i128) b.x - a.x, uy = (i128) b.y - a.y;
    i128 vx = (i128) d.x - c.x, vy = (i128) d.y - c.y;
    i128 wx = (i128) c.x - a.x, wy = (i128) c.y - a.y;
    i128 den = ux * vy - uy * vx;
    if(den == 0) return nullopt;
    i128 t = wx * vy - wy * vx;
    return pair{GeomFraction((i128) a.x * den + ux * t, den),
                GeomFraction((i128) a.y * den + uy * t, den)};
}
// end: exact-intersection

// start: midpoint
// 0<=x<=a；返回约分后 x/a 的二进分母指数，不可达为 -1。
int dyadicDepth(i64 a, i64 x) {
    assert(0 <= x && x <= a);
    if(a == 0) return 0;
    u64 den = a / gcd(a, x);
    if((den & (den - 1)) != 0) return -1;
    return countr_zero(den);
}
// 返回每一步所选的两点；nullopt 为不可达，空数组表示目标已是初始顶点。
optional<vector<pair<IP, IP>>> midpointConstruction(i64 a, i64 b, IP target) {
    int kx = dyadicDepth(a, target.x), ky = dyadicDepth(b, target.y);
    if(kx < 0 || ky < 0) return nullopt;
    int k = max(kx, ky);
    vector<pair<IP, IP>> ans;
    IP cur = target;
    for(int i = 0; i < k; i++) {
        IP corner((i128) 2 * cur.x >= a ? a : 0, (i128) 2 * cur.y >= b ? b : 0);
        IP parent((i64) ((i128) 2 * cur.x - corner.x), (i64) ((i128) 2 * cur.y - corner.y));
        ans.push_back({parent, corner});
        cur = parent;
    }
    assert((cur.x == 0 || cur.x == a) && (cur.y == 0 || cur.y == b));
    reverse(ans.begin(), ans.end());
    return ans;
}
// end: midpoint
