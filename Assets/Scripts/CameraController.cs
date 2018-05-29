using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour {


    public Transform targetObject;

    [SerializeField]
    [Range(-10, 10)]
    public float RotationSpeed = 0;

    [SerializeField]
    [Range(0, 50)]
    public float Distance = 10;

    [SerializeField]
    [Range(0, 50)]
    public float Hight = 10;

    // private variables
    private Vector3 mPosition;
    private Vector3 mVelocity;
    private float mAngle;


	// Use this for initialization
	void Start () {
        mPosition = new Vector3(0, 0, 0);
        mAngle = 0;
    }
	
	// Update is called once per frame
	void Update () {
        //Vector3 pos = new Vector3(0,0,0);

        mAngle = (Time.time * 0.1f % 360) * 2.0f * Mathf.PI * RotationSpeed;

        float x = Mathf.Cos(mAngle) * Distance;
        float z = Mathf.Sin(mAngle) * Distance;

        //mPosition = new Vector3(x, 20, z);
        mPosition.x = x;
        mPosition.y = Hight;
        mPosition.z = z;
        //this.transform.Rotate(0, (Input.GetAxis("Horizontal") * 1), 0);
        //this.transform.Translate(mPosition);
        this.transform.position = mPosition;
        this.transform.LookAt(targetObject);
    }
}
