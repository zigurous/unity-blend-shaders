fixed3 add(fixed3 a, fixed3 b)
{
    return min(a + b, 1.0);
}

fixed3 average(fixed3 a, fixed3 b)
{
    return (a + b) / 2.0;
}

fixed3 colorBurn(fixed3 a, fixed3 b)
{
    return b == 0.0 ? b : max((1.0 - ((1.0 - a) / b)), 0.0);
}

fixed3 colorDodge(fixed3 a, fixed3 b)
{
    return b == 1.0 ? b : min(a / (1.0 - b), 1.0);
}

fixed3 darken(fixed3 a, fixed3 b)
{
    return min(a, b);
}

fixed3 difference(fixed3 a, fixed3 b)
{
    return abs(a - b);
}

fixed3 exclusion(fixed3 a, fixed3 b)
{
    return a + b - 2.0 * a * b;
}

fixed3 glow(fixed3 a, fixed3 b)
{
    return (a == 1.0) ? a : min(b * b / (1.0 - a), 1.0);
}

fixed3 hardLight(fixed3 a, fixed3 b)
{
    return b < 0.5 ? (2.0 * a * b) : (1.0 - 2.0 * (1.0 - a) * (1.0 - b));
}

fixed3 lighten(fixed3 a, fixed3 b)
{
    return max(a, b);
}

fixed3 linearBurn(fixed3 a, fixed3 b)
{
    return max(a + b - 1.0, 0.0);
}

fixed3 linearDodge(fixed3 a, fixed3 b)
{
    return min(a + b, 1.0);
}

fixed3 linearLight(fixed3 a, fixed3 b)
{
    return b < 0.5 ? linearBurn(a, (2.0 * b)) : linearDodge(a, (2.0 * (b - 0.5)));
}

fixed3 multiply(fixed3 a, fixed3 b)
{
    return a * b;
}

fixed3 negation(fixed3 a, fixed3 b)
{
    return 1.0 - abs(1.0 - a - b);
}

fixed3 normal(fixed3 a, fixed3 b)
{
    return b;
}

fixed3 overlay(fixed3 a, fixed3 b)
{
    return a < 0.5 ? (2.0 * a * b) : (1.0 - 2.0 * (1.0 - a) * (1.0 - b));
}

fixed3 phoenix(fixed3 a, fixed3 b)
{
    return min(a, b) - max(a, b) + 1.0;
}

fixed3 pinLight(fixed3 a, fixed3 b)
{
    return (b < 0.5) ? darken(a, (2.0 * b)) : lighten(a, (2.0 * (b - 0.5)));
}

fixed3 reflect(fixed3 a, fixed3 b)
{
    return (b == 1.0) ? b : min(a * a / (1.0 - b), 1.0);
}

fixed3 screen(fixed3 a, fixed3 b)
{
    return 1.0 - (1.0 - a) * (1.0 - b);
}

fixed3 softLight(fixed3 a, fixed3 b)
{
    return (b < 0.5) ? (2.0 * a * b + a * a * (1.0 - 2.0 * b)) : (sqrt(a) * (2.0 * b - 1.0) + (2.0 * a) * (1.0 - b));
}

fixed3 subtract(fixed3 a, fixed3 b)
{
    return max(a + b - 1.0, 0.0);
}

fixed3 vividLight(fixed3 a, fixed3 b)
{
    return (b < 0.5) ? colorBurn(a, (2.0 * b)) : colorDodge(a, (2.0 * (b - 0.5)));
}

fixed3 hardMix(fixed3 a, fixed3 b)
{
    return vividLight(a, b) < 0.5 ? 0.0 : 1.0;
}
