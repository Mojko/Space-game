extends Resource
class_name Spaceship

export(int, 0, 1000, 1.0) var health;
export(float, 0, 1000, 0.01) var speed;
export(Curve) var acceleration_curve;
export(Resource) var collision_shape;
export(GlobalPlayerData.SpaceshipType) var spaceship_type;