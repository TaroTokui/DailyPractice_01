﻿Shader "Custom/Instancing"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_Smoothness("Smoothness", Range(0, 1)) = 0
		_Metallic("Metallic", Range(0, 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }

		CGPROGRAM

		#pragma surface surf Standard vertex:vert addshadow
		#pragma instancing_options procedural:setup
		#pragma target 3.5

		#if SHADER_TARGET >= 35 && (defined(SHADER_API_D3D11) || defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE) || defined(SHADER_API_XBOXONE) || defined(SHADER_API_PSSL) || defined(SHADER_API_SWITCH) || defined(SHADER_API_VULKAN) || (defined(SHADER_API_METAL) && defined(UNITY_COMPILER_HLSLCC)))
		#define SUPPORT_STRUCTUREDBUFFER
		#endif

		#if defined(UNITY_PROCEDURAL_INSTANCING_ENABLED) && defined(SUPPORT_STRUCTUREDBUFFER)
		#define ENABLE_INSTANCING
		#endif

#include "Common.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
		float4 tangent : TANGENT;
		float4 texcoord1 : TEXCOORD1;
		float4 texcoord2 : TEXCOORD2;
		uint vid : SV_VertexID;
		fixed4 color : COLOR;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	struct CubeData
	{
		//float3 BalsePosition;
		float3 Position;
		float3 Velocity;
		float3 Rotation;
		float3 Albedo;
	};

	struct Input
	{
		float vface : VFACE;
		fixed4 color : COLOR;
	};

	half4 _Color;
	half _Smoothness;
	half _Metallic;

	float3 _CubeMeshScale;

#if defined(ENABLE_INSTANCING)
	StructuredBuffer<CubeData> _CubeDataBuffer;
	//RWStructuredBuffer<CubeData> _CubeDataBuffer;
#endif

	float4 RotateAroundYInDegrees(float4 vertex, float degrees)
	{
		float alpha = degrees * UNITY_PI / 180.0;
		float sina, cosa;
		sincos(alpha, sina, cosa);
		float2x2 m = float2x2(cosa, -sina, sina, cosa);
		return float4(mul(m, vertex.xz), vertex.yw).xzyw;
	}

	void vert(inout appdata v)
	{
#if defined(ENABLE_INSTANCING)
		// スケールと位置(平行移動)を適用
		float4x4 matrix_ = (float4x4)0;
		matrix_._11_22_33_44 = float4(_CubeMeshScale.xyz, 1.0);
		matrix_._14_24_34 += _CubeDataBuffer[unity_InstanceID].Position;
		//v.vertex = RotateAroundYInDegrees(v.vertex, 45);
		v.vertex = mul(Euler4x4(_CubeDataBuffer[unity_InstanceID].Rotation), v.vertex);
		v.vertex = mul(matrix_, v.vertex);
		v.color = fixed4(_CubeDataBuffer[unity_InstanceID].Albedo, 1);
#endif
	}

	void setup()
	{
	}

	void surf(Input IN, inout SurfaceOutputStandard o)
	{
		//o.Albedo = IN.color.rgb;
		o.Albedo = _Color;
		o.Metallic = _Metallic;
		o.Smoothness = _Smoothness;
		//o.Emission = 0.5;
		o.Normal = float3(0, 0, IN.vface < 0 ? -1 : 1);
	}

	ENDCG
	}
		FallBack "Diffuse"
}
