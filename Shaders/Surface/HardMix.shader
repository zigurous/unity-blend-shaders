Shader "Zigurous/Blending/Surface/Hard Mix"
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

        #include "../Blending.cginc"

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

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 a = lerp(_MainColor, tex2D(_MainTex, IN.uv_MainTex) * _MainColor, _MainColor.a);
            fixed4 b = tex2D(_BlendTex, IN.uv_BlendTex) * _BlendColor;
            fixed3 c = lerp(a, hardMix(a, b), _BlendColor.a);

            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
        }

        ENDCG
    }

    FallBack "Diffuse"
}
