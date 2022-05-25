Shader "Zigurous/Blending/Sprites/Screen"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}

        _BlendColor ("Blend Color", Color) = (1,1,1,1)
        _BlendTex ("Blend Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "RenderType"="Transparent"
            "Queue"="Transparent"
        }

        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite off
        Cull off

        Pass
        {

            CGPROGRAM

            #include "UnityCG.cginc"
            #include "../Blending.cginc"

            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;
            sampler2D _BlendTex;

            float4 _MainTex_ST;
            float4 _BlendTex_ST;

            fixed4 _Color;
            fixed4 _BlendColor;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv_MainTex : TEXCOORD0;
                float2 uv_BlendTex : TEXCOORD1;
                fixed4 color : COLOR;
            };

            struct v2f
            {
                float4 position : SV_POSITION;
                float2 uv_MainTex : TEXCOORD0;
                float2 uv_BlendTex : TEXCOORD1;
                fixed4 color : COLOR;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.position = UnityObjectToClipPos(v.vertex);
                o.uv_MainTex = TRANSFORM_TEX(v.uv_MainTex, _MainTex);
                o.uv_BlendTex = TRANSFORM_TEX(v.uv_BlendTex, _BlendTex);
                o.color = v.color;
                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 a = tex2D(_MainTex, i.uv_MainTex) * _Color;
                fixed4 b = tex2D(_BlendTex, i.uv_BlendTex) * _BlendColor;

                return fixed4(lerp(a, screen(a, b), _BlendColor.a), a.a) * i.color;
            }

            ENDCG
        }

    }

}
