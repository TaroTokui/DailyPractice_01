using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour {


    public Transform targetObject;

    [SerializeField]
    [Range(-50, 50)]
    public float RotationSpeed = 10;

    [SerializeField]
    [Range(0, 50)]
    public float Distance = 10;

    [SerializeField]
    [Range(0, 90)]
    public float HeightAngle = 10;

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

        mAngle = Mathf.Deg2Rad * (Time.time % 360) * RotationSpeed;

        float h = Mathf.Sin(HeightAngle * Mathf.Deg2Rad) * Distance;
        float w = Mathf.Sin(HeightAngle * Mathf.Deg2Rad) * Distance;

        float x = Mathf.Cos(mAngle) * w;
        float z = Mathf.Sin(mAngle) * w;
        
        mPosition.x = x;
        mPosition.y = h;
        mPosition.z = z;
        //this.transform.Rotate(0, (Input.GetAxis("Horizontal") * 1), 0);
        //this.transform.Translate(mPosition);
        this.transform.position = mPosition;
        this.transform.LookAt(targetObject);
    }
}
