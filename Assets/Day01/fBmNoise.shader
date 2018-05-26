Shader "Custom/fBmNoise"
{
	Properties
	{
		//_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Offset("Offset", Range(0,1)) = 0.0
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment frag

			#include "Noise.cginc"

			//sampler2D _MainTex;
			float _Offset;

			fixed4 frag(v2f_img i) : COLOR
			{
				//fixed4 c = tex2D(_MainTex, i.uv);
				//float gray = c.r * 0.3 + c.g * 0.6 + c.b * 0.1;
				//c.rgb = fixed3(gray, gray, gray);

				//float c = fBm(i.uv * 8 + float2(_Offset, _Offset) * 10);
				float c = fBm(i.uv * 8, _Offset);
				return fixed4(c, c, c, 1);
			}

			ENDCG
		}
	}
}
