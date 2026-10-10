// GNU++20: g++ -std=gnu++20 -O2 -Wall -Wextra scripts/check-geometry.cpp -o check-geometry
// 固定种子的独立枚举对拍；保留断言，勿加 -DNDEBUG。
#include "../数学/计算几何/计算几何技巧.cpp"

namespace {
mt19937_64 rng(20261010);
i64 checks = 0;

void require(bool ok, const string& message) {
    checks++;
    if(!ok) throw runtime_error(message);
}
int rnd(int l, int r) { return uniform_int_distribution<int>(l, r)(rng); }
bool near(d128 a, d128 b) { return fabsl(a - b) <= 1e-12L; }
IP randomPoint(int c = 12) { return IP(rnd(-c, c), rnd(-c, c)); }
vector<IP> randomHull(int n) {
    vector<IP> p(n);
    for(auto& q : p) q = randomPoint();
    return convexHull(p, false);
}
vector<IP> canonical(vector<IP> p) {
    if(p.empty()) return p;
    if(signedArea2(p) < 0) reverse(p.begin(), p.end());
    auto it = min_element(p.begin(), p.end(), [](const IP& a, const IP& b) { return pair(a.x, a.y) < pair(b.x, b.y); });
    rotate(p.begin(), it, p.end());
    return p;
}
int bruteLocation(const vector<IP>& h, IP p) {
    int n = h.size();
    if(n == 0) return -1;
    if(n == 1) return h[0] == p ? 0 : -1;
    if(n == 2) return pointOnSegment(p, Line<i64>(h[0], h[1])) ? 0 : -1;
    bool boundary = false;
    for(int i = 0; i < n; i++) {
        i128 c = orient128(h[i], h[(i + 1) % n], p);
        if(c < 0) return -1;
        boundary |= c == 0;
    }
    return boundary ? 0 : 1;
}

void testPolarAndAngles() {
    vector<IP> p;
    for(int x = -2; x <= 2; x++)
        for(int y = -2; y <= 2; y++)
            if(x || y) p.emplace_back(x, y);
    PolarLess less;
    auto equivalent = [&](IP a, IP b) { return !less(a, b) && !less(b, a); };
    for(IP a : p) {
        require(!less(a, a), "polar irreflexivity");
        for(IP b : p) {
            require(!(less(a, b) && less(b, a)), "polar asymmetry");
            require(equivalent(a, b) == sameRay(a, b), "polar equivalence");
            for(IP c : p) {
                require(!(less(a, b) && less(b, c)) || less(a, c), "polar transitivity");
                require(!(equivalent(a, b) && equivalent(b, c)) || equivalent(a, c), "polar equivalence transitivity");
            }
            d128 a1 = normAngle(atan2l((d128) a.y, (d128) a.x));
            d128 a2 = normAngle(atan2l((d128) b.y, (d128) b.x));
            require(less(a, b) == (a1 < a2), "polar vs small exact directions");
            d128 angle = signedAngle(a, b);
            require(near(normAngle(angle), normAngle(a2 - a1)), "signed relative angle");
            IP ta(a.x + a.y, a.x - a.y), tb(b.x + b.y, b.x - b.y);
            require(dot(ta, tb) == 2 * dot(a, b), "metric transform dot");
            require(cross(ta, tb) == -2 * cross(a, b), "metric transform orientation");
        }
    }
    IP a(1000000000, 999999999), b(999999999, 999999998);
    require(cross(a, b) == -1 && less(b, a), "large almost parallel directions");
    require(orient128(IP(-6000000000000000000LL, 0), IP(6000000000000000000LL, 0), IP(0, 1)) ==
                (i128) 12000000000000000000ULL,
            "subtract only after widening");
    require(normAngle(-0.0L) == 0 && !signbit(normAngle(-0.0L)), "negative zero");
    require(near(normAngle(-GEOM_PI / 2), 3 * GEOM_PI / 2), "negative angle");
    require(near(normAngle(2 * GEOM_PI), 0), "period endpoint");
    require(near(normAngle(3 * GEOM_PI / 2, GEOM_PI), GEOM_PI / 2), "unoriented line period");
    cout << "polar order, angles and metric transform: OK\n";
}

// 枚举所有临界法向和相邻临界法向之间的方向，与角度窗口使用不同的判定。
int bruteHalfPlane(const vector<IP>& p, bool closed) {
    vector<IP> normals;
    for(IP q : p) {
        if(zeroVector(q)) continue;
        i64 g = gcd(abs(q.x), abs(q.y));
        IP n(-q.y / g, q.x / g);
        normals.push_back(n);
        normals.push_back(-n);
    }
    if(normals.empty()) return 0;
    sort(normals.begin(), normals.end(), PolarLess());
    normals.erase(unique(normals.begin(), normals.end()), normals.end());
    vector<IP> candidates = normals;
    for(int i = 0; i < (int) normals.size(); i++) {
        IP middle = normals[i] + normals[(i + 1) % normals.size()];
        if(zeroVector(middle)) middle = rotate(normals[i]);
        candidates.push_back(middle);
    }
    int best = 0;
    for(IP normal : candidates) {
        int count = 0;
        for(IP q : p) {
            if(zeroVector(q)) continue;
            i128 d = dot(normal, q);
            count += closed ? d >= 0 : d > 0;
        }
        best = max(best, count);
    }
    return best;
}
void testHalfPlane() {
    vector<vector<IP>> cases{{},
                             {{0, 0}},
                             {{1, 0}, {2, 0}, {3, 0}},
                             {{1, 0}, {-1, 0}},
                             {{1, 0}, {0, 1}, {-1, 0}, {0, -1}},
                             {{0, 0}, {1, 1}, {2, 2}, {-1, -1}, {-2, -2}}};
    for(int t = 0; t < 6000; t++) {
        vector<IP> p(rnd(0, 16));
        for(auto& q : p) q = randomPoint(4);
        cases.push_back(p);
    }
    for(const auto& p : cases)
        for(bool closed : {false, true})
            require(maxHalfPlane(p, closed) == bruteHalfPlane(p, closed), "half-plane enumeration");
    require(maxHalfPlane({{1, 0}, {0, 1}, {-1, 0}, {0, -1}}) == 2, "open axes");
    require(maxHalfPlane({{1, 0}, {0, 1}, {-1, 0}, {0, -1}}, true) == 3, "closed axes");
    cout << "open/closed half-plane, including duplicate directions: OK\n";
}

void testCoverageWidth() {
    const vector<IP> directions{{1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}};
    for(int t = 0; t < 2500; t++) {
        int n = rnd(1, 20);
        vector<int> codes(n);
        vector<IP> p;
        for(auto& c : codes) {
            c = rnd(0, 7);
            p.push_back(directions[c] * i64(rnd(1, 5)));
        }
        for(int k = 1; k <= n; k++) {
            int some = -1, every = -1;
            // 十六个左端点包含每个方向和其右侧开邻域；角宽取 pi/4 的倍数。
            for(int width = 0; width <= 8; width++) {
                int low = n, high = 0;
                for(int left = 0; left < 16; left++) {
                    int count = 0;
                    for(int c : codes) count += (2 * c - left + 16) % 16 <= 2 * width;
                    low = min(low, count);
                    high = max(high, count);
                }
                if(some < 0 && high >= k) some = width;
                if(every < 0 && low >= k) every = width;
            }
            auto [a, b] = coverageWidth(p, k);
            require(near(a, some * GEOM_PI / 4), "exists orientation width");
            require(near(b, every * GEOM_PI / 4), "every orientation width");
        }
    }
    cout << "exists/every orientation widths on an exact circular lattice: OK\n";
}

void testTriangles() {
    for(int t = 0; t < 1500; t++) {
        int n = rnd(0, 13);
        vector<IP> p;
        while((int) p.size() < n) {
            IP q = randomPoint(12);
            if(zeroVector(q)) continue;
            bool ok = true;
            for(IP a : p) ok &= cross(a, q) != 0;
            if(ok) p.push_back(q);
        }
        i128 brute = 0;
        for(int i = 0; i < n; i++)
            for(int j = i + 1; j < n; j++)
                for(int k = j + 1; k < n; k++) {
                    i128 a = cross(p[i], p[j]), b = cross(p[j], p[k]), c = cross(p[k], p[i]);
                    brute += (a > 0 && b > 0 && c > 0) || (a < 0 && b < 0 && c < 0);
                }
        require(countOriginTriangles(p) == brute, "strict-origin triangle enumeration");
    }
    cout << "triangles strictly containing the origin: OK\n";
}

void testConvexLocation() {
    for(int t = 0; t < 2000; t++) {
        vector<IP> h = randomHull(rnd(0, 24));
        for(int i = 0; i < 100; i++) {
            IP p = randomPoint(20);
            require(convexLocation(h, p) == bruteLocation(h, p), "convex location vs every edge");
        }
        for(int i = 0; i < (int) h.size(); i++) {
            require(convexLocation(h, h[i]) == 0, "convex vertex boundary");
            IP sum = h[i] + h[(i + 1) % h.size()];
            if(sum.x % 2 == 0 && sum.y % 2 == 0) require(convexLocation(h, sum / i64(2)) == 0, "convex edge boundary");
        }
    }
    vector<IP> square{{0, 0}, {4, 0}, {4, 4}, {0, 4}};
    require(convexLocation(square, {2, 2}) == 1, "fan diagonal is interior");
    require(convexLocation(square, {8, 0}) == -1, "first fan ray beyond segment");
    require(convexLocation(square, {0, 8}) == -1, "last fan ray beyond segment");
    cout << "convex point location, fan diagonals and boundary extensions: OK\n";
}

void testMinkowski() {
    vector<vector<IP>> special{
        {}, {{3, -2}}, {{0, 0}, {3, 0}}, {{0, 0}, {0, 4}}, {{-2, -3}, {2, 3}}, {{0, 0}, {4, 0}, {4, 4}, {0, 4}}};
    auto test = [&](const vector<IP>& a, const vector<IP>& b) {
        vector<IP> sum, difference;
        for(IP p : a)
            for(IP q : b) {
                sum.push_back(p + q);
                difference.push_back(p - q);
            }
        require(canonical(minkowskiSum(a, b)) == canonical(convexHull(sum, false)), "Minkowski sum vs pair sums");
        require(canonical(minkowskiDifference(a, b)) == canonical(convexHull(difference, false)),
                "Minkowski difference vs pair differences");
    };
    for(const auto& a : special)
        for(const auto& b : special) test(a, b);
    for(int t = 0; t < 5000; t++) test(randomHull(rnd(0, 16)), randomHull(rnd(0, 16)));
    vector<IP> unit{{0, 0}, {1, 0}, {1, 1}, {0, 1}};
    require(signedArea2(unit) == 2 && signedArea2(minkowskiDifference(unit, unit)) == 8,
            "unit-square collision expectation");
    cout << "linear Minkowski sum/difference, including points and segments: OK\n";
}

void testExactIntersections() {
    for(int t = 0; t < 12000; t++) {
        IP a = randomPoint(), b = randomPoint(), c = randomPoint(), d = randomPoint();
        if(a == b || c == d) continue;
        // 用隐式方程 A*x+B*y=C 的 Cramer 法则作独立基线。
        i128 a1 = a.y - b.y, b1 = b.x - a.x, c1 = a1 * a.x + b1 * a.y;
        i128 a2 = c.y - d.y, b2 = d.x - c.x, c2 = a2 * c.x + b2 * c.y;
        i128 det = a1 * b2 - a2 * b1;
        auto actual = exactLineIntersection(a, b, c, d);
        require(actual.has_value() == (det != 0), "parallel or coincident intersection");
        if(!actual) continue;
        i128 nx = c1 * b2 - c2 * b1, ny = a1 * c2 - a2 * c1;
        auto [x, y] = *actual;
        require(x.den > 0 && y.den > 0, "fraction sign normalization");
        require(gcdGeom128(x.num, x.den) == 1 && gcdGeom128(y.num, y.den) == 1, "fraction reduction");
        require(x.num * det == nx * x.den && y.num * det == ny * y.den, "fraction intersection vs Cramer");
    }
    auto large = exactLineIntersection({-1000000000, -1000000000}, {1000000000, 1000000000}, {-1000000000, 1000000000},
                                       {1000000000, -1000000000});
    require(large && large->first.num == 0 && large->second.num == 0, "large exact intersection");
    auto half = exactLineIntersection({0, 0}, {1, 1}, {0, 1}, {1, 0});
    require(half && half->first.num == 1 && half->first.den == 2 && half->second.num == 1 && half->second.den == 2,
            "half-integer intersection");
    cout << "exact line intersections against implicit equations: OK\n";
}

// 真正枚举点集状态，求每个目标最早出现的步数，不使用分母结论。
vector<int> midpointBfs(int a, int b) {
    int n = (a + 1) * (b + 1);
    vector<IP> p;
    for(int x = 0; x <= a; x++)
        for(int y = 0; y <= b; y++) p.emplace_back(x, y);
    auto index = [&](int x, int y) { return x * (b + 1) + y; };
    unsigned initial = 0;
    for(int x : {0, a})
        for(int y : {0, b}) initial |= 1U << index(x, y);
    vector<int> distance(1U << n, -1), earliest(n, -1);
    queue<unsigned> queue;
    queue.push(initial);
    distance[initial] = 0;
    for(int i = 0; i < n; i++)
        if(initial >> i & 1) earliest[i] = 0;
    while(!queue.empty()) {
        unsigned mask = queue.front();
        queue.pop();
        for(int i = 0; i < n; i++) {
            if(!(mask >> i & 1)) continue;
            for(int j = i + 1; j < n; j++) {
                if(!(mask >> j & 1)) continue;
                IP s = p[i] + p[j];
                if(s.x % 2 || s.y % 2) continue;
                int k = index(s.x / 2, s.y / 2);
                if(mask >> k & 1) continue;
                if(earliest[k] < 0) earliest[k] = distance[mask] + 1;
                unsigned next = mask | (1U << k);
                if(distance[next] >= 0) continue;
                distance[next] = distance[mask] + 1;
                queue.push(next);
            }
        }
    }
    return earliest;
}
void validateConstruction(i64 a, i64 b, IP target, int expected) {
    auto operations = midpointConstruction(a, b, target);
    require(operations.has_value() == (expected >= 0), "midpoint reachability");
    if(!operations) return;
    require((int) operations->size() == expected, "midpoint minimal step count");
    vector<IP> existing{{0, 0}, {a, 0}, {0, b}, {a, b}};
    for(auto [u, v] : *operations) {
        require(find(existing.begin(), existing.end(), u) != existing.end(), "midpoint parent exists");
        require(find(existing.begin(), existing.end(), v) != existing.end(), "midpoint corner exists");
        i128 x = (i128) u.x + v.x, y = (i128) u.y + v.y;
        require(x % 2 == 0 && y % 2 == 0, "midpoint is an integer point");
        IP q((i64) (x / 2), (i64) (y / 2));
        require(0 <= q.x && q.x <= a && 0 <= q.y && q.y <= b, "midpoint stays in rectangle");
        existing.push_back(q);
    }
    require(find(existing.begin(), existing.end(), target) != existing.end(), "midpoint target produced");
}
void testMidpoints() {
    for(int a = 0; a <= 3; a++)
        for(int b = 0; b <= 3; b++) {
            auto earliest = midpointBfs(a, b);
            for(int x = 0; x <= a; x++)
                for(int y = 0; y <= b; y++) validateConstruction(a, b, {x, y}, earliest[x * (b + 1) + y]);
        }
    auto independentDepth = [](i64 a, i64 x) {
        if(a == 0) return 0;
        i128 residue = x;
        for(int k = 0; k <= 63; k++) {
            if(residue % a == 0) return k;
            residue = 2 * residue % a;
        }
        return -1;
    };
    for(int a = 0; a <= 24; a++)
        for(int b = 0; b <= 24; b++)
            for(int x = 0; x <= a; x++)
                for(int y = 0; y <= b; y++) {
                    int kx = independentDepth(a, x), ky = independentDepth(b, y);
                    validateConstruction(a, b, {x, y}, kx < 0 || ky < 0 ? -1 : max(kx, ky));
                }
    i64 big = 1LL << 62;
    validateConstruction(big, big, {big - 1, 1}, 62);
    validateConstruction(LLONG_MAX, 0, {LLONG_MAX, 0}, 0);
    validateConstruction(8, 6, {7, 3}, 3);
    cout << "midpoint reachability and optimal construction, including point-set BFS: OK\n";
}

i64 chooseSmall(int n, int k) {
    if(k < 0 || k > n) return 0;
    i64 answer = 1;
    for(int i = 1; i <= k; i++) answer = answer * (n - i + 1) / i;
    return answer;
}
void testAreaContribution() {
    constexpr i64 mod = 998244353;
    auto power = [&](i64 a, i64 b) {
        i64 r = 1;
        for(; b; b >>= 1, a = a * a % mod)
            if(b & 1) r = r * a % mod;
        return r;
    };
    for(int t = 0; t < 500; t++) {
        vector<IP> h;
        while(h.size() < 3) h = randomHull(rnd(3, 14));
        int n = h.size();
        vector<i128> enumerated(n + 1), f(n);
        for(unsigned mask = 0; mask < (1U << n); mask++) {
            int k = popcount(mask);
            if(k < 3) continue;
            vector<IP> polygon;
            for(int i = 0; i < n; i++)
                if(mask >> i & 1) polygon.push_back(h[i]);
            enumerated[k] += signedArea2(polygon);
        }
        for(int d = 1; d < n; d++)
            for(int i = 0; i < n; i++) f[d] += cross(h[i], h[(i + d) % n]);
        vector<i64> fact(n + 1, 1), invfact(n + 1), u(n - 1), v(n - 1), w(2 * n - 3);
        for(int i = 1; i <= n; i++) fact[i] = fact[i - 1] * i % mod;
        for(int i = 0; i <= n; i++) invfact[i] = power(fact[i], mod - 2);
        for(int t1 = 0; t1 <= n - 2; t1++) {
            i64 fd = (i64) (f[t1 + 1] % mod);
            if(fd < 0) fd += mod;
            u[t1] = fd * fact[n - 2 - t1] % mod;
            v[t1] = invfact[t1];
        }
        for(int i = 0; i < n - 1; i++)
            for(int j = 0; j < n - 1; j++) w[i + j] = (w[i + j] + u[i] * v[j]) % mod;
        for(int k = 3; k <= n; k++) {
            i128 contribution = 0;
            for(int d = 1; d < n; d++) contribution += f[d] * chooseSmall(n - d - 1, k - 2);
            require(contribution == enumerated[k], "directed-edge coefficient vs vertex subsets");
            i64 modular = (i64) (enumerated[k] % mod);
            if(modular < 0) modular += mod;
            require(w[n - k] * invfact[k - 2] % mod == modular, "factorial convolution index");
        }
    }
    vector<IP> offset{{1, 1}, {2, 1}, {2, 2}, {1, 2}};
    require(signedArea2(offset) == 2, "signed edge sums before absolute value");
    cout << "directed areas, binomial edge contributions and convolution indices: OK\n";
}
} // namespace

int main() {
    try {
        testPolarAndAngles();
        testHalfPlane();
        testCoverageWidth();
        testTriangles();
        testConvexLocation();
        testMinkowski();
        testExactIntersections();
        testMidpoints();
        testAreaContribution();
        cout << "PASS: " << checks << " checks, seed 20261010\n";
    } catch(const exception& error) {
        cerr << "FAIL after " << checks << " checks: " << error.what() << '\n';
        return 1;
    }
}
