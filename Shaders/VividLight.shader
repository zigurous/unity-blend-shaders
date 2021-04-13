Shader "Zigurous/Blending/Vivid Light"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Blend ("Blend", Color) = (0, 0, 0, 1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5
        _Metallic ("Metallic", Range(0, 1)) = 0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM

        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        fixed4 _Blend;

        half _Glossiness;
        half _Metallic;

        fixed3 colorBurn(fixed3 a, fixed3 b)
        {
            return b == 0.0 ? b : max((1.0 - ((1.0 - a) / b)), 0.0);
        }

        fixed3 colorDodge(fixed3 a, fixed3 b)
        {
            return b == 1.0 ? b : min(a / (1.0 - b), 1.0);
        }

        fixed3 vividLight(fixed3 a, fixed3 b)
        {
            return (b < 0.5) ? colorBurn(a, (2.0 * b)) : colorDodge(a, (2.0 * (b - 0.5)));
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = vividLight(c.rgb, _Blend.rgb);

            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
