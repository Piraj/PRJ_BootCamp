//Credit for this script to 30K

private ["_unit", "_bullet", "_camera", "_camPos", "_camTgt"];

if !(TrainingCourse_BulletCamera) exitWith {};

_unit = _this select 0;
_bullet = _this select 6;

waitUntil {(_unit distance _bullet) > 10.0};

if (vectorMagnitudeSqr (getPos _bullet) == 0) exitWith {};

TrainingCourse_BulletCameraAbort = false;
waitUntil {!isNull (findDisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 28) then {TrainingCourse_BulletCameraAbort = true;};"]; 

_camera = "Camera" camCreate (getPos _bullet);
_camera camSetTarget _bullet;
_camera cameraEffect ["INTERNAL","BACK"];
_camera camSetFOV 0.7;

ShowCinemaBorder false;

cutText ["Press 'Enter' to exit the bullet camera", "PLAIN DOWN"];

while {(alive _bullet) && !TrainingCourse_BulletCameraAbort} do
{
	_camera camSetPos (getPos _bullet);
	_camera camCommit 0.1;
	sleep 0.001;
	if (vectorMagnitudeSqr (getPos _bullet) > 0) then
	{
		_camPos = (getPos _bullet);
		sleep 0.009;
		_camTgt = (getPos _bullet);
	};
};

cutText ["", "PLAIN DOWN"];

_camera camSetPos _camPos;
_camera camSetTarget _bullet;
_camera camCommit 2.0;
sleep 2.0;

_camera CameraEffect ["terminate", "back"];
CamDestroy _camera;
