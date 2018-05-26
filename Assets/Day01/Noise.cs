using System.Collections;
using UnityEngine;

[ExecuteInEditMode, RequireComponent(typeof(Renderer))]
public class Noise : MonoBehaviour {

    public Material noiseMaterial;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, noiseMaterial);
    }
}
