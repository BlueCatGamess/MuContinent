using Godot;
using System;

[GlobalClass]
public partial class CharacterMovement : Node
{
	public CharacterBody3D main_actor;
	[Export] private NavigationAgent3D nav_agent;
	private Node event_bus;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		event_bus = this.GetTree().Root.GetNode("EBus");
		main_actor = this.GetParent<CharacterBody3D>();

		event_bus.Connect("GroundLeftClicked", new Callable(this, nameof(OnGroundLeftClicked)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		Move(delta);
	}

	public void SetDestination(Vector3 destination) 
	{
		nav_agent.TargetPosition = destination;
	}
	public void Move(double delta)
	{
		
		if (nav_agent.IsNavigationFinished())
		{
			main_actor.Velocity = Vector3.Zero;
			return;
		}

		Vector3 current_agent_pos = main_actor.GlobalTransform.Origin;
		Vector3 next_path_pos = nav_agent.GetNextPathPosition();

		Vector3 new_velocity = next_path_pos - current_agent_pos;
		new_velocity = new_velocity.Normalized();
		new_velocity = new_velocity * 3; //TODO Use here the character movement speed

		main_actor.Velocity = new_velocity;


		//Transform3D new_transform = main_actor.Transform.LookingAt(main_actor.Transform.Basis.Z, Vector3.Up);
		//main_actor.Transform = main_actor.Transform.InterpolateWith(new_transform, (float)(rotation_speed * delta));
		//main_actor.RotateObjectLocal(Vector3.Up, Mathf.Atan2(new_velocity.X, main_actor.Velocity.X));
		//main_actor.LookAt(new_velocity,Vector3.Up);
		main_actor.MoveAndSlide();

	}

	private void OnGroundLeftClicked(Vector3 position)
	{
		SetDestination(position);
	}
}
