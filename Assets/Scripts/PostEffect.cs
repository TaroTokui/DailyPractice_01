using UnityEngine;
using System.Collections;

[ExecuteInEditMode, RequireComponent(typeof(Renderer))]
public class PostEffect : MonoBehaviour
{

    public Material noiseMaterial;

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, noiseMaterial);
    }
}