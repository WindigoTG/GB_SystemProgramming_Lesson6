Shader "Custom/Task1_PlaneShader"
{
    Properties
    {
        _Tex("Texture", 2D) = "white" {}
        _Color("Main Color", COLOR) = (1,1,1,1)
        _Height("Height", float) = 0.5

    }

        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 100
            Pass
            {
                CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                sampler2D _Tex; 
                float4 _Tex_ST;
                float4 _Color;
                float _Height;

                struct v2f
                {
                    float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION; 
                };

                v2f vert(appdata_full v)
                {
                    v2f result;

                    v.vertex.xyz += v.normal * _Height * (v.texcoord.x - 0.5) * (v.texcoord.x - 0.5);

                    result.vertex = UnityObjectToClipPos(v.vertex);
                    result.uv = TRANSFORM_TEX(v.texcoord, _Tex);
                    return result;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    fixed4 color;
                    color = tex2D(_Tex, i.uv);
                    color = color * _Color;
                    return color;
                }


                ENDCG
            }
        }
}
