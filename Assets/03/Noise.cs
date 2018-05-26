using UnityEngine;
using System.Collections;

//[ExecuteInEditMode, RequireComponent(typeof(Renderer))]
public class Noise : MonoBehaviour
{

    public Material noiseMaterial;

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, noiseMaterial);
    }
}