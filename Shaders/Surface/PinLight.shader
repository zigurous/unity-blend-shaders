Shader "Zigurous/Blending/Pin Light"
{
    Properties
    {
        _MainColor ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}

        _BlendColor ("Blend Color", Color) = (1,1,1,1)
        _BlendTex ("Blend Texture", 2D) = "white" {}

        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BlendTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BlendTex;
        };

        fixed4 _MainColor;
        fixed4 _BlendColor;

        half _Glossiness;
        half _Metallic;

        fixed3 darken(fixed3 a, fixed3 b)
        {
            return min(a, b);
        }

        fixed3 lighten(fixed3 a, fixed3 b)
        {
            return max(a, b);
        }

        fixed3 pinLight(fixed3 a, fixed3 b)
        {
            return (b < 0.5) ? darken(a, (2.0 * b)) : lighten(a, (2.0 * (b - 0.5)));
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 a = lerp(_MainColor, tex2D(_MainTex, IN.uv_MainTex) * _MainColor, _MainColor.a);
            fixed4 b = tex2D(_BlendTex, IN.uv_BlendTex) * _BlendColor;
            fixed3 c = lerp(a, pinLight(a, b), _BlendColor.a);

            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
