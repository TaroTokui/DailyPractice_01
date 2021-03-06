﻿Shader "Custom/PerlinNoise" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		#include "Noise.cginc"

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float c = perlinNoise(IN.uv_MainTex * 8);
			o.Albedo = fixed4(c, c, c, 1);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
